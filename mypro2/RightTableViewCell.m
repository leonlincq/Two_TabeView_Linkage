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

        [self.contentView addSubview:self.goodsImageView];
        [self.contentView addSubview:self.goodsNameLabel];
        [self.contentView addSubview:self.goodsPriceLabel];
        
        [self.contentView addSubview:self.goodsAddButton];
        [self.contentView addSubview:self.goodsSubButton];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - 懒加载
- (UIImageView *)goodsImageView
{
    if (!_goodsImageView)
    {
        _goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];   //以后改宏定义
    }
    return _goodsImageView;
}

- (UILabel *)goodsNameLabel
{
    if (!_goodsNameLabel)
    {
        _goodsNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 30)];      //以后改宏定义
        _goodsNameLabel.font = [UIFont systemFontOfSize:14];                                //以后改宏定义
    }
    return _goodsNameLabel;
}

- (UILabel *)goodsPriceLabel
{
    if (!_goodsPriceLabel)
    {
        _goodsPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 45, 200, 30)];     //以后改宏定义
        _goodsPriceLabel.font = [UIFont systemFontOfSize:14];                               //以后改宏定义
        _goodsPriceLabel.textColor = [UIColor redColor];                                    //以后改宏定义
    }
    return _goodsPriceLabel;
}

- (UIButton *)goodsAddButton
{
    if (!_goodsAddButton)
    {
        _goodsAddButton = [[UIButton alloc]initWithFrame:CGRectMake(/*self.frame.size.width-5-25,self.frame.size.height-5-25,*/334-10-25,80-10-25, 25,25)];
        [_goodsAddButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        _goodsAddButton.backgroundColor = [UIColor redColor];
        [_goodsAddButton.layer setCornerRadius:5];
        [_goodsAddButton addTarget:self action:@selector(goodsCountClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goodsAddButton;
}

- (UIButton *)goodsSubButton
{
    if (!_goodsSubButton)
    {
        _goodsSubButton = [[UIButton alloc]initWithFrame:CGRectMake(/*self.frame.size.width-5-25,self.frame.size.height-5-25,*/334-10-25-25-25,80-10-25, 25,25)];
        [_goodsSubButton setImage:[UIImage imageNamed:@"sub"] forState:UIControlStateNormal];
        [_goodsSubButton.layer setCornerRadius:5];
        [_goodsSubButton.layer setBorderWidth:2.0];
        [_goodsSubButton.layer setBorderColor:[UIColor redColor].CGColor];
        [_goodsSubButton addTarget:self action:@selector(goodsCountClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goodsSubButton;
}

#pragma mark 模式 To View
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

-(void)goodsCountClick:(UIButton *)button
{
    if (button == _goodsAddButton)
    {
        NSLog(@"++");
    }
    else
    {
        NSLog(@"--");
    }
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
