//
//  GXShareAlbumUtil.h
//  GXShareManager
//
//  Created by wyan assert on 09/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GXShareAlbumUtil : NSObject

+ (void)configAlbumsWithName:(NSString *)albumName completion:(void(^)(BOOL success, NSError *error))block;

+ (void)saveImage:(UIImage *)image toAlbum:(NSString *)name completion:(void (^)(BOOL))block;

+ (void)saveVideo:(NSURL *)videoURL toAlbum:(NSString *)name completion:(void (^)(BOOL))block;

+ (NSURL *)getLastAssetURL;

@end
