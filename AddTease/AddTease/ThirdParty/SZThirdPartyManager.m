//
//  SZThirdPartyManager.m
//  AddTease
//
//  Created by Mac on 2018/7/5.
//  Copyright © 2018年 Smooth. All rights reserved.
//

#import "SZThirdPartyManager.h"
#import "SZWechatManager.h"

@implementation SZThirdPartyManager

+ (void)applicationDidFinishLaunching {
    [[SZWechatManager sharedInstance] applicationDidFinishLaunching];
}

+ (SZThirdPartyOpenURLResult)handleOpenURL:(NSURL *)url {
    SZThirdPartyOpenURLResult result = {YES, NO};
    
    if ([SZWechatManager canOpenURL:url]) {
        result.handleOpenURL = [[SZWechatManager sharedInstance] handleOpenURL:url];
    }
    else {
        result.canOpenURL = NO;
    }
    
    return result;
}

+ (void)shareImage:(UIImage *)image type:(SZThirdPartyShareType)type {
    switch (type) {
        case SZThirdPartyShareTypeWechatSession:
            [[SZWechatManager sharedInstance] shareToSessionWithImage:image];
            break;
        case SZThirdPartyShareTypeWechatTimeline:
            [[SZWechatManager sharedInstance] shareToTimelineWithImage:image];
            break;
        case SZThirdPartyShareTypeWechatFavorite:
            [[SZWechatManager sharedInstance] shareToFavoriteWithImage:image];
            break;
            
        default:
            break;
    }
}

@end
