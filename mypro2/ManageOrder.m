//
//  ManageOrder.m
//  mypro2
//
//  Created by etcxm on 16/10/17.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "ManageOrder.h"

@implementation ManageOrder

- (NSString *)description
{
    return [NSString stringWithFormat:@"订单号:%@ ,订单状态:%@ ,订单评价:%@ ,订单评价星级:%@ 购买者:%@ ,商店名字:%@ ,商品名字:%@ ,商品价格:%@ , 商品数量:%@ , 商品总金额:%@ , 收货地址:%@ 。",_orderNum,_orderState,_orderEva,_orderEvaStart,_buyer,_shopName,_goodName,_goodPrice,_goodNum,_goodAllMoney,_address];
}


@end
