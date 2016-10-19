//
//  ShopNaviView.m
//  mypro2
//
//  Created by etcxm on 16/10/11.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "ShopNaviView.h"
#import "RootViewController.h"

@interface ShopNaviView ()

@property (nonatomic,strong) UIView *backButton;
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UILabel *shopNamelabel;

@end


@implementation ShopNaviView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
#ifdef OBSERVE
        self.isReturn = NO;
#endif
        [self addSubview:self.shopNamelabel];
        [self addSubview:self.backButton];
        
    }
    return self;
}

#pragma mark - 懒加载

- (UIView *)backButton
{
    if (_backButton == nil)
    {
        _backButton = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        
        _backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(13, 13, 44-26, 44-26)];
        [_backImageView setImage:[UIImage imageNamed:@"NaviBackButton"]];
        [_backButton addSubview:_backImageView];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backTap:)];
        [_backButton addGestureRecognizer:tapGes];
    }
    return _backButton;
}

- (UILabel *)shopNamelabel
{
    if (_shopNamelabel == nil)
    {
        _shopNamelabel = [[UILabel alloc]initWithFrame:CGRectMake(44 + 10, 5,SCREEN_WIDTH - 44 * 2 -20, 44-10)];
        _shopNamelabel.textAlignment = NSTextAlignmentCenter;
        _shopNamelabel.textColor = [UIColor whiteColor];
        _shopNamelabel.font = [UIFont systemFontOfSize:25.0];
    }
    return _shopNamelabel;
}

#pragma mark - 模型 to 显示
- (void)setShopName:(NSString *)shopname
{
    _shopName = shopname;
    
    self.shopNamelabel.text = shopname;
}

#pragma mark - 返回图片点击
- (void)backTap:(UITapGestureRecognizer *)recognizer
{
#ifdef OBSERVE
    self.isReturn = YES;
#endif
   [self.backdelegate dismissToHome];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
