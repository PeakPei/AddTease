//
//  SZShareViewController.m
//  AddTease
//
//  Created by Smooth on 2018/6/21.
//  Copyright © 2018年 Smooth. All rights reserved.
//

#import "SZShareViewController.h"
#import "SZNavigationController.h"
#import "SZThirdPartyManager.h"

@interface SZShareViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;//图片预览

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;//分享平台选择

@property (weak, nonatomic) IBOutlet UIButton *shareButton;//系统分享按钮

@property (nonatomic, strong) NSArray *shareArray;//可用分享平台列表

@end

@implementation SZShareViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //系统分享按钮圆形
    self.shareButton.layer.cornerRadius = 50;
    
    //预览图
    self.imageView.image = self.image;
    
    //生成可用分享平台列表
    self.shareArray = [self shareArrayByUsable];
    //刷新分享平台
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.shareArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SZShareItemCell" forIndexPath:indexPath];
    
    NSDictionary *dic = self.shareArray[indexPath.item];
//    ((UIImageView *)[cell.contentView viewWithTag:1]).image = [UIImage imageNamed:dic[@"imageName"]];
    ((UILabel *)[cell.contentView viewWithTag:2]).text = dic[@"title"];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = collectionView.frame.size.width / 4;
    return CGSizeMake(width, width + 20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *type = self.shareArray[indexPath.item][@"type"];
    [SZThirdPartyManager shareImage:self.image type:type.unsignedIntegerValue];
}

#pragma mark - Action

//完成点击事件
- (IBAction)doneClick:(UIBarButtonItem *)sender {
    ((SZNavigationController *)self.navigationController).needClear = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//系统分享
- (IBAction)shareSystemClick {
    if (!self.image) {
        return;
    }
    
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:@[self.image] applicationActivities:nil];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

#pragma mark - Private

//生成可用分享平台列表
- (NSArray *)shareArrayByUsable {
    return @[[self shareItemDicWithImageName:nil title:@"微信好友" type:SZThirdPartyShareTypeWechatSession],
             [self shareItemDicWithImageName:nil title:@"微信朋友圈" type:SZThirdPartyShareTypeWechatTimeline],
             [self shareItemDicWithImageName:nil title:@"微信收藏" type:SZThirdPartyShareTypeWechatFavorite]];
}

//生成分享平台项
- (NSDictionary *)shareItemDicWithImageName:(NSString *)imageName title:(NSString *)title type:(SZThirdPartyShareType)type {
    return @{@"imageName": imageName ? imageName : @"",
             @"title": title ? title : @"",
             @"type": @(type)};
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
