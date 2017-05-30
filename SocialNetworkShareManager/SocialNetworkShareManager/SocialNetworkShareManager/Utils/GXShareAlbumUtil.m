//
//  GXShareAlbumUtil.m
//  GXShareManager
//
//  Created by wyan assert on 09/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "GXShareAlbumUtil.h"

@implementation GXShareAlbumUtil

+ (void)configAlbumsWithName:(NSString *)albumName completion:(void (^)(BOOL, NSError *))block {
    [self createPhotoAlbum:albumName completion:block];
}

+ (void)saveImage:(id)image toAlbum:(NSString *)name completion:(void (^)(BOOL))block {
    [self savePhotos:image IntoAlbum:name completion:^(BOOL success, NSError *error) {
        if(block) {
            block(success);
        }
    }];
}

+ (void)saveVideo:(NSURL *)videoURL toAlbum:(NSString *)name completion:(void (^)(BOOL))block {
    [self saveVideo:videoURL IntoAlbum:name completion:^(BOOL success, NSError *error) {
        if(block) {
            block(success);
        }
    }];
}

+ (NSURL *)getLastImageURL:(PHAssetMediaType)mediaType {
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *fetchResult = [PHAsset fetchAssetsWithMediaType:mediaType options:fetchOptions];
    PHAsset *lastAsset = [fetchResult lastObject];
    return [NSURL URLWithString:lastAsset.localIdentifier];
}

+ (void)getLastImageALURL:(PHAssetMediaType)mediaType completion:(void (^)(NSURL *))block {
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *fetchResult = [PHAsset fetchAssetsWithMediaType:mediaType options:fetchOptions];
    PHAsset *lastAsset = [fetchResult lastObject];
    NSString *phId = lastAsset.localIdentifier;
    NSRange idRange = [phId rangeOfString:@"/"];
    phId = [phId substringToIndex:idRange.location];
    if(lastAsset.mediaType == PHAssetMediaTypeImage) {
        //暂时不支持photo
        if(block) {
            block(nil);
        }
    } else if (lastAsset.mediaType == PHAssetMediaTypeVideo) {
        PHVideoRequestOptions *option = [[PHVideoRequestOptions alloc] init];
        
        [[PHImageManager defaultManager] requestAVAssetForVideo:lastAsset
                                                        options:option
                                                  resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                                                      if([info objectForKey:@"PHImageFileSandboxExtensionTokenKey"] && [[info objectForKey:@"PHImageFileSandboxExtensionTokenKey"] isKindOfClass:[NSString class]]) {
                                                          NSRange range = [[info objectForKey:@"PHImageFileSandboxExtensionTokenKey"] rangeOfString:@"/" options:NSBackwardsSearch];
                                                          if(range.length > 0) {
                                                              NSString *name = [[info objectForKey:@"PHImageFileSandboxExtensionTokenKey"] substringFromIndex:range.location + range.length];
                                                              NSRange dotRange = [name rangeOfString:@"."];
                                                              if(dotRange.length > 0) {
                                                                  NSString *ext = [name substringFromIndex:dotRange.length + dotRange.location].lowercaseString;
                                                                  if(ext.length && phId.length) {
                                                                      if(block) {
                                                                          NSString *result = [NSString stringWithFormat:@"assets-library://asset/asset.%@?id=%@&ext=%@", ext, phId, ext];
                                                                          block([NSURL URLWithString:result]);
                                                                      }
                                                                  } else {
                                                                      if(block) {
                                                                          block(nil);
                                                                      }
                                                                  }
                                                              } else {
                                                                  if(block) {
                                                                      block(nil);
                                                                  }
                                                              }
                                                          } else {
                                                              if(block) {
                                                                  block(nil);
                                                              }
                                                          }
                                                      } else {
                                                          if(block) {
                                                              block(nil);
                                                          }
                                                      }
                                                  }];
    } else {
        //暂时不支持live photo
        if(block) {
            block(nil);
        }
    }
}


#pragma mark - Private
+ (void)createPhotoAlbum:(NSString *)albumName completion:(void(^)(BOOL success, NSError *error))completion
{
    PHCollection *collection = [self getAlbumWithName:albumName];
    if(!collection)
    {
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumName];
        } completionHandler:^(BOOL success, NSError *error) {
            if(!success)
            {
                NSLog(@"create album error : %@", error);
            }
            if(completion)
            {
                completion(success, error);
            }
        }];
    }
    else
    {
        if(completion)
        {
            completion(YES, nil);
        }
    }
}

+ (PHCollection *)getAlbumWithName:(NSString *)name
{
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    PHCollection *collection = nil;
    for (collection in topLevelUserCollections) {
        if ([collection.localizedTitle isEqualToString:name]) {
            break;
        }
        collection = nil;
    }
    return collection;
}

+ (void)savePhotos:(UIImage *)image IntoAlbum:(NSString *)albumName completion:(void(^)(BOOL success, NSError *error))completion
{
    [self createPhotoAlbum:albumName completion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"create album error : %@", error);
            return;
        }
        // Add it to the photo library
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
            PHCollection *album = [self getAlbumWithName:albumName];
            if (album) {
                PHAssetCollectionChangeRequest *assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:(PHAssetCollection *)album];
                PHObjectPlaceholder *placeHolder = [assetChangeRequest placeholderForCreatedAsset];
                if(placeHolder)
                {
                    [assetCollectionChangeRequest addAssets:@[placeHolder]];
                }
            }
        } completionHandler:^(BOOL success, NSError *error) {
            if (!success) {
                NSLog(@"Error creating asset: %@", error);
            }
            if(completion)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(success, error);
                });
            }
        }];
    }];
}

+ (void)saveVideo:(NSURL *)url IntoAlbum:(NSString *)albumName completion:(void(^)(BOOL success, NSError *error))completion
{
    [self createPhotoAlbum:albumName completion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"create album error : %@", error);
            return;
        }
        // Add it to the photo library
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:url];
            PHCollection *album = [self getAlbumWithName:albumName];
            if (album) {
                PHAssetCollectionChangeRequest *assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:(PHAssetCollection *)album];
                [assetCollectionChangeRequest addAssets:@[[assetChangeRequest placeholderForCreatedAsset]]];
            }
        } completionHandler:^(BOOL success, NSError *error) {
            if (!success) {
                NSLog(@"Error creating asset: %@", error);
            }
            if(completion)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(success, error);
                });
            }
        }];
    }];
}

@end
