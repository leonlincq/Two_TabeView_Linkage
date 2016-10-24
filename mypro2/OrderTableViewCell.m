//
//  OrderTableViewCell.m
//  mypro2
//
//  Created by etcxm on 16/10/21.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "OrderTableViewCell.h"

@interface OrderTableViewCell ()

@property (nonatomic,strong) UIImageView *shopImageView;
@property (nonatomic,strong) UILabel *shopNameView;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *rightButton;

@property (nonatomic,strong) UIView *upCrossView;
@property (nonatomic,strong) UIView *downCrossView;


@end


@implementation OrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self addSubview:self.shopImageView];
        [self addSubview:self.shopNameView];
        
        [self addSubview:self.upCrossView];
        [self addSubview:self.detailLabel];
        [self addSubview:self.downCrossView];
        
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
    }
    return self;
}
#pragma mark - 懒加载
-(UIImageView *)shopImageView
{
    if (!_shopImageView)
    {
        _shopImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    }
    return _shopImageView;
}

-(UILabel *)shopNameView
{
    if (!_shopNameView)
    {
        _shopNameView = [[UILabel alloc]initWithFrame:CGRectMake(60,0,  SCREEN_WIDTH-60, 30)];
    }
    return _shopNameView;
}

-(UILabel *)detailLabel
{
    if (!_detailLabel)
    {
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 60)];
    }
    return _detailLabel;
}

-(UIButton *)leftButton
{
    if (!_leftButton)
    {
        _leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH/2, 30)];
        [_leftButton setTitle:@"取消" forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    return _leftButton;
}

-(UIButton *)rightButton
{
    if (!_rightButton)
    {
        _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 90, SCREEN_WIDTH/2, 30)];
        [_rightButton setTitle:@"确认" forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    return _rightButton;
}

-(UIView *)upCrossView
{
    if (!_upCrossView)
    {
        _upCrossView = [[UIView alloc]initWithFrame:CGRectMake(0, 31, SCREEN_WIDTH, 1)];
        _upCrossView.backgroundColor = [UIColor grayColor];
    }
    return _upCrossView;
}

-(UIView *)downCrossView
{
    if (!_downCrossView)
    {
        _downCrossView = [[UIView alloc]initWithFrame:CGRectMake(0, 89, SCREEN_WIDTH, 1)];
        _downCrossView.backgroundColor = [UIColor grayColor];
    }
    return _downCrossView;
}


#pragma mark - 传值
-(void)setShopImageName:(NSString *)shopImageName
{
    _shopImageName = shopImageName;
    _shopImageView.image = [UIImage imageNamed:_shopImageName];
}

-(void)setShopName:(NSString *)shopName
{
    _shopName = shopName;
    _shopNameView.text = shopName;
}

-(void)setDetailText:(NSString *)detailText
{
    _detailText = detailText;
    _detailLabel.text = detailText;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
