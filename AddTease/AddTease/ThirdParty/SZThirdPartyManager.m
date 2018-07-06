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

#pragma mark - Public

+ (void)applicationDidFinishLaunching {
    //微信注册
    [[SZWechatManager sharedInstance] applicationDidFinishLaunching];
}

+ (SZThirdPartyOpenURLResult)handleOpenURL:(NSURL *)url {
    SZThirdPartyOpenURLResult result = {YES, NO};
    
    if ([SZWechatManager canOpenURL:url]) {
        //微信回调
        result.handleOpenURL = [[SZWechatManager sharedInstance] handleOpenURL:url];
    }
    else {
        //非第三方回调
        result.canOpenURL = NO;
    }
    
    return result;
}

@end
