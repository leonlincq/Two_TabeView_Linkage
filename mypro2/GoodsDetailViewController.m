//
//  GoodsDetailViewController.m
//  mypro2
//
//  Created by etcxm on 16/10/21.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "GoodsDetailViewController.h"

@interface GoodsDetailViewController ()

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [
     super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    imageView.image = [UIImage imageNamed:[self.goodsDetailDic objectForKey:@"GoodsImage"]];
    [self.view addSubview:imageView];
    
//[tempDic objectForKey:@"GoodsName"]
//
//    [tempDic objectForKey:@"GoodsPrice"]
//    [tempDic objectForKey:@"PreferentPrice"]
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
