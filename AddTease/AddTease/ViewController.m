//
//  ViewController.m
//  AddTease
//
//  Created by Smooth on 2018/5/6.
//  Copyright © 2018年 Smooth. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation ViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI
- (void)createView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 20;
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 30, width, width)];
    self.bgView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.bgView];
    
    CGFloat imageSpace = width / 10;
    CGFloat imageWidth = width - imageSpace * 2;
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageSpace, imageSpace - 10, imageWidth, imageWidth)];
    [self.bgView addSubview:self.imageView];
    
    CGFloat imageBottom = CGRectGetMaxY(self.imageView.frame);
    CGFloat labelHeight = width - imageBottom - 20;
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(imageSpace, imageBottom + 10, imageWidth, labelHeight)];
    self.label.textColor = [UIColor whiteColor];
    self.label.numberOfLines = 0;
    self.label.font = [UIFont systemFontOfSize:labelHeight];
    self.label.adjustsFontSizeToFitWidth = YES;
    [self.bgView addSubview:self.label];
    
    UIButton *chooseButton = [UIButton buttonWithType:UIButtonTypeSystem];
    chooseButton.frame = CGRectMake(10, width + 30, 100, 30);
    [chooseButton setTitle:@"选择图片" forState:UIControlStateNormal];
    [chooseButton addTarget:self action:@selector(chooseClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chooseButton];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    saveButton.frame = CGRectMake(self.view.bounds.size.width - 110, width + 30, 100, 30);
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(chooseButton.frame) + 10, width, 30)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.textField addTarget:self action:@selector(editingChanged) forControlEvents:UIControlEventEditingChanged];
    [self.textField addTarget:self action:@selector(editingDidBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self.textField addTarget:self action:@selector(editingDidEnd) forControlEvents:UIControlEventEditingDidEnd];
    [self.textField addTarget:self action:@selector(editingDidEnd) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:self.textField];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark - Action
- (void)chooseClick {
    [self.textField resignFirstResponder];
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

- (void)saveClick {
    [self.textField resignFirstResponder];
    
    UIImage *image = [self imageWithView:self.bgView];
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

#pragma mark - Save
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *title = @"已保存";
    if (error) {
        title = [NSString stringWithFormat:@"保存失败：%@", error];
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"已保存" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

#pragma mark - Edit
- (void)editingChanged {
    self.label.text = self.textField.text;
}

- (void)editingDidBegin {
    CGRect bounds = self.view.bounds;
    bounds.origin.y = 300;
    
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.view.bounds = bounds;
    }];
}

- (void)editingDidEnd {
    CGRect bounds = self.view.bounds;
    bounds.origin.y = 0;
    
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.view.bounds = bounds;
    }];
}

- (void)viewTap {
    [self.textField resignFirstResponder];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    self.imageView.image = info[UIImagePickerControllerEditedImage];
}

#pragma mark - Image
- (UIImage *)imageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
