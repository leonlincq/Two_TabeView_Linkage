//
//  OpOrder.h
//  mypro2
//
//  Created by etcxm on 16/10/17.
//  Copyright © 2016年 etc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDatabase.h"
#import "ManageOrder.h"

typedef NS_ENUM(NSUInteger,OrderSelect)
{
    OrderSelect_Buyer  = 0x00
};

typedef NS_ENUM(NSUInteger,OrderUpData)
{
    OrderUpData_OrderState  = 0x00
};


@interface OpOrder : NSObject

/** 创建表格 */
+(FileState)creatTableForOrder;
/** 添加信息 （ManageOrder模型全填） */
+(FileState)addToOrder:(ManageOrder *)orderdata;
/** 选择用户 （orderdata模型看情况，statu选择要查看的） */
+(FileState)selectOrderByWho:(ManageOrder *)orderdata withStatu:(OrderSelect)statu andSaveArray:(NSMutableArray**)array;
///** 删除用户 */
//-(FileState)deletOrderByWho:(ManageOrder *)orderdata andWare:(NSString *)shopname;
/** 更新用户 */
+(FileState)upOrderData:(ManageOrder *)orderdata withStatu:(OrderUpData)statu;


@end
