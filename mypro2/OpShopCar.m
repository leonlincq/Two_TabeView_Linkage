//
//  OpShopCar.m
//  mypro2
//
//  Created by etcxm on 16/10/17.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "OpShopCar.h"

@implementation OpShopCar



//=====================================================
//  描述:路径名设置
//  输入:filename:文件名
//  返回:路径
//=====================================================
-(NSString *)filepath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"MyData.sqlite"];
}

//=====================================================
//  描述:创建表格
//  返回:错误代码
//=====================================================
+(FileState)creatTableForShopCar
{
    FileState tempsta = FileState_OK;
    FMDatabase *fileop = [FMDatabase databaseWithPath:SqliteDataPath];
    
    if ([fileop open] == NO )
    {
        tempsta = FileState_OpenError;
        return tempsta;
    }
    
    if ([fileop executeUpdate:@"CREATE TABLE IF NOT EXISTS ShopCar (buyer TEXT , shopName TEXT ,goodName TEXT ,goodPrice TEXT,goodNum TEXT,goodAllMoney TEXT)"] == NO)
    {
        [fileop close];
        tempsta = FileState_BuildError;
        return tempsta;
    }
    
    [fileop close];
    return tempsta;
}

//=====================================================
//  描述:在选定表格添加购物信息() （ManageShopCar模型全填）
//  输入:shopcardata:添加的新的购物信息
//  返回:错误代码
//=====================================================
+(FileState)addToShopCar:(ManageShopCar *)shopcardata
{
    FileState tempsta = FileState_OK;
    FMDatabase *fileop = [FMDatabase databaseWithPath:SqliteDataPath];
    
    if ([fileop open] == NO )
    {
        tempsta = FileState_OpenError;
        return tempsta;
    }
    
    if ([fileop executeUpdate:@"INSERT INTO ShopCar(buyer,shopName,goodName,goodPrice,goodNum,goodAllMoney) VALUES (?,?,?,?,?,?)",shopcardata.buyer,shopcardata.shopName,shopcardata.goodName,shopcardata.goodPrice,shopcardata.goodNum,shopcardata.goodAllMoney] == NO )
    {
        [fileop close];
        tempsta = FileState_AddError;
        return tempsta;
    }
    
    [fileop close];
    return tempsta;
}

//=====================================================
//  描述:选择查看信息，可单选可全选 (buyer == nil,打印所以用户)
//  输入:name:选择的用户，nil代表全选  array:读取出来保存的数组
//  返回:错误代码
//=====================================================
+(FileState)selectShopCarByWho:(NSString*)buyer andSaveArray:(NSMutableArray**)array
{
    FileState tempsta = FileState_OK;
    NSMutableArray *dataarray = [[NSMutableArray alloc]init];
    
    FMDatabase *fileop = [FMDatabase databaseWithPath:SqliteDataPath];
    
    if ([fileop open] == NO )
    {
        tempsta = FileState_OpenError;
        return tempsta;
    }
    
    FMResultSet *fileresult;
    
    if (buyer == nil )
    {
        fileresult = [fileop executeQuery:@"SELECT buyer,shopName,goodName,goodPrice,goodNum,goodAllMoney From ShopCar"];
    }
    else
    {
        fileresult = [fileop executeQuery:@"SELECT buyer,shopName,goodName,goodPrice,goodNum,goodAllMoney From ShopCar where buyer = ? ",buyer];
    }

    
    while ([fileresult next])
    {
        ManageShopCar *temp_date = [[ManageShopCar alloc]init];
        
        temp_date.buyer         = [fileresult stringForColumn:@"buyer"];
        temp_date.shopName      = [fileresult stringForColumn:@"shopName"];
        temp_date.goodName      = [fileresult stringForColumn:@"goodName"];
        temp_date.goodPrice     = [fileresult stringForColumn:@"goodPrice"];
        temp_date.goodNum       = [fileresult stringForColumn:@"goodNum"];
        temp_date.goodAllMoney  = [fileresult stringForColumn:@"goodAllMoney"];
        
        [dataarray addObject:temp_date];
    };
    
    *array = dataarray;
    
    [fileop close];
    return tempsta;
}

//=====================================================
//  描述:删除购物车信息 （ManageShopCar模型中的buyer，shopName，goodName 一定要填，其他随意，buyer == nil 删表）
//  输入:name:选择的用户
//  返回:错误代码
//=====================================================
+(FileState)deletShopCarByWho:(ManageShopCar *)shopcardata andWare:(NSString *)shopname
{
    FileState tempsta = FileState_OK;
    FMDatabase *fileop = [FMDatabase databaseWithPath:SqliteDataPath];
    
    if ([fileop open] == NO )
    {
        tempsta = FileState_OpenError;
        return tempsta;
    }
    
    if (shopcardata.buyer == nil)
    {
        if ([fileop executeUpdate:@"DELETE FROM ShopCar"] == NO )
        {
            [fileop close];
            tempsta = FileState_DeleError;
            return tempsta;
        }
    }
    else
    {
        if ([fileop executeUpdate:@"DELETE FROM ShopCar WHERE buyer = ? and shopName = ? and goodName = ?",shopcardata.buyer,shopcardata.shopName,shopcardata.goodName] == NO )
        {
            [fileop close];
            tempsta = FileState_DeleError;
            return tempsta;
        }
    }
    
    [fileop close];
    return tempsta;
}

//=====================================================
//  描述:更新购物车信息 （ManageShopCar模型中的buyer，shopName，goodName 一定要填，其他随意）
//  输入:shopcardata:选择的用户购物车信息
//  返回:错误代码
//=====================================================
+(FileState)upShopCarData:(ManageShopCar *)shopcardata withStatu:(ShopCarUpData)statu
{
    FileState tempsta = FileState_OK;
    FMDatabase *fileop = [FMDatabase databaseWithPath:SqliteDataPath];
    
    if ([fileop open] == NO )
    {
        tempsta = FileState_OpenError;
        return tempsta;
    }
    
    switch (statu)
    {
            
        case ShopCarUpData_GoodsNum:
            if ([fileop executeUpdate:@"UPDATE ShopCar SET goodNum = ? where buyer = ? and shopName = ? and goodName = ?",shopcardata.buyer,shopcardata.shopName,shopcardata.goodName] == NO )
            {
                [fileop close];
                tempsta = FileState_DeleError;
                return tempsta;
            }
            break;

            
        default:
            break;
    }
    
    [fileop close];
    return tempsta;
}


@end
