//
//  SZWechatManager.h
//  AddTease
//
//  Created by Smooth on 2018/7/5.
//  Copyright © 2018年 Smooth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SZThirdPartyDelegate.h"
#import "SZSingletonDelegate.h"

@interface SZWechatManager : NSObject <SZSingletonDelegate, SZThirdPartyDelegate>

/**
 分享图片至微信聊天

 @param image 图片
 */
- (void)shareToSessionWithImage:(UIImage *)image;
/**
 分享图片至微信朋友圈

 @param image 图片
 */
- (void)shareToTimelineWithImage:(UIImage *)image;
/**
 分享图片至微信收藏

 @param image 图片
 */
- (void)shareToFavoriteWithImage:(UIImage *)image;

@end
