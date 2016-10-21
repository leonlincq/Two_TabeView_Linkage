//
//  ChainReactionView.h
//  mypro2
//
//  Created by etcxm on 16/10/10.
//  Copyright © 2016年 etc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LinkageView.h"
#import "SectionThirdModel.h"

@interface ChainReactionView : UIView

@property (nonatomic, strong) UICollectionView *collectionView; //频道内容数据
@property (nonatomic, strong) NSArray *allNameArray;

@property (nonatomic,strong) SectionThirdModel *shopAndGoodsModel;

@property (nonatomic,strong) LinkageView *linkView;


- (instancetype)initWithFrame:(CGRect)frame andSetModel:(SectionThirdModel *)shopAndGoodsModel;

@end
