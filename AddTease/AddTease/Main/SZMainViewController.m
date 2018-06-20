//
//  SZMainViewController.m
//  AddTease
//
//  Created by Smooth on 2018/6/18.
//  Copyright © 2018年 Smooth. All rights reserved.
//

#import "SZMainViewController.h"
#import "SZTeaseView.h"
#import "SZPreviewView.h"

@interface SZMainViewController () <UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewBottom;//界面底部

@property (weak, nonatomic) IBOutlet UIImageView *imageView;//图片预览
@property (weak, nonatomic) IBOutlet UIView *textBgView;//输入框边框
@property (weak, nonatomic) IBOutlet UITextView *textView;//输入框
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;//输入框高度
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;//输入提示

@property (nonatomic, strong) SZTeaseView *teaseView;//图片生成器
@property (nonatomic, strong) NSDate *reloadDate;//刷新日期

@end

@implementation SZMainViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //图片生成器
    self.teaseView = [SZTeaseView newViewFromNib];
    [self reloadImage];
    
    //初始化界面
    self.textBgView.layer.cornerRadius = 5;
    self.textBgView.layer.borderColor = [UIColor blackColor].CGColor;
    self.textBgView.layer.borderWidth = 1;
    
    //即将显示
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    //即将隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

//选择图片
- (IBAction)addClick:(UIBarButtonItem *)sender {
    [self.view endEditing:YES];
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

//保存图片
- (IBAction)saveClick:(UIBarButtonItem *)sender {
    [self.view endEditing:YES];
    
    UIImage *image = self.imageView.image;
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

//背景点击
- (IBAction)viewTap:(UITapGestureRecognizer *)sender {
    //收起键盘
    [self.view endEditing:YES];
}

//图片预览
- (IBAction)imageClick:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    
    [SZPreviewView showWithImage:self.imageView.image];
}

#pragma mark - UITextViewDelegate

//文字变化
- (void)textViewDidChange:(UITextView *)textView {
    //刷新图片
    self.teaseView.text = self.textView.text;
    self.reloadDate = [NSDate dateWithTimeIntervalSinceNow:1];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.reloadDate timeIntervalSinceNow] <= 0) {
            [self reloadImage];
        }
    });
    
    //调整输入框高度
    CGFloat height = [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, MAXFLOAT)].height;
    self.textViewHeight.constant = MIN(height, 70);
    
    //输入提示
    self.placeholderLabel.hidden = self.textView.text.length > 0;
}

#pragma mark - Image

//刷新图片
- (void)reloadImage {
    self.imageView.image = [self.teaseView createImage];
}

#pragma mark - UIImagePickerControllerDelegate

//选择图片回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    self.teaseView.image = info[UIImagePickerControllerOriginalImage];
    [self reloadImage];
}

#pragma mark - Save

//保存图片回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    //弹窗提示
    NSString *title = @"已保存";
    NSString *message = nil;
    if (error) {
        title = @"保存失败";
        message = [NSString stringWithFormat:@"%@", error];
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

#pragma mark - Keyboard

- (void)keyboardWillShowNotification:(NSNotification *)notif {
    //结束高度
    NSValue *endFrameValue = notif.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGFloat endHeight = endFrameValue.CGRectValue.size.height;
    
    //动画时间
    NSNumber *durationNum = notif.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    double duration = durationNum.doubleValue;
    
    //动画曲线
    NSNumber *curveNum = notif.userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve curve = (UIViewAnimationCurve)curveNum.unsignedIntegerValue;
    
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets insets = self.additionalSafeAreaInsets;
        insets.bottom = endHeight;
        self.additionalSafeAreaInsets = insets;
    }
    else {
        self.viewBottom.constant = endHeight;
    }
    
    [UIView beginAnimations:@"KeyBoardFollow" context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [self.view layoutIfNeeded];
    [UIView commitAnimations];
}

- (void)keyboardWillHideNotification:(NSNotification *)notif {
    NSNumber *durationNum = notif.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    double duration = durationNum.doubleValue;
    
    NSNumber *curveNum = notif.userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve curve = (UIViewAnimationCurve)curveNum.unsignedIntegerValue;
    
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets insets = self.additionalSafeAreaInsets;
        insets.bottom = 0;
        self.additionalSafeAreaInsets = insets;
    }
    else {
        self.viewBottom.constant = 0;
    }
    
    [UIView beginAnimations:@"KeyBoardFollow" context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [self.view layoutIfNeeded];
    [UIView commitAnimations];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
