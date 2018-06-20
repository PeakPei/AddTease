//
//  SZTeaseView.m
//  AddTease
//
//  Created by Smooth on 2018/6/18.
//  Copyright © 2018年 Smooth. All rights reserved.
//

#import "SZTeaseView.h"

@interface SZTeaseView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation SZTeaseView

#pragma mark - Lifecycle

+ (instancetype)newViewFromNib {
    return [[[NSBundle mainBundle] loadNibNamed:@"SZTeaseView" owner:nil options:nil] firstObject];
}

#pragma mark - Public

//创建图片
- (UIImage *)createImage {
    //刷新高度
    [self updateSize];
    
    //生成图片
    return [self imageWithView:self];
}

#pragma mark - Private
//根据宽度刷新高度
- (void)updateSize {
    //图片宽高比
    self.imageViewHeight.constant = (self.imageView.image.size.width > 0 ? self.imageView.frame.size.width / self.imageView.image.size.width : 1) * self.imageView.image.size.height;
    
    //重新布局
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    //刷新高度
    CGRect frame = self.frame;
    frame.size.height = CGRectGetMaxY(self.label.frame) + 20;
    self.frame = frame;
}

//生成图片
- (UIImage *)imageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - Accessors

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
}

- (UIImage *)image {
    return self.imageView.image;
}

- (void)setText:(NSString *)text {
    self.label.text = text.length > 0 ? text : @" ";
}

- (NSString *)text {
    return self.label.text;
}

@end
