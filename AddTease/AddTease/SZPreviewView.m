//
//  SZPreviewView.m
//  AddTease
//
//  Created by Smooth on 2018/6/18.
//  Copyright © 2018年 Smooth. All rights reserved.
//

#import "SZPreviewView.h"

@interface SZPreviewView ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;//滑动界面

@property (weak, nonatomic) IBOutlet UIImageView *imageView;//图片
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;//图片高度

@end

@implementation SZPreviewView

#pragma mark - Lifecycle

+ (instancetype)newViewFromNib {
    return [[[NSBundle mainBundle] loadNibNamed:@"SZPreviewView" owner:nil options:nil] firstObject];
}

#pragma mark - Public

//展示预览
+ (void)showWithImage:(UIImage *)image {
    SZPreviewView *view = [SZPreviewView newViewFromNib];
    view.frame = [UIScreen mainScreen].bounds;
    [view updateUIWithImage:image];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

#pragma mark - Private

- (void)updateUIWithImage:(UIImage *)image {
    //图片
    self.imageView.image = image;
    //图片高度
    self.imageViewHeight.constant = (image.size.width > 0 ? self.frame.size.width / image.size.width : 1) * image.size.height;
    
    //图片居中
    self.scrollView.contentInset = UIEdgeInsetsMake(MAX((self.frame.size.height - self.imageViewHeight.constant) / 2, 0), 0, 0, 0);
}

#pragma mark - Action

//背景点击消失
- (IBAction)bgClick:(UITapGestureRecognizer *)sender {
    [self removeFromSuperview];
}

@end
