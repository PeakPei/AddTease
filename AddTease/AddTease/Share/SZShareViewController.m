//
//  SZShareViewController.m
//  AddTease
//
//  Created by Mac on 2018/6/21.
//  Copyright © 2018年 Smooth. All rights reserved.
//

#import "SZShareViewController.h"
#import "SZNavigationController.h"

@interface SZShareViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SZShareViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageView.image = self.image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

//完成点击事件
- (IBAction)doneClick:(UIBarButtonItem *)sender {
    ((SZNavigationController *)self.navigationController).needClear = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
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
