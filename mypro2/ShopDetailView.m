//
//  ShopDetailView.m
//  mypro2
//
//  Created by etcxm on 16/10/11.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "ShopDetailView.h"

@interface ShopDetailView ()

@property (nonatomic,strong) UIImageView *storeImageView;

@property (nonatomic,strong) UILabel *sentPriceTimeLabel;
@property (nonatomic,strong) UILabel *welcomeLabel;


@property (nonatomic,strong) UILabel *actionInfo1Label;
@property (nonatomic,strong) UILabel *actionInfo2Label;
@property (nonatomic,strong) UILabel *actionInfo3Label;
@property (nonatomic,strong) UILabel *actionInfo4Label;

@end


@implementation ShopDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.storeImageView];
        
        [self addSubview:self.sentPriceTimeLabel];
        [self addSubview:self.welcomeLabel];
        
        [self addSubview:self.actionInfo1Label];
        [self addSubview:self.actionInfo2Label];
        [self addSubview:self.actionInfo3Label];
        [self addSubview:self.actionInfo4Label];
    }
    return self;
}

#pragma mark - 懒加载
#define SPECE 10
#define UPSPECE FALSE_NAVI_HEIGHT + STATUS_HEIGHT


-(UIImageView *)storeImageView
{
    if (!_storeImageView)
    {
        _storeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, UPSPECE , 40, 40)];

        _storeImageView.layer.masksToBounds = YES;
        [_storeImageView.layer setCornerRadius:8.0];
    }
    return _storeImageView;
}

-(UILabel *)sentPriceTimeLabel
{
    if (!_sentPriceTimeLabel)
    {
        _sentPriceTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SPECE+50+SPECE, UPSPECE + 5, self.frame.size.width - SPECE - 50 - SPECE- SPECE, 15)];
        _sentPriceTimeLabel.textColor = [UIColor whiteColor];
        _sentPriceTimeLabel.font = [UIFont systemFontOfSize:15.0];
    }
    return _sentPriceTimeLabel;
}

-(UILabel *)welcomeLabel
{
    if (!_welcomeLabel)
    {
        _welcomeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SPECE+50+SPECE , UPSPECE + 10+5 + 15, self.frame.size.width - SPECE - 50 - SPECE- SPECE, 15)];
        _welcomeLabel.text = @"本店欢迎您下单，用餐高峰期请提前下单";
        _welcomeLabel.textColor = [UIColor whiteColor];
        _welcomeLabel.font = [UIFont systemFontOfSize:15.0];
    }
    return _welcomeLabel;
}

-(UILabel *)actionInfo1Label
{
    if (!_actionInfo1Label)
    {
        _actionInfo1Label = [[UILabel alloc]initWithFrame:CGRectMake(SPECE , UPSPECE + 10+30+5,  self.frame.size.width - SPECE - SPECE, 15)];
        _actionInfo1Label.textColor = [UIColor whiteColor];
        _actionInfo1Label.font = [UIFont systemFontOfSize:13.0];
    }
    return _actionInfo1Label;
}

-(UILabel *)actionInfo2Label
{
    if (!_actionInfo2Label)
    {
        _actionInfo2Label = [[UILabel alloc]initWithFrame:CGRectMake(SPECE , UPSPECE + 10+30+5 + 15,  self.frame.size.width - SPECE - SPECE, 15)];
        _actionInfo2Label.textColor = [UIColor whiteColor];
        _actionInfo2Label.font = [UIFont systemFontOfSize:13.0];
    }
    return _actionInfo2Label;
}

-(UILabel *)actionInfo3Label
{
    if (!_actionInfo3Label)
    {
        _actionInfo3Label = [[UILabel alloc]initWithFrame:CGRectMake(SPECE , UPSPECE + 10+30+5 + 15 + 15,  self.frame.size.width - SPECE - SPECE, 15)];
        _actionInfo3Label.textColor = [UIColor whiteColor];
        _actionInfo3Label.font = [UIFont systemFontOfSize:13.0];
    }
    return _actionInfo3Label;
}

-(UILabel *)actionInfo4Label
{
    if (!_actionInfo4Label)
    {
        _actionInfo4Label = [[UILabel alloc]initWithFrame:CGRectMake(SPECE , UPSPECE + 10+30+5 + 15 + 15 + 15,  self.frame.size.width - SPECE - SPECE, 15)];
        _actionInfo4Label.textColor = [UIColor whiteColor];
        _actionInfo4Label.font = [UIFont systemFontOfSize:13.0];
    }
    return _actionInfo4Label;
}

-(void)setShopData:(SectionThirdModel *)model
{
    _shopData = model;

    _storeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",_shopData.storeImage]];

    _sentPriceTimeLabel.text = [NSString stringWithFormat:@"%@ | 送达 %@",_shopData.sellPrace,_shopData.maxTime];
    _actionInfo1Label.text = [NSString stringWithFormat:@"🔴%@",_shopData.actionInfo1];
    _actionInfo2Label.text = [NSString stringWithFormat:@"🔵%@",_shopData.actionInfo2];
    _actionInfo3Label.text = [NSString stringWithFormat:@"🔴%@",_shopData.actionInfo3];
    _actionInfo4Label.text = [NSString stringWithFormat:@"🔵%@",_shopData.actionInfo4];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
