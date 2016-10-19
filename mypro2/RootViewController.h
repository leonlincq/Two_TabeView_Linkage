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
#import "ShopCarView.h"

#import "LinkageView.h"

#import "SectionThirdModel.h"

@class ChainReactionView;

@interface RootViewController : UIViewController<myNaviBackDelegate,backToShopAndGoodsProtocol,suretToOrderProtocol>

@property (nonatomic,copy) NSString *shopName;;

@property (nonatomic,strong) SectionThirdModel *shopAndGoodsModel;

@end

typedef enum
{
    Algo_Add = 0x00,
    Algo_Sub = 0x01
}Algo;



//=================================
//1.添加购物车               
//2.处理购物车
//3.商品页面
//=================================






