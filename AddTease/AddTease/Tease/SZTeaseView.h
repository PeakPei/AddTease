//
//  SZTeaseView.h
//  AddTease
//
//  Created by Smooth on 2018/6/18.
//  Copyright © 2018年 Smooth. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 吐槽图片生成器
 */
@interface SZTeaseView : UIView

@property (nonatomic, strong) UIImage *image;//图片
@property (nonatomic, strong) NSString *text;//文字

+ (instancetype)newViewFromNib;

/**
 创建图片

 @return 图片
 */
- (UIImage *)createImage;

@end
