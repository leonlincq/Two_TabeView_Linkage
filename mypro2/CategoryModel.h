//
//  CategoryModel.h
//  mypro2
//
//  Created by etcxm on 16/10/9.
//  Copyright © 2016年 etc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

@property (nonatomic, copy)     NSString    *name;  //名字
@property (nonatomic, copy)     NSString    *icon;  //图标
@property (nonatomic, strong)   NSArray     *spus;  //信息

@end


@interface GoodsModel : NSObject

@property (nonatomic, copy)     NSString    *goodsName;     //商品名
@property (nonatomic, copy)     NSString    *goodsId;       //商品id
@property (nonatomic, copy)     NSString    *goodsImage;    //商品图片
@property (nonatomic, assign)   float       goodsPrice;     //商品价格

@property (nonatomic, assign)   NSInteger   goodsPraiseNum; //好评量
@property (nonatomic, assign)   NSInteger   goodsMonthSaled;//月销量


@end