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

#import "SectionThirdModel.h"

@class ChainReactionView;

@interface RootViewController : UIViewController<myNaviBackDelegate,backToShopAndGoodsProtocol>

@property (nonatomic,copy) NSString *shopName;;

@property (nonatomic,strong) SectionThirdModel *shopAndGoodsModel;

@end





//=================================
//1.点击商店，商店信息ToolBar要显示
//2.Right单元格自定义
//3.添加购物车
//4.处理购物车
//5.商品页面
//=================================






