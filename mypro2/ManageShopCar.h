//
//  ManageShopCar.h
//  mypro2
//
//  Created by etcxm on 16/10/17.
//  Copyright © 2016年 etc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManageShopCar : NSObject


@property (nonatomic,copy) NSString *buyer;         //用户名
@property (nonatomic,copy) NSString *shopName;      //商店名称
@property (nonatomic,copy) NSString *goodName;      //商品名称
@property (nonatomic,copy) NSString *goodPrice;     //商品单价
@property (nonatomic,copy) NSString *goodNum;       //商品数量
@property (nonatomic,copy) NSString *goodAllMoney;  //商品总价

//-(void)printfBuyer;
//-(void)printfShopName;
//-(void)printfGoodName;
//-(void)printfGoodPrice;
//-(void)printfGoodNum;
//-(void)printfGoodAllMoney;
//-(void)printfAllData;

@end
