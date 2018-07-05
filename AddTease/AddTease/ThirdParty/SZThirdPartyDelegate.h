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

- (void)applicationDidFinishLaunching;
+ (BOOL)canOpenURL:(NSURL *)url;
- (BOOL)handleOpenURL:(NSURL *)url;

@end

#endif /* SZThirdPartyDelegate_h */
