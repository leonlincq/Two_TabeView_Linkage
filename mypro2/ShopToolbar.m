//
//  ShopToolbar.m
//  mypro2
//
//  Created by etcxm on 16/10/12.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "ShopToolbar.h"

@interface ShopToolbar ()

@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) UIView   *spaceViewOne;
@property (nonatomic,strong) UIView   *spaceViewTwo;


@property (nonatomic,strong) UILabel *ShopNameLabel;
@property (nonatomic,strong) UILabel *actionInfoLabel;
@property (nonatomic,strong) UILabel *MonthSellLabel;

@end


@implementation ShopToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.backButton];
        [self addSubview:self.spaceViewOne];
        
        [self addSubview:self.actionInfoLabel];
        
        [self addSubview:self.spaceViewTwo];
        
    }
    return self;
}


#pragma mark -懒加载
-(UIView *)spaceViewOne
{
    if (!_spaceViewOne)
    {
        _spaceViewOne = [[UIView alloc]initWithFrame:CGRectMake(50, 150, SCREEN_WIDTH-100, 2)];
        _spaceViewOne.backgroundColor = [UIColor grayColor];
    }
    return _spaceViewOne;
}

-(UIView *)spaceViewTwo
{
    if (!_spaceViewTwo)
    {
        _spaceViewTwo = [[UIView alloc]initWithFrame:CGRectMake(50, SCREEN_HEIGHT-100-50 -50, SCREEN_WIDTH-100, 2)];
        _spaceViewTwo.backgroundColor = [UIColor grayColor];
    }
    return _spaceViewTwo;
}



-(UIButton *)backButton
{
    if (!_backButton)
    {
        _backButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-25, SCREEN_HEIGHT-50-50, 50, 50)];

        [_backButton setImage:[UIImage imageNamed:@"back_cross"] forState:UIControlStateNormal];

        [_backButton addTarget:self action:@selector(backToShopAndGoodsClicks:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}



//@property (nonatomic,strong) UILabel *ShopNameLabel;

-(UILabel *)actionInfoLabel
{
    if (!_actionInfoLabel)
    {
        _actionInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(20 , 150 + 20,  self.frame.size.width - 20 - 20, SCREEN_HEIGHT-100-50 -50 -20-150-20)];
        _actionInfoLabel.numberOfLines = 0;
        _actionInfoLabel.textColor = [UIColor blackColor];
        _actionInfoLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _actionInfoLabel;
}




//@property (nonatomic,strong) UILabel *MonthSellLabel;


-(void)setShopData:(SectionThirdModel *)model
{
    _shopData = model;
    
    _actionInfoLabel.text = [NSString stringWithFormat:@" 🔴 %@ \n\n 🔵 %@ \n\n 🔴 %@ \n\n 🔵%@ \n\n",_shopData.actionInfo1,_shopData.actionInfo2,_shopData.actionInfo3,_shopData.actionInfo4];
}








#pragma mark -自定义代理
- (void)backToShopAndGoodsClicks:(UIButton *)button
{
    [self.backDelegate backToShopAndGoods];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
