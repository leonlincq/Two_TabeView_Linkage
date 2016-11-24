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
#import "ShopToolbar.h"

#import "MakeOrderViewController.h"

#import "GoodsDetailViewController.h"

#define shopDetaiToolbar_TAG 101



@interface RootViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *myScrollView;

@property (nonatomic,strong) ShopNaviView *failnaviView;
@property (nonatomic,strong) ShopDetailView *stopView;
@property (nonatomic,strong) ChainReactionView *chainView;
@property (nonatomic,strong) ShopCarView *buttomView;
@property (nonatomic,strong) UIButton *shopCarImageView;
@property (nonatomic,strong) UILabel *shopCarNumLabel;


@property (nonatomic,strong) UIButton *shopDetaiButton;
@property (nonatomic,strong) ShopToolbar *shopDetaiToolbar;

@property (nonatomic,strong) NSMutableArray *allGoodsArray;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    self.shopAndGoodsModel = [self baseOnShopNameSearchModel];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goodsAddDealWith:) name:@"AddButtonClick" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goodsSubDealWith:) name:@"SubButtonClick" object:nil];
    
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
    _chainView = [[ChainReactionView alloc] initWithFrame:CGRectMake(0, SHOPDETAIL_HEIGHT + FALSE_NAVI_HEIGHT  + STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FALSE_NAVI_HEIGHT - SHOPCAR_HEIGHT - STATUS_HEIGHT - SHOPDETAIL_HEIGHT) andSetModel:self.shopAndGoodsModel];
    
    _chainView.linkView.CellDelegate = self;
    
    [_myScrollView addSubview:_chainView];
    
    //添加最下面的商店信息
    _buttomView = [[ShopCarView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT-SHOPCAR_HEIGHT, SCREEN_WIDTH,SHOPCAR_HEIGHT)];
    _buttomView.alpha = 0.8;
    _buttomView.toOrderDelegate = self;
    _buttomView.sentPrice = [self.shopAndGoodsModel.sellPrace substringWithRange:NSMakeRange(3, 3)];
    [self.view addSubview:_buttomView];
    
    [self.view addSubview:self.shopCarImageView];
    
    _shopDetaiButton = [[UIButton alloc]initWithFrame:CGRectMake(0,STATUS_HEIGHT + FALSE_NAVI_HEIGHT,SCREEN_WIDTH, SHOPDETAIL_HEIGHT)];
    [_shopDetaiButton addTarget:self action:@selector(shopDetailClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.myScrollView addSubview:_shopDetaiButton];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载
-(UIButton *)shopCarImageView
{
    if (!_shopCarImageView)
    {
        _shopCarImageView = [[UIButton alloc]initWithFrame:CGRectMake(8,SCREEN_HEIGHT-8-50, 50, 50)];
        [_shopCarImageView setBackgroundImage:[UIImage imageNamed:@"shopCarPic"] forState:UIControlStateNormal];
 
        
        _shopCarNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(50-18,0, 18, 18)];
        _shopCarNumLabel.textAlignment = NSTextAlignmentCenter;
        _shopCarNumLabel.backgroundColor = [UIColor redColor];
        _shopCarNumLabel.textColor = [UIColor whiteColor];
        _shopCarNumLabel.layer.masksToBounds = YES;
        [_shopCarNumLabel.layer setCornerRadius:9.0];
        
        _shopCarImageView.backgroundColor = [UIColor clearColor];
        
        [_shopCarImageView addSubview:_shopCarNumLabel];
        _shopCarNumLabel.hidden = YES;
    }
    return _shopCarImageView;
}


-(NSMutableArray *)allGoodsArray
{
    if (!_allGoodsArray)
    {
        _allGoodsArray = [[NSMutableArray alloc]init];
    }
    return _allGoodsArray;
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
    ShopToolbar *tempToolView = [self.view viewWithTag:shopDetaiToolbar_TAG];
    [tempToolView removeFromSuperview];
}

-(void)ClickTabelViewCellWithGoodsDic:(NSDictionary *)dic
{

    GoodsDetailViewController *goodDetail = [[GoodsDetailViewController alloc]initWithDic:dic];

    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self presentViewController:goodDetail animated:YES completion:^{
            
        }];
    });

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
//    NSLog(@"%@",keyPath);
//    NSLog(@"%@",change);
//    NSLog(@"%@",[change objectForKey:@"new"]);
    
    [self removeObserver:self forKeyPath:@"isReturn"];
}
#endif


#pragma mark -商家详情按钮
- (void)shopDetailClick:(UIButton *)button
{
    ShopToolbar *shopDetaiToolbar = [[ShopToolbar alloc]initWithFrame:[UIScreen mainScreen].bounds];
    shopDetaiToolbar.backDelegate = self;
    shopDetaiToolbar.shopData = _shopAndGoodsModel;
    shopDetaiToolbar.tag = shopDetaiToolbar_TAG;
    [self.view addSubview:shopDetaiToolbar];
}

//-(void)setShopAndGoodsModel:(SectionThirdModel *)shopAndGoodsModel
//{
//    _shopAndGoodsModel = shopAndGoodsModel;
//
//    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
//    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
//    
//    [tempDic setObject:shopAndGoodsModel.actionInfo1 forKey:@"actionInfo1"];
//    [tempDic setObject:shopAndGoodsModel.actionInfo2 forKey:@"actionInfo2"];
//    [tempDic setObject:shopAndGoodsModel.actionInfo3 forKey:@"actionInfo3"];
//    [tempDic setObject:shopAndGoodsModel.actionInfo4 forKey:@"actionInfo4"];
//
//    [tempDic setObject:shopAndGoodsModel.storeName forKey:@"storeName"];
//    [tempDic setObject:shopAndGoodsModel.storeImage forKey:@"storeImage"];
//    [tempDic setObject:shopAndGoodsModel.sell forKey:@"sell"];
//    [tempDic setObject:shopAndGoodsModel.comment forKey:@"comment"];
//    [tempDic setObject:shopAndGoodsModel.sellPrace forKey:@"sellPrace"];
//    [tempDic setObject:shopAndGoodsModel.maxTime forKey:@"maxTime"];
//    [tempDic setObject:shopAndGoodsModel.distance forKey:@"distance"];
//    
//    [tempArray addObject:tempDic];
//    [tempArray writeToFile:[NSHomeDirectory() stringByAppendingPathComponent:@"homeToMe"] atomically:YES];
//}

#pragma mark - 购物车动画效果
-(void)goodsAddDealWith:(NSNotification *)noti
{
//    NSLog(@"%@",[noti.userInfo objectForKey:@"indexPath"]);
//    NSLog(@"++");
    [self readAndCountPlistByIndexPath:[noti.userInfo objectForKey:@"indexPath"] AndAlgo:Algo_Add];
//    NSLog(@"%@",self.allGoodsArray);
    

    NSInteger count = [self sumGoodsNumb];
    _shopCarNumLabel.text = [NSString stringWithFormat:@"%ld",count];
    _shopCarNumLabel.hidden = NO;
    
    _buttomView.shopCarPrice = [NSString stringWithFormat:@"共￥%ld",[self sumGoodsMoney]];
    
    if (count >=100 && count<1000)
    {
        _shopCarNumLabel.font = [UIFont systemFontOfSize:10];
    }
    if (count >=10 && count<100)
    {
        _shopCarNumLabel.font = [UIFont systemFontOfSize:14];
    }
    if (count >=0 && count<10)
    {
        _shopCarNumLabel.font = [UIFont systemFontOfSize:20];
    }
    
    [noti.userInfo objectForKey:@"indexPath"];
    CGPoint tempPoint ;
    tempPoint.x = [[noti.userInfo objectForKey:@"clickPointX"]floatValue];
    tempPoint.y = [[noti.userInfo objectForKey:@"clickPointY"]floatValue];
//    NSLog(@"%lf,%lf",tempPoint.x,tempPoint.y);
    
    
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(tempPoint.x, tempPoint.y, 24, 24)];
    
    tempView.backgroundColor = [UIColor redColor];
    [tempView.layer setCornerRadius:12];
    [self.view addSubview:tempView];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect tempCGRect = tempView.frame;
        tempCGRect.origin.x -= 100;
        tempCGRect.origin.y -= 100;
        tempView.frame = tempCGRect;
        [self performSelector:@selector(secAnimate:) withObject:tempView afterDelay:0.3];
    }];
}

-(void)secAnimate:(UIView *)tempView
{
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect tempCGRect = tempView.frame;
        tempCGRect.origin.x = 10+40-12;
        tempCGRect.origin.y = SCREEN_HEIGHT-10-80 +40 -12;
        tempView.frame = tempCGRect;
        [self performSelector:@selector(killAnimateView:) withObject:tempView afterDelay:0.3];
    }];
}


-(void)killAnimateView:(UIView *)tempView
{
    [tempView removeFromSuperview];
    
    
    [UIView animateWithDuration:0.3 animations:^
     {
         
         CGRect tempRect = self.shopCarImageView.frame;
         
         tempRect.origin.x -= 8;
         tempRect.origin.y -= 8;
         tempRect.size.width +=16;
         tempRect.size.height +=16;
         self.shopCarImageView.frame = tempRect;
         
         [self performSelector:@selector(shopCarbackNomalSize) withObject:nil afterDelay:0.3];
     }];
}

-(void)shopCarbackNomalSize
{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect tempRect = self.shopCarImageView.frame;
        
        tempRect.origin.x += 8;
        tempRect.origin.y += 8;
        tempRect.size.width -=16;
        tempRect.size.height -=16;
        self.shopCarImageView.frame = tempRect;
        
    }];
}

-(void)goodsSubDealWith:(NSNotification *)noti
{
//    NSLog(@"%@",noti.object);
//    NSLog(@"--");
    
    [self readAndCountPlistByIndexPath:noti.object AndAlgo:Algo_Sub];
    NSInteger count = [self sumGoodsNumb];
    if (count != 0)
    {
        _shopCarNumLabel.text = [NSString stringWithFormat:@"%ld",count];
        _buttomView.shopCarPrice = [NSString stringWithFormat:@"共￥%ld",[self sumGoodsMoney]];
    }
    else
    {
        _shopCarNumLabel.text = @" ";
        _shopCarNumLabel.hidden = YES;
        _buttomView.shopCarPrice = @"购物车是空的";
    }

    
//    NSLog(@"%@",self.allGoodsArray);
    
}


#pragma mark - 搜索
-(SectionThirdModel *)baseOnShopNameSearchModel
{
    SectionThirdModel *tempModel = [[SectionThirdModel alloc]init];
    
    tempModel.storeName    = _shopAndGoodsModel.storeName;  //先保存商店名
    
    NSString *tempPath = [[NSBundle mainBundle]pathForResource:@"ShopAndGoods" ofType:@"plist"];
    
    NSArray *tempThirdModel = [[NSDictionary dictionaryWithContentsOfFile:tempPath] objectForKey:@"section3"];
    for (NSUInteger i = 0; i < 10 ; i++)
    {
        
        if ([[[tempThirdModel[i] objectAtIndex:1]objectForKey:@"storeName"]isEqualToString:_shopAndGoodsModel.storeName])
        {
            tempModel.actionInfo1  = [[tempThirdModel[i] objectAtIndex:0]objectAtIndex:0];
            tempModel.actionInfo2  = [[tempThirdModel[i] objectAtIndex:0]objectAtIndex:1];
            tempModel.actionInfo3  = [[tempThirdModel[i] objectAtIndex:0]objectAtIndex:2];
            tempModel.actionInfo4  = [[tempThirdModel[i] objectAtIndex:0]objectAtIndex:3];
            
            tempModel.storeImage   = [[tempThirdModel[i] objectAtIndex:1]objectForKey:@"storeImage"];
            tempModel.sell         = [[tempThirdModel[i] objectAtIndex:1]objectForKey:@"sell"];
            tempModel.comment      = [[tempThirdModel[i] objectAtIndex:1]objectForKey:@"comment"];
            tempModel.sellPrace    = [[tempThirdModel[i] objectAtIndex:1]objectForKey:@"sellPrace"];
            tempModel.maxTime      = [[tempThirdModel[i] objectAtIndex:1]objectForKey:@"maxTime"];
            tempModel.distance     = [[tempThirdModel[i] objectAtIndex:1]objectForKey:@"distance"];
            
        }
    }
//    NSLog(@"%@",tempModel);
    return tempModel;
}


-(void)readAndCountPlistByIndexPath:(NSIndexPath *)indexPath AndAlgo:(Algo)algo
{
    NSUInteger i ;
    
    for (i = 0 ; i < self.allGoodsArray.count ; i++)
    {
        if ([[self.allGoodsArray[i] objectForKey:@"indexPath"]isEqual:indexPath] )
        {
            NSInteger tempNumb  = [[self.allGoodsArray[i] objectForKey:@"numb"]intValue];
            
            if (algo == Algo_Add)
            {
                tempNumb ++;
                [self.allGoodsArray[i] setObject:[NSString stringWithFormat:@"%ld",tempNumb] forKey:@"numb"];
            }
            else if(algo == Algo_Sub)
            {
                if (tempNumb > 1)
                {
                    tempNumb --;
                    [self.allGoodsArray[i] setObject:[NSString stringWithFormat:@"%ld",tempNumb] forKey:@"numb"];
                }
                else if(tempNumb == 1)
                {
                    [self.allGoodsArray removeObjectAtIndex:i];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"ButtonAndArray" object:self.allGoodsArray];
                    return; //移除后即可return
                }
                else
                {
//                    NSLog(@"数量应该为0了，不应该进去这里");
                }
            }
            else
            {
//                NSLog(@"目前只支持加减");
            }
            
            NSInteger tempPrice = [[self.allGoodsArray[i] objectForKey:@"price"]intValue];
            NSInteger tempMoney = tempNumb * tempPrice;
            [self.allGoodsArray[i] setObject:[NSString stringWithFormat:@"%ld",tempMoney] forKey:@"money"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ButtonAndArray" object:self.allGoodsArray];
            return; //修改后即可return
        }
    }
    
    
    
//    if (self.allGoodsArray.count == i )
    if (algo == Algo_Add)   //第一次进入，加法才需要创建
    {
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
        
        [tempDic setObject:indexPath forKey:@"indexPath"];
        

        
        NSArray *tempAllData = [NSArray arrayWithContentsOfFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]  stringByAppendingPathComponent:@"shopCategory.plist"]];      //先拿Plist
        
//        NSLog(@"%@",NSHomeDirectory());
        
        NSDictionary *tempDataDic = tempAllData[indexPath.section];     //再拿第几组
                                
        NSArray *tempArray = [tempDataDic allKeys];                     //获取组名
        
        tempArray = [tempDataDic objectForKey:tempArray[0]];            //拿组名
        
        tempDataDic = tempArray[indexPath.row];                         //拿分组下的单品

        [tempDic setObject:[tempDataDic objectForKey:@"GoodsName"] forKey:@"goodsName"];
        [tempDic setObject:[tempDataDic objectForKey:@"PreferentPrice"] forKey:@"price"];
        [tempDic setObject:@"1" forKey:@"numb"];
        [tempDic setObject:[tempDataDic objectForKey:@"PreferentPrice"] forKey:@"money"];
        
        //截取配送价格的后两位
        NSString *subSomeCharToString = [self.shopAndGoodsModel.sellPrace substringWithRange:NSMakeRange(self.shopAndGoodsModel.sellPrace.length-2-[self.shopAndGoodsModel.sellPrace hasSuffix:@" "], 2)];
        //如果截取到后两位的第一为为“￥”，也就是配送费为个位，再截取
        if ([subSomeCharToString hasPrefix:@"¥"])
        {
            [tempDic setObject:[subSomeCharToString substringWithRange:NSMakeRange(1, 1)] forKey:@"sentMoney"];
        }
        else//配送费为2位数，直接setObject
        {
            [tempDic setObject:subSomeCharToString forKey:@"sentMoney"];
        }
        
        [self.allGoodsArray addObject:tempDic];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ButtonAndArray" object:self.allGoodsArray];
    }
}

-(NSUInteger)sumGoodsNumb
{
    NSUInteger sumNumb = 0;

    for (NSUInteger i = 0 ; i < self.allGoodsArray.count ; i++)
    {
        sumNumb += [[self.allGoodsArray[i] objectForKey:@"numb"]integerValue];
    }
    return sumNumb;
}

-(NSUInteger)sumGoodsMoney
{
    NSUInteger sumGoodsMoney = 0;
    
    for (NSUInteger i = 0 ; i < self.allGoodsArray.count ; i++)
    {
        sumGoodsMoney += [[self.allGoodsArray[i] objectForKey:@"money"]integerValue];
    }
    return sumGoodsMoney;
}

-(void)presentToOrder
{
    MakeOrderViewController *orderPage = [[MakeOrderViewController alloc]init];
    orderPage.allChooseGoods = self.allGoodsArray;
    orderPage.storeName = self.shopAndGoodsModel.storeName;

    [self presentViewController:orderPage animated:YES completion:^{
    }];
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
