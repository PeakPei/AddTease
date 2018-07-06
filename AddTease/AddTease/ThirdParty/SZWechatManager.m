//
//  SZWechatManager.m
//  AddTease
//
//  Created by Smooth on 2018/7/5.
//  Copyright © 2018年 Smooth. All rights reserved.
//

#import "SZWechatManager.h"
#import <WXApi.h>

#define SZ_WEICHAT_APPID @"wx1509234a3ea283b8"

@interface SZWechatManager () <WXApiDelegate>



@end

@implementation SZWechatManager

//单例
SZ_SINGLETON_DELEGATE

#pragma mark - SZThirdPartyDelegate

- (void)applicationDidFinishLaunching {
    //微信注册
    [WXApi registerApp:SZ_WEICHAT_APPID];
}

+ (BOOL)canOpenURL:(NSURL *)url {
    //是否为微信回调
    return [url.scheme isEqualToString:SZ_WEICHAT_APPID];
}

- (BOOL)handleOpenURL:(NSURL *)url {
    //回调结果
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - Share

- (void)shareToSessionWithImage:(UIImage *)image {
    [self shareWithImage:image scene:WXSceneSession];
}

- (void)shareToTimelineWithImage:(UIImage *)image {
    [self shareWithImage:image scene:WXSceneTimeline];
}

- (void)shareToFavoriteWithImage:(UIImage *)image {
    [self shareWithImage:image scene:WXSceneFavorite];
}

- (void)shareWithImage:(UIImage *)image scene:(int)scene {
    //分享图片
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = UIImagePNGRepresentation(image);
    
    //分享消息
    WXMediaMessage *message = [WXMediaMessage message];
    message.mediaObject = imageObject;
    
    //发送分享
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req];
}

#pragma mark - WXApiDelegate

- (void)onReq:(BaseReq *)req {
    
}

- (void)onResp:(BaseResp *)resp {
    NSLog(@"%@", resp);
}

@end
