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

@interface RootViewController ()

@property (nonatomic, strong) UIView *shopView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加最上面的商店信息
    [self.view addSubview:self.shopView];
    
    //添加中间的scrollView
    ChainReactionView *chainView = [[ChainReactionView alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, SCREEN_HEIGHT - 150)];
    [self.view addSubview:chainView];
    
    //添加下面的两个TableView联动
    LinkageView *linkView = [[LinkageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 150 - 44)];

    chainView.myBlock = ^(UICollectionView *collectionView,NSIndexPath *indexPath)
    {
        switch (indexPath.row)
        {
            case 0:
                [collectionView addSubview:linkView];
                break;
                
            case 1:
                
                break;
                
            case 2:
                
                break;
                
            default:
                break;
        }
    };
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载

- (UIView *)shopView
{
    if (!_shopView)
    {
        _shopView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,150)];
        _shopView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:0.7];
    }
    return _shopView;
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
