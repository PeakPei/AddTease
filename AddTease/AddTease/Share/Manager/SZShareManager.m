//
//  SZShareManager.m
//  AddTease
//
//  Created by Mac on 2018/7/6.
//  Copyright © 2018年 Smooth. All rights reserved.
//

#import "SZShareManager.h"
#import "SZWechatManager.h"

@interface SZShareManager ()



@end

@implementation SZShareManager

//单例
SZ_SINGLETON_DELEGATE

#pragma mark - Public

+ (void)shareImage:(UIImage *)image type:(SZShareType)type {
    switch (type) {
        case SZShareTypePhotoLibrary:
            //系统相册
            
            break;
        case SZShareTypeWechatSession:
            //微信聊天
            [[SZWechatManager sharedInstance] shareToSessionWithImage:image];
            break;
        case SZShareTypeWechatTimeline:
            //微信朋友圈
            [[SZWechatManager sharedInstance] shareToTimelineWithImage:image];
            break;
        case SZShareTypeWechatFavorite:
            //微信收藏
            [[SZWechatManager sharedInstance] shareToFavoriteWithImage:image];
            break;
            
        default:
            break;
    }
}

@end
