//
//  ManageOrder.h
//  mypro2
//
//  Created by etcxm on 16/10/17.
//  Copyright © 2016年 etc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManageOrder : NSObject

@property (nonatomic,copy) NSString *orderNum;      //订单号
@property (nonatomic,copy) NSString *orderState;    //订单状态
@property (nonatomic,copy) NSString *orderEva;      //订单评价
@property (nonatomic,copy) NSString *orderEvaStart; //订单评价星级

@property (nonatomic,copy) NSString *buyer;         //购买者
@property (nonatomic,copy) NSString *shopName;      //商店名字
@property (nonatomic,copy) NSString *goodName;      //商品名字
@property (nonatomic,copy) NSString *goodPrice;     //商品价格
@property (nonatomic,copy) NSString *goodNum;       //商品数量
@property (nonatomic,copy) NSString *goodAllMoney;  //商品总金额
@property (nonatomic,copy) NSString *address;       //收货地址


@end
