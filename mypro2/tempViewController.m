//
//  tempViewController.m
//  mypro2
//
//  Created by etcxm on 16/10/11.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "tempViewController.h"
#import "RootViewController.h"
#import "CreatPlist.h"

@interface tempViewController ()

@end

@implementation tempViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(SectionThirdModel *)shopAndGoodsModel
{
    if (!_shopAndGoodsModel)
    {
        _shopAndGoodsModel = [[SectionThirdModel alloc]init];
        
        _shopAndGoodsModel.actionInfo1  = @"活动1。。。";
        _shopAndGoodsModel.actionInfo2  = @"活动2。。。!!!~~~@@@###$$$";
        _shopAndGoodsModel.actionInfo3  = @"活动3。。。!@#!$!@$!@#!#";
        _shopAndGoodsModel.actionInfo4  = @"活动4。。。";
        
        _shopAndGoodsModel.storeName    = @"mdl";
        _shopAndGoodsModel.storeImage   = @"store_name03";
        _shopAndGoodsModel.sell         = @"月销售：30单";
        _shopAndGoodsModel.comment      = @"评论:很好";
        _shopAndGoodsModel.sellPrace    = @"15";
        _shopAndGoodsModel.maxTime      = @"30";
        _shopAndGoodsModel.distance     = @"10KM";
    }
    return _shopAndGoodsModel;
}


- (IBAction)buttonClick:(id)sender
{
    
//    [CreatPlist CreatGoodsPlist];
    RootViewController *tempRoot = [[RootViewController alloc]init];
    tempRoot.shopAndGoodsModel = self.shopAndGoodsModel;
    [self presentViewController:tempRoot animated:YES completion:^{
        
    }];
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
