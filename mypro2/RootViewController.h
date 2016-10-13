//
//  RootViewController.h
//  mypro2
//
//  Created by etcxm on 16/10/10.
//  Copyright © 2016年 etc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopNaviView.h"
#import "ShopToolbar.h"

#import "LinkageView.h"

#import "SectionThirdModel.h"


@class ChainReactionView;

@interface RootViewController : UIViewController<myNaviBackDelegate,backToShopAndGoodsProtocol>

@property (nonatomic,copy) NSString *shopName;;

@property (nonatomic,strong) SectionThirdModel *shopAndGoodsModel;

@end





//=================================
//1.Right单元格自定义
//2.添加购物车
//3.处理购物车
//4.商品页面
//5.评价
//6.商家
//=================================






