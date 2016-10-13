//
//  CategoryModel.h
//  mypro2
//
//  Created by etcxm on 16/10/9.
//  Copyright © 2016年 etc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

//@property (nonatomic, copy)     NSString    *name;  //名字
//@property (nonatomic, copy)     NSString    *icon;  //图标
//@property (nonatomic, strong)   NSArray     *spus;  //信息

@end


@interface GoodsModel : NSObject

//@property (nonatomic, copy) NSString    *goodsModelCategory;        //商品分类
@property (nonatomic, copy) NSString    *goodsModelGoodsImage;      //商品图片
@property (nonatomic, copy) NSString    *goodsModelGoodsName;       //商品名字
@property (nonatomic, copy) NSString    *goodsModelGoodsPrice;      //商品价格
@property (nonatomic, copy) NSString    *goodsModelPreferentPrice;  //商品优惠价格

//@property (nonatomic, copy) NSString    *goodsModel;//月销量


@end