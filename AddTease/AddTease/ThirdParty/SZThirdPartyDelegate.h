//
//  SZThirdPartyDelegate.h
//  AddTease
//
//  Created by Mac on 2018/7/5.
//  Copyright © 2018年 Smooth. All rights reserved.
//

#ifndef SZThirdPartyDelegate_h
#define SZThirdPartyDelegate_h

#import <UIKit/UIKit.h>

@protocol SZThirdPartyDelegate <NSObject>

/**
 本平台注册
 */
- (void)applicationDidFinishLaunching;

/**
 判断是否为本平台回调

 @param url 回调链接
 @return 是否本平台回调
 */
+ (BOOL)canOpenURL:(NSURL *)url;

/**
 回调结果

 @param url 回调链接
 @return 回调结果
 */
- (BOOL)handleOpenURL:(NSURL *)url;

@end

#endif /* SZThirdPartyDelegate_h */
