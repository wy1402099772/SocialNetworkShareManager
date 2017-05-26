//
//  GXShareTaskDelegate.h
//  GXShareManager
//
//  Created by wyan assert on 11/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GXShareTaskDelegate <NSObject>

- (void)requestShareManagerToShowAlert:(NSString *)title
                               message:(NSString *)message
                           confirmInfo:(NSString *)confirmInfo
                            cancelInfo:(NSString *)cancelInfo
                                 delay:(NSUInteger)delayInterval
                            completion:(void (^)(BOOL))block;

@end
