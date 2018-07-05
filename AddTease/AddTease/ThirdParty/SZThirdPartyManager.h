//
//  SZThirdPartyManager.h
//  AddTease
//
//  Created by Mac on 2018/7/5.
//  Copyright © 2018年 Smooth. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SZThirdPartyShareType) {
    SZThirdPartyShareTypeWechatSession,
    SZThirdPartyShareTypeWechatTimeline,
    SZThirdPartyShareTypeWechatFavorite,
};

typedef struct {
    BOOL canOpenURL;
    BOOL handleOpenURL;
} SZThirdPartyOpenURLResult;

@interface SZThirdPartyManager : NSObject

+ (void)applicationDidFinishLaunching;
+ (SZThirdPartyOpenURLResult)handleOpenURL:(NSURL *)url;
+ (void)shareImage:(UIImage *)image type:(SZThirdPartyShareType)type;

@end
