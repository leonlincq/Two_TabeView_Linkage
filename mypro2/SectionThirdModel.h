//
//  SectionThirdModel.h
//  BaiduWaimai
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 赖琴芳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SectionThirdModel : NSObject


//4个活动
@property (nonatomic,strong)NSString *actionInfo1;
@property (nonatomic,strong)NSString *actionInfo2;
@property (nonatomic,strong)NSString *actionInfo3;
@property (nonatomic,strong)NSString *actionInfo4;

//商店信息
//店名
@property (nonatomic,strong)NSString *storeName;
//商店图片
@property (nonatomic,strong)NSString *storeImage;
//月销售
@property (nonatomic,strong)NSString *sell;
//评论
@property (nonatomic,strong)NSString *comment;
//起送价格
@property (nonatomic,strong)NSString *sellPrace;
//最长配送时间
@property (nonatomic,strong)NSString *maxTime;
//距离
@property (nonatomic,strong)NSString *distance;

//- (void)sectionThirdModel:(SectionThirdArrayModel *)model andRowForSelectedCell:(NSInteger)index;

@end
