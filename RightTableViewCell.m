//
//  RightTableViewCell.m
//  mypro2
//
//  Created by etcxm on 16/10/9.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "RightTableViewCell.h"
#import "CategoryModel.h"

@interface RightTableViewCell ()

@property (nonatomic, strong) UIImageView   *goodsImageView;
@property (nonatomic, strong) UILabel       *goodsNameLabel;
@property (nonatomic, strong) UILabel       *goodsPriceLabel;

@property (nonatomic, strong) UIButton      *goodsAddButton;
@property (nonatomic, strong) UIButton      *goodsSubButton;

@end


@implementation RightTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {        
        self.goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];   //以后改宏定义
        [self.contentView addSubview:self.goodsImageView];
        
        self.goodsNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 30)];      //以后改宏定义
        self.goodsNameLabel.font = [UIFont systemFontOfSize:14];                                //以后改宏定义
        [self.contentView addSubview:self.goodsNameLabel];
        
        self.goodsPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 45, 200, 30)];     //以后改宏定义
        self.goodsPriceLabel.font = [UIFont systemFontOfSize:14];                               //以后改宏定义
        self.goodsPriceLabel.textColor = [UIColor redColor];                                    //以后改宏定义
        [self.contentView addSubview:self.goodsPriceLabel];
        
//        [self.contentView addSubview:self.goodsAddButton];
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - 懒加载
- (UIButton *)goodsAddButton
{
    if (!_goodsAddButton)
    {
        _goodsAddButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-5-25,self.frame.size.height-5-25, 25,25)];
        NSLog(@"%lf",self.frame.size.height);
        _goodsAddButton.backgroundColor = [UIColor redColor];
        [_goodsAddButton.layer setCornerRadius:5];
    }
    return _goodsAddButton;
}


- (void)setModel:(GoodsModel *)model
{
    self.goodsImageView.image   = [UIImage imageNamed:model.goodsImage];
    self.goodsNameLabel.text    = model.goodsName;
    self.goodsPriceLabel.text   = [NSString stringWithFormat:@"￥%02lf",model.goodsPrice];
}

- (void)setGoodsNameLabelText:(NSString *)name
{
    self.goodsNameLabel.text = name;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
