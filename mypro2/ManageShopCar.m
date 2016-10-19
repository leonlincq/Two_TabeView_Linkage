//
//  ManageShopCar.m
//  mypro2
//
//  Created by etcxm on 16/10/17.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "ManageShopCar.h"

@implementation ManageShopCar

//-(void)printfBuyer
//{
//    const char *printfdata;
//    printfdata = [self.buyer UTF8String];
//    if (printfdata == nil)
//    {
//        printf("买家：无");
//    }
//    else
//    {
//        printf("买家：%s",printfdata);
//    }
//}
//
//-(void)printfShopName
//{
//    const char *printfdata;
//    printfdata = [self.shopName UTF8String];
//    if (printfdata == nil)
//    {
//        printf("商店名称：无");
//    }
//    else
//    {
//        printf("商店名称：%s",printfdata);
//    }
//}
//
//-(void)printfGoodName
//{
//    const char *printfdata;
//    printfdata = [self.goodName UTF8String];
//    if (printfdata == nil)
//    {
//        printf("商品名称：无");
//    }
//    else
//    {
//        printf("商品名称：%s",printfdata);
//    }
//}
//
//-(void)printfGoodPrice
//{
//    const char *printfdata;
//    printfdata = [self.goodPrice UTF8String];
//    if (printfdata == nil)
//    {
//        printf("商品单价：无");
//    }
//    else
//    {
//        printf("商品单价：%s",printfdata);
//    }
//}
//
//-(void)printfGoodNum
//{
//    const char *printfdata;
//    printfdata = [self.goodNum UTF8String];
//    if (printfdata == nil)
//    {
//        printf("商品数量：无");
//    }
//    else
//    {
//        printf("商品数量：%s",printfdata);
//    }
//}
//
//-(void)printfGoodAllMoney
//{
//    const char *printfdata;
//    printfdata = [self.goodAllMoney UTF8String];
//    if (printfdata == nil)
//    {
//        printf("商店总价：无");
//    }
//    else
//    {
//        printf("商店总价：%s",printfdata);
//    }
//}

- (NSString *)description
{
    return [NSString stringWithFormat:@"买家:%@ ,商店名称:%@ ,商品名称:%@ ,商品单价:%@ ,商品数量:%@ ,商品总价:%@ 。",_buyer,_shopName,_goodName,_goodPrice,_goodNum,_goodAllMoney];
}


@end
