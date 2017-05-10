//
//  SocialNetworkShareAlbumUtil.m
//  SocialNetworkShareManager
//
//  Created by wyan assert on 09/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "SocialNetworkShareAlbumUtil.h"

@import Photos;

@implementation SocialNetworkShareAlbumUtil

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

+ (NSURL *)getLastAssetURL {
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *fetchResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:fetchOptions];
    PHAsset *lastAsset = [fetchResult lastObject];
    return [NSURL URLWithString:lastAsset.localIdentifier];
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


@end
