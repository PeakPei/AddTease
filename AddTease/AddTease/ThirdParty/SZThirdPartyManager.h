//
//  SZThirdPartyManager.h
//  AddTease
//
//  Created by Mac on 2018/7/5.
//  Copyright © 2018年 Smooth. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 第三方分享类型

 - SZThirdPartyShareTypeWechatSession: 微信聊天
 - SZThirdPartyShareTypeWechatTimeline: 微信朋友圈
 - SZThirdPartyShareTypeWechatFavorite: 微信收藏
 */
typedef NS_ENUM(NSUInteger, SZThirdPartyShareType) {
    SZThirdPartyShareTypeWechatSession,
    SZThirdPartyShareTypeWechatTimeline,
    SZThirdPartyShareTypeWechatFavorite,
};

//第三方回调结果
typedef struct {
    BOOL canOpenURL;//是否接收URL
    BOOL handleOpenURL;//接收URL结果
} SZThirdPartyOpenURLResult;

@interface SZThirdPartyManager : NSObject

/**
 第三方平台注册
 */
+ (void)applicationDidFinishLaunching;

/**
 第三方回调

 @param url 回调链接
 @return 回调结果
 */
+ (SZThirdPartyOpenURLResult)handleOpenURL:(NSURL *)url;

/**
 分享图片

 @param image 图片
 @param type 分享类型
 */
+ (void)shareImage:(UIImage *)image type:(SZThirdPartyShareType)type;

@end
