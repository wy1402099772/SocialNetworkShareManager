//
//  SocialNetworkShareAlbumUtil.h
//  SocialNetworkShareManager
//
//  Created by wyan assert on 09/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SocialNetworkShareAlbumUtil : NSObject

+ (void)configAlbumsWithName:(NSString *)albumName completion:(void(^)(BOOL success, NSError *error))block;

+ (void)saveImage:(UIImage *)image toAlbum:(NSString *)name completion:(void (^)(BOOL))block;

@end
