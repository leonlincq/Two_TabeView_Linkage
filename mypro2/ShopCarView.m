//
//  ShopCarView.m
//  mypro2
//
//  Created by etcxm on 16/10/11.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "ShopCarView.h"
#import "MakeOrderViewController.h"

@interface ShopCarView ()

@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *sureLabel;

@property (nonatomic,strong) UIButton *sureButton;

@end

@implementation ShopCarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor blackColor];
        
        [self addSubview:self.moneyLabel];
        [self addSubview:self.sureLabel];
        [self addSubview:self.sureButton];
    }
    return self;
}

-(UILabel *)moneyLabel
{
    if (!_moneyLabel)
    {
        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,self.frame.size.width/2, self.frame.size.height)];
        _moneyLabel.text = @"购物车是空的";
        _moneyLabel.textColor = [UIColor whiteColor];
        _moneyLabel.textAlignment = NSTextAlignmentRight;
        
        _moneyLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _moneyLabel;
}

-(UILabel *)sureLabel
{
    if (!_sureLabel)
    {
        _sureLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2, 0,self.frame.size.width/2, self.frame.size.height)];
        _sureLabel.textColor = [UIColor whiteColor];
        _sureLabel.textAlignment = NSTextAlignmentRight;
        
        _sureLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _sureLabel;
}

-(UIButton *)sureButton
{
    if (!_sureButton)
    {
        _sureButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/2, 0,self.frame.size.width/2, self.frame.size.height)];
        [_sureButton setTitle:@"选好了" forState:UIControlStateNormal];
        _sureButton.backgroundColor = [UIColor redColor];
        _sureButton.hidden = YES;
        [_sureButton addTarget:self action:@selector(sureToOrder:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

-(void)setShopCarPrice:(NSString *)price
{
    _shopCarPrice = price;
    
    self.moneyLabel.text = [NSString stringWithFormat:@"%@",price];

    if ([[_shopCarPrice substringWithRange:NSMakeRange(2, _shopCarPrice.length-2)] intValue] >= [_sentPrice intValue])
    {
        self.sureButton.hidden = NO;
    }
    else
    {
        self.sureButton.hidden = YES;
        
        if ([[_shopCarPrice substringWithRange:NSMakeRange(2, _shopCarPrice.length-2)] intValue] != 0)
        {
            self.sureLabel.text = [NSString stringWithFormat:@"还差%d元",[_sentPrice intValue] - [[_shopCarPrice substringWithRange:NSMakeRange(2, _shopCarPrice.length-2)] intValue] ];
        }
        else
        {
            self.sureLabel.text = [NSString stringWithFormat:@"%@元起送",_sentPrice];
        }

    }
}

-(void)setSentPrice:(NSString *)price
{
    _sentPrice = price;
    
    self.sureLabel.text = [NSString stringWithFormat:@"%@元起送",price];
}

-(void)sureToOrder:(UIButton *)buttonClick
{
    [self.toOrderDelegate presentToOrder];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
