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


#define SHOPDETAIL_HEIGHT   150
#define SHOPCAR_HEIGHT      60
#define FALSE_NAVI_HEIGHT   44  //self.navigationController.navigationBar.frame.size.height   //导航栏高度44
#define STATUS_HEIGHT   [[UIApplication sharedApplication]statusBarFrame].size.height  //最顶上状态栏高度20

@interface RootViewController ()

@property (nonatomic,strong) UIScrollView *myScrollView;

@property (nonatomic,strong) ShopNaviView *failnaviView;
@property (nonatomic,strong) ShopDetailView *stopView;
@property (nonatomic,strong) ChainReactionView *chainView;
@property (nonatomic,strong) ShopCarView *buttom;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    [self addObserver:self forKeyPath:@"isReturn" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    
    
    _myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SHOPCAR_HEIGHT)];
    
    _myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - SHOPCAR_HEIGHT + SHOPDETAIL_HEIGHT);
    
    _myScrollView.showsVerticalScrollIndicator = NO;
    _myScrollView.bounces = NO;
    [self.view addSubview:_myScrollView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIColor *arcColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:0.7];
    
    //添加最上面的假导航栏
    _failnaviView = [[ShopNaviView alloc]initWithFrame:CGRectMake(0, STATUS_HEIGHT, SCREEN_WIDTH,FALSE_NAVI_HEIGHT)];
    _failnaviView.backgroundColor = [UIColor clearColor];
    _failnaviView.shopName = @"KFC";
    [self.view addSubview:_failnaviView];
    
    //添加次上面的商店信息
    _stopView = [[ShopDetailView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SHOPDETAIL_HEIGHT + FALSE_NAVI_HEIGHT + STATUS_HEIGHT)];
    _stopView.backgroundColor = arcColor;
    [_myScrollView addSubview:_stopView];
    
    //添加中间和下面的的scrollView
    _chainView = [[ChainReactionView alloc] initWithFrame:CGRectMake(0, SHOPDETAIL_HEIGHT + FALSE_NAVI_HEIGHT  + STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FALSE_NAVI_HEIGHT - SHOPCAR_HEIGHT - STATUS_HEIGHT)];
    [_myScrollView addSubview:_chainView];
    
    _chainView.myCollectionCellBlock = ^(UICollectionView *collectionView,NSIndexPath *indexPath)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                //添加下面的两个TableView联动
                LinkageView *linkView = [[LinkageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - SHOPCAR_HEIGHT - FALSE_NAVI_HEIGHT - STATUS_HEIGHT - 44/*频道按钮*/)];
                
                [collectionView addSubview:linkView];
            }
                break;
                
            case 1:
                
                break;
                
            case 2:
                
                break;
                
            default:
                break;
        }
    };
    
    //    添加最下面的商店信息
    _buttom = [[ShopCarView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT-60, SCREEN_WIDTH,60)];
    _buttom.alpha = 0.8;
    [self.view addSubview:_buttom];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark 观察者
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"%@",keyPath);
    NSLog(@"%@",change);
    NSLog(@"%@",[change objectForKey:@"new"]);
    
    [self removeObserver:self forKeyPath:@"isReturn"];
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
