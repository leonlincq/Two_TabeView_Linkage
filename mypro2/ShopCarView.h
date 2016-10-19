//
//  ShopCarView.h
//  mypro2
//
//  Created by etcxm on 16/10/11.
//  Copyright © 2016年 etc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol suretToOrderProtocol <NSObject>

-(void)presentToOrder;

@end


@interface ShopCarView : UIView

@property (nonatomic,strong) NSString *shopCarPrice;
@property (nonatomic,strong) NSString *sentPrice;

@property (nonatomic,strong) id<suretToOrderProtocol> toOrderDelegate;

@end
