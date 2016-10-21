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

#import "ManageShopCar.h"
#import "OpShopCar.h"

#import "ManageOrder.h"
#import "OpOrder.h"

#import "OrderViewController.h"



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
        
//        _shopAndGoodsModel.actionInfo1  = @"活动1。。。";
//        _shopAndGoodsModel.actionInfo2  = @"活动2。。。!!!~~~@@@###$$$";
//        _shopAndGoodsModel.actionInfo3  = @"活动3。。。!@#!$!@$!@#!#";
//        _shopAndGoodsModel.actionInfo4  = @"活动4。。。";
        
        _shopAndGoodsModel.storeName    = @"转转乐(湖里万达店)";
//        _shopAndGoodsModel.storeName    = @"意享披萨(钟宅店)";
//        _shopAndGoodsModel.storeName    = @"QQ脆皮鸡排";
//        _shopAndGoodsModel.storeName    = @"骨之味";
//        _shopAndGoodsModel.storeName    = @"甜丫丫";
//        _shopAndGoodsModel.storeName    = @"正宗骨汤麻辣烫";
//        _shopAndGoodsModel.storeName    = @"食尚煲仔饭(蔡塘店)";
//        _shopAndGoodsModel.storeName    = @"鲜芋仙";
//        _shopAndGoodsModel.storeName    = @"老塞行动咖啡";
//        _shopAndGoodsModel.storeName    = @"85°C";
        
//        _shopAndGoodsModel.storeImage   = @"store_name03";
//        _shopAndGoodsModel.sell         = @"月销售：30单";
//        _shopAndGoodsModel.comment      = @"评论:很好";
//        _shopAndGoodsModel.sellPrace    = @"15";
//        _shopAndGoodsModel.maxTime      = @"30";
//        _shopAndGoodsModel.distance     = @"10KM";
        
        

        
    }
    return _shopAndGoodsModel;
}


- (IBAction)buttonClick:(id)sender
{
//    [CreatPlist CreatGoodsPlist];
    
    [OpShopCar creatTableForShopCar];
    [OpOrder creatTableForOrder];

    
#if 1
    RootViewController *tempRoot = [[RootViewController alloc]init];
    tempRoot.shopAndGoodsModel = self.shopAndGoodsModel;
    [self presentViewController:tempRoot animated:YES completion:^{
        
    }];
#else

    OrderViewController *tempRoot1 = [[OrderViewController alloc]init];
    tempRoot1.title = @"ONE_1";
    UINavigationController *orderNavi1 = [[UINavigationController alloc]initWithRootViewController:tempRoot1];
    
    OrderViewController *tempRoot2 = [[OrderViewController alloc]init];
    tempRoot2.title = @"TWO_2";
    
    OrderViewController *tempRoot3 = [[OrderViewController alloc]init];
    tempRoot3.title = @"THREE_3";
    UINavigationController *orderNavi3 = [[UINavigationController alloc]initWithRootViewController:tempRoot3];
    
    OrderViewController *tempRoot4 = [[OrderViewController alloc]init];
    tempRoot4.title = @"FOUR_4";
    
    
    UITabBarController *temp = [[UITabBarController alloc]init];
    
    [temp setViewControllers:@[orderNavi1,tempRoot2,orderNavi3,tempRoot4]];
    
    [self presentViewController:temp animated:YES completion:^{
        
    }];
#endif
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
