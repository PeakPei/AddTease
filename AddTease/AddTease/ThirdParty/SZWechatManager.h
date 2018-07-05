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

- (void)shareToSessionWithImage:(UIImage *)image;
- (void)shareToTimelineWithImage:(UIImage *)image;
- (void)shareToFavoriteWithImage:(UIImage *)image;

@end
