//
//  ShopToolbar.h
//  mypro2
//
//  Created by etcxm on 16/10/12.
//  Copyright © 2016年 etc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SectionThirdModel.h"

@protocol backToShopAndGoodsProtocol <NSObject>

-(void)backToShopAndGoods;

@end

@interface ShopToolbar : UIToolbar

@property (nonatomic,strong) id<backToShopAndGoodsProtocol> backDelegate;

@property (nonatomic,strong) SectionThirdModel *shopData;

@end
