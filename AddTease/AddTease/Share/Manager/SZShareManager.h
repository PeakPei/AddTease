//
//  SZShareManager.h
//  AddTease
//
//  Created by Mac on 2018/7/6.
//  Copyright © 2018年 Smooth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZSingletonDelegate.h"

/**
 第三方分享类型
 
 - SZShareTypePhotoLibrary: 系统相册
 - SZShareTypeWechatSession: 微信聊天
 - SZShareTypeWechatTimeline: 微信朋友圈
 - SZShareTypeWechatFavorite: 微信收藏
 */
typedef NS_ENUM(NSUInteger, SZShareType) {
    SZShareTypePhotoLibrary,
    SZShareTypeWechatSession,
    SZShareTypeWechatTimeline,
    SZShareTypeWechatFavorite,
    
    SZShareTypeCount
};

/**
 分享管理类
 */
@interface SZShareManager : NSObject <SZSingletonDelegate>

/**
 分享图片
 
 @param image 图片
 @param type 分享类型
 */
+ (void)shareImage:(UIImage *)image type:(SZShareType)type;

@end
