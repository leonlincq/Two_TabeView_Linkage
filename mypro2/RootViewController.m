//
//  RootViewController.m
//  mypro2
//
//  Created by etcxm on 16/10/10.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "RootViewController.h"
#import "ChainReactionView.h"
#import "LinkageView.h"

#import "ShopNaviView.h"
#import "ShopDetailView.h"
#import "ShopCarView.h"
#import "ShopToolbar.h"

@interface RootViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *myScrollView;

@property (nonatomic,strong) ShopNaviView *failnaviView;
@property (nonatomic,strong) ShopDetailView *stopView;
@property (nonatomic,strong) ChainReactionView *chainView;
@property (nonatomic,strong) ShopCarView *buttomView;



@property (nonatomic,strong) UIButton *shopDetaiButton;
@property (nonatomic,strong) ShopToolbar *shopDetaiToolbar;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _shopName = @"KFC";
    
    

    
    
    
    
    
    
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
#ifdef OBSERVE    
    [self addObserver:self forKeyPath:@"isReturn" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
#endif
    
    
    _myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SHOPCAR_HEIGHT)];
    
    _myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - SHOPCAR_HEIGHT + SHOPDETAIL_HEIGHT);
    _myScrollView.delegate = self;
    _myScrollView.showsVerticalScrollIndicator = NO;
    _myScrollView.bounces = NO;
    [self.view addSubview:_myScrollView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIColor *topColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1];
    
    UIView *statusView = [[UIView alloc]initWithFrame:[[UIApplication sharedApplication]statusBarFrame]];
    statusView.backgroundColor = topColor;
    [self.view addSubview:statusView];
    
    //添加最上面的假导航栏
    _failnaviView = [[ShopNaviView alloc]initWithFrame:CGRectMake(0, STATUS_HEIGHT, SCREEN_WIDTH,FALSE_NAVI_HEIGHT)];
    _failnaviView.backgroundColor = topColor;
    _failnaviView.backdelegate = self;
    _failnaviView.shopName = self.shopAndGoodsModel.storeName;
    [self.view addSubview:_failnaviView];
    
    //添加次上面的商店信息
    _stopView = [[ShopDetailView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SHOPDETAIL_HEIGHT + FALSE_NAVI_HEIGHT + STATUS_HEIGHT)];
    _stopView.backgroundColor = topColor;
    _stopView.shopData = self.shopAndGoodsModel;
    [_myScrollView addSubview:_stopView];
    
    //添加中间和下面的的scrollView
    _chainView = [[ChainReactionView alloc] initWithFrame:CGRectMake(0, SHOPDETAIL_HEIGHT + FALSE_NAVI_HEIGHT  + STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FALSE_NAVI_HEIGHT - SHOPCAR_HEIGHT - STATUS_HEIGHT - SHOPDETAIL_HEIGHT)];
    [_myScrollView addSubview:_chainView];
    
    //    添加最下面的商店信息
    _buttomView = [[ShopCarView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT-60, SCREEN_WIDTH,60)];
    _buttomView.alpha = 0.8;
    [self.view addSubview:_buttomView];
    
    
    
    _shopDetaiButton = [[UIButton alloc]initWithFrame:CGRectMake(0,STATUS_HEIGHT + FALSE_NAVI_HEIGHT,SCREEN_WIDTH, SHOPDETAIL_HEIGHT)];
    [_shopDetaiButton addTarget:self action:@selector(shopDetailClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.myScrollView addSubview:_shopDetaiButton];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载
-(SectionThirdModel *)shopAndGoodsModel
{
    if (!_shopAndGoodsModel)
    {
        _shopAndGoodsModel = [[SectionThirdModel alloc]init];
        
        _shopAndGoodsModel.actionInfo1  = @"活动1。。。";
        _shopAndGoodsModel.actionInfo2  = @"活动2。。。!!!~~~@@@###$$$";
        _shopAndGoodsModel.actionInfo3  = @"活动3。。。!@#!$!@$!@#!#";
        _shopAndGoodsModel.actionInfo4  = @"活动4。。。";
        
        _shopAndGoodsModel.storeName    = @"麦当劳";
        _shopAndGoodsModel.storeImage   = @"mdl";
        _shopAndGoodsModel.sell         = @"月销售：30单";
        _shopAndGoodsModel.comment      = @"评论:很好";
        _shopAndGoodsModel.sellPrace    = @"15";
        _shopAndGoodsModel.maxTime      = @"30";
        _shopAndGoodsModel.distance     = @"距离:10KM";
    }
    return _shopAndGoodsModel;
}


#pragma mark -自定义代理
//dismiss
- (void)dismissToHome
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)backToShopAndGoods
{
    ShopToolbar *tempToolView = [self.view viewWithTag:101];
    [tempToolView removeFromSuperview];
}

#pragma mark -代理

#define MENU_HEIGHT SCREEN_HEIGHT - FALSE_NAVI_HEIGHT - SHOPCAR_HEIGHT - STATUS_HEIGHT - SHOPDETAIL_HEIGHT
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isMemberOfClass:[UIScrollView class]])
    {
        _chainView.frame = CGRectMake(0, SHOPDETAIL_HEIGHT + FALSE_NAVI_HEIGHT  + STATUS_HEIGHT,SCREEN_WIDTH, MENU_HEIGHT + _myScrollView.contentOffset.y);
        
    }

}


#ifdef OBSERVE
#pragma mark -观察者
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"%@",keyPath);
    NSLog(@"%@",change);
    NSLog(@"%@",[change objectForKey:@"new"]);
    
    [self removeObserver:self forKeyPath:@"isReturn"];
}
#endif


#pragma mark -商家详情按钮
- (void)shopDetailClick:(UIButton *)button
{
    ShopToolbar *shopDetaiToolbar = [[ShopToolbar alloc]initWithFrame:[UIScreen mainScreen].bounds];
    shopDetaiToolbar.backDelegate = self;
    shopDetaiToolbar.shopData = _shopAndGoodsModel;
    shopDetaiToolbar.tag = 101;
    [self.view addSubview:shopDetaiToolbar];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
