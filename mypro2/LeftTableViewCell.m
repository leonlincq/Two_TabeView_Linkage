//
//  LeftTableViewCell.m
//  mypro2
//
//  Created by etcxm on 16/10/9.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "LeftTableViewCell.h"

@interface LeftTableViewCell ()

@property (nonatomic, strong) UIView *yellowView;

@end

@implementation LeftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;                        //没有点中效果
        
        self.cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 40)];    //Label 大小，以后宏定义
        self.cellLabel.numberOfLines = 0;                                               //自动换行
        self.cellLabel.font = [UIFont systemFontOfSize:15];                             //字体，以后宏定义
        self.cellLabel.textColor = RGBA(130, 130, 130, 1);                              //字体颜色，以后宏定义
        self.cellLabel.highlightedTextColor = DEFAULT_COLOR;                            //高亮时字体颜色
        [self.contentView addSubview:self.cellLabel];
        
        self.yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 5, 45)];       //黄条 大小，以后宏定义
        self.yellowView.backgroundColor = DEFAULT_COLOR;                                //黄条 背景颜色
        [self.contentView addSubview:self.yellowView];
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : [UIColor colorWithWhite:0 alpha:0.1];  //contentView，选中即白色背景
    self.highlighted = selected;                //单元格（self），选中即高亮状态
    self.cellLabel.highlighted = selected;      //单元格里的Label，选中即高亮状态
    self.yellowView.hidden = !selected;         //单元格的黄条，选中即不隐藏
}

@end
