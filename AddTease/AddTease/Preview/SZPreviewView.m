//
//  SZPreviewView.m
//  AddTease
//
//  Created by Smooth on 2018/6/18.
//  Copyright © 2018年 Smooth. All rights reserved.
//

#import "SZPreviewView.h"

@interface SZPreviewView () <UIScrollViewDelegate>

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
    [view showByAnimation];
}

#pragma mark - Private

- (void)updateUIWithImage:(UIImage *)image {
    //图片
    self.imageView.image = image;
    //图片高度
    self.imageViewHeight.constant = MAX(((image.size.width > 0 ? self.frame.size.width / image.size.width : 1) * image.size.height), self.frame.size.height + 1);
}

//显示动画
- (void)showByAnimation {
    self.scrollView.contentOffset = CGPointMake(0, -self.frame.size.height);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }];
}

//消失动画
- (void)removeByAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentOffset = CGPointMake(0, -self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Action

//背景点击消失
- (IBAction)bgClick:(UITapGestureRecognizer *)sender {
    [self removeByAnimation];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //向下拖动时改变背景透明度
    CGFloat alpha = 1;
    if (scrollView.contentOffset.y < 0) {
        alpha = 1 + (scrollView.contentOffset.y / self.frame.size.height);
    }
    
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:alpha];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //向下拖动一定距离后消失
    if (scrollView.contentOffset.y < -(self.frame.size.height / 5)) {
        [self removeFromSuperview];
    }
}

@end
