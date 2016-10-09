//
//  RightTableViewCell.h
//  mypro2
//
//  Created by etcxm on 16/10/9.
//  Copyright © 2016年 etc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsModel;

#define RightTableView_CellIdentifier @"RightTableViewCell"

@interface RightTableViewCell : UITableViewCell

@property (nonatomic, strong) GoodsModel *model;

- (void)setGoodsNameLabelText:(NSString *)name;

@end
