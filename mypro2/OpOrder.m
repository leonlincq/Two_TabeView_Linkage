//
//  OpOrder.m
//  mypro2
//
//  Created by etcxm on 16/10/17.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "OpOrder.h"

@implementation OpOrder

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
+(FileState)creatTableForOrder
{
    FileState tempsta = FileState_OK;
    FMDatabase *fileop = [FMDatabase databaseWithPath:SqliteDataPath];
    
    if ([fileop open] == NO )
    {
        tempsta = FileState_OpenError;
        return tempsta;
    }
//    if ([fileop executeUpdate:@"CREATE TABLE IF NOT EXISTS ShopCar (buyer TEXT , shopName TEXT ,goodName TEXT ,goodPrice TEXT,goodNum TEXT,goodAllMoney TEXT)"] == NO)
    
    if ([fileop executeUpdate:@"CREATE TABLE IF NOT EXISTS Orders (orderNum TEXT , orderState TEXT ,orderEva TEXT ,orderEvaStart TEXT ,buyer TEXT ,shopName TEXT ,goodName TEXT ,goodPrice TEXT ,goodNum TEXT ,goodAllMoney TEXT )"] == NO)
    {
        [fileop close];
        tempsta = FileState_BuildError;
        return tempsta;
    }
    
    [fileop close];
    return tempsta;
}

//=====================================================
//  描述:在选定表格添加购物信息() （ManageOrder模型全填）
//  输入:shopcardata:添加的新的购物信息
//  返回:错误代码
//=====================================================
+(FileState)addToOrder:(ManageOrder *)orderdata
{
    FileState tempsta = FileState_OK;
    FMDatabase *fileop = [FMDatabase databaseWithPath:SqliteDataPath];
    
    if ([fileop open] == NO )
    {
        tempsta = FileState_OpenError;
        return tempsta;
    }
    
    if ([fileop executeUpdate:@"INSERT INTO Orders(orderNum,orderState,orderEva,orderEvaStart,buyer,shopName,goodName,goodPrice,goodNum,goodAllMoney) VALUES (?,?,?,?,?,?,?,?,?,?)",orderdata.orderNum,orderdata.orderState,orderdata.orderEva,orderdata.orderEvaStart,orderdata.buyer,orderdata.shopName,orderdata.goodName,orderdata.goodPrice,orderdata.goodNum,orderdata.goodAllMoney] == NO )
    {
        [fileop close];
        tempsta = FileState_AddError;
        return tempsta;
    }
    
    [fileop close];
    return tempsta;
}

//=====================================================
//  描述:选择查看信息（orderdata模型看情况，statu选择要查看的）
//  输入:name:选择的用户，nil代表全选  array:读取出来保存的数组
//  返回:错误代码
//=====================================================
+(FileState)selectOrderByWho:(ManageOrder *)orderdata withStatu:(OrderSelect)statu andSaveArray:(NSMutableArray**)array
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
    
    switch (statu)
    {
        case OrderSelect_Buyer:
            
//            if (orderdata.order == nil && orderdata.buyer != nil )  //订单全选，买家指定
//            {
                fileresult = [fileop executeQuery:@"SELECT orderNum,orderState,orderEva,orderEvaStart,buyer,shopName,goodName,goodPrice,goodNum,goodAllMoney From Orders where buyer = ? ",orderdata.buyer];
//            }
            
            break;
            
        default:
            break;
    }
    
    
    while ([fileresult next])
    {
        ManageOrder *temp_date = [[ManageOrder alloc]init];
        
        temp_date.orderNum      = [fileresult stringForColumn:@"orderNum"];
        temp_date.orderState    = [fileresult stringForColumn:@"orderState"];
        temp_date.orderEva      = [fileresult stringForColumn:@"orderEva"];
        temp_date.orderEvaStart = [fileresult stringForColumn:@"orderEvaStart"];
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

#pragma mark - 暂时不用删除订单
////=====================================================
////  描述:删除订单信息
////  输入:name:选择的用户
////  返回:错误代码
////=====================================================
//+(FileState)deletOrderByWho:(ManageOrder *)orderdata andWare:(NSString *)shopname
//{
//    FileState tempsta = FileState_OK;
//    FMDatabase *fileop = [FMDatabase databaseWithPath:SqliteDataPath];
//    
//    if ([fileop open] == NO )
//    {
//        tempsta = FileState_OpenError;
//        return tempsta;
//    }
//    
//    if (shopcardata.buyer == nil)
//    {
//        if ([fileop executeUpdate:@"DELETE FROM ShopCar"] == NO )
//        {
//            [fileop close];
//            tempsta = FileState_DeleError;
//            return tempsta;
//        }
//    }
//    else
//    {
//        if ([fileop executeUpdate:@"DELETE FROM ShopCar WHERE buyer = ? and shopName = ? and goodName = ?",shopcardata.buyer,shopcardata.shopName,shopcardata.goodName] == NO )
//        {
//            [fileop close];
//            tempsta = FileState_DeleError;
//            return tempsta;
//        }
//    }
//    
//    [fileop close];
//    return tempsta;
//}

//=====================================================
//  描述:更新购物车信息 （ManageShopCar模型中的buyer，shopName，goodName 一定要填，其他随意）
//  输入:shopcardata:选择的用户购物车信息
//  返回:错误代码
//=====================================================
+(FileState)upOrderData:(ManageOrder *)orderdata withStatu:(OrderUpData)statu
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
            
        case OrderUpData_OrderState:
            if ([fileop executeUpdate:@"UPDATE Orders SET orderState = ? where orderNum = ? ",orderdata.orderNum] == NO )
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
