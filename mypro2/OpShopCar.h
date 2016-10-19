//
//  OpShopCar.h
//  mypro2
//
//  Created by etcxm on 16/10/17.
//  Copyright © 2016年 etc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "ManageShopCar.h"

typedef NS_ENUM(NSUInteger,ShopCarUpData)
{
    ShopCarUpData_GoodsNum  = 0x00

};

@interface OpShopCar : NSObject

/** 创建表格 */
+(FileState)creatTableForShopCar;
/** 添加信息 （ManageShopCar模型全填） */
+(FileState)addToShopCar:(ManageShopCar *)shopcardata;
/** 选择用户 （buyer == nil,打印所以用户） */
+(FileState)selectShopCarByWho:(NSString*)buyer andSaveArray:(NSMutableArray**)array;
/** 删除用户 （ManageShopCar模型中的buyer，shopName，goodName 一定要填，其他随意，buyer == nil 删表）*/
+(FileState)deletShopCarByWho:(ManageShopCar *)shopcardata andWare:(NSString *)shopname;
/** 更新用户 （ManageShopCar模型中的buyer，shopName，goodName 一定要填，其他随意） */
+(FileState)upShopCarData:(ManageShopCar *)shopcardata withStatu:(ShopCarUpData)statu;

@end
