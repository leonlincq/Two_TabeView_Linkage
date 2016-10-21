//
//  LinkageView.h
//  mypro2
//
//  Created by etcxm on 16/10/10.
//  Copyright © 2016年 etc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SectionThirdModel.h"

@protocol CellClickProtocol <NSObject>

-(void)ClickTabelViewCellWithGoodsDic:(NSDictionary *)dic;

@end


@interface LinkageView : UIView

@property (nonatomic,strong) SectionThirdModel *shopAndGoodsModel;

@property (nonatomic,strong) id<CellClickProtocol> CellDelegate;

- (instancetype)initWithFrame:(CGRect)frame  andSetModel:(SectionThirdModel *)shopAndGoodsModel;

@end
