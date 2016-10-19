//
//  MakeOrderViewController.m
//  mypro2
//
//  Created by etcxm on 16/10/18.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "MakeOrderViewController.h"
#import "VWWWaterView.h"

@interface MakeOrderViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIView *titleView;

@property (nonatomic,strong) UITableView *orderTableView;

@property (nonatomic,strong) UIView *ButtomView;

@property (nonatomic,strong) UILabel *moneyLabel;

@end


@implementation MakeOrderViewController


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self.view addSubview:self.titleView];
        [self.view addSubview:self.orderTableView];
        [self.view addSubview:self.ButtomView];
    }
    return self;
}

#pragma mark - 懒加载
-(UIView *)titleView
{
    if (!_titleView)
    {
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,FALSE_NAVI_HEIGHT + STATUS_HEIGHT)];
        _titleView.backgroundColor = [UIColor whiteColor];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100,STATUS_HEIGHT , 200, FALSE_NAVI_HEIGHT)];
        title.text = @"提交订单";
        title.font = [UIFont boldSystemFontOfSize:20.0];
        title.textAlignment = NSTextAlignmentCenter;
        [_titleView addSubview:title];
        
        
        UIView *backButton = [[UIView alloc]initWithFrame:CGRectMake(0, 0, FALSE_NAVI_HEIGHT + STATUS_HEIGHT, FALSE_NAVI_HEIGHT + STATUS_HEIGHT)];
        
        UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(13, STATUS_HEIGHT + 13, FALSE_NAVI_HEIGHT - 26, FALSE_NAVI_HEIGHT - 26)];
        [backImageView setImage:[UIImage imageNamed:@"NaviBackButton"]];
        [backButton addSubview:backImageView];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backTap:)];
        [backButton addGestureRecognizer:tapGes];
        
        [_titleView addSubview:backButton];
    }
    return _titleView;
}

-(UITableView *)orderTableView
{
    if (!_orderTableView)
    {
        _orderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, FALSE_NAVI_HEIGHT + STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FALSE_NAVI_HEIGHT - STATUS_HEIGHT - 60) style:UITableViewStyleGrouped];
        _orderTableView.dataSource = self;
        _orderTableView.delegate = self;
        _orderTableView.allowsSelection = NO;
        _orderTableView.showsVerticalScrollIndicator = NO;
    }
    return _orderTableView;
}

-(UIView *)ButtomView
{
    if (!_ButtomView)
    {
        _ButtomView = [[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT - 60, SCREEN_WIDTH, 60)];
        _ButtomView.backgroundColor = [UIColor whiteColor];
        
        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 60)];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        [_ButtomView addSubview:_moneyLabel];
        
        UIButton *toOrderButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 0, 100, 60)];
        toOrderButton.backgroundColor = [UIColor redColor];
        [toOrderButton setTitle:@"确认下单" forState:UIControlStateNormal];
        toOrderButton.titleLabel.textColor = [UIColor whiteColor];
        toOrderButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
        [_ButtomView addSubview:toOrderButton];
    }
    return _ButtomView;
}

#pragma mark - 返回图片点击
- (void)backTap:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"点击");
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return 4;       //4个地址
            
        case 1:
            return 2;       //付款方式
            
        case 2:
            return self.allChooseGoods.count + 2;   //商品 + 商店 + 价格
            
        default:
            return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    
    switch (indexPath.section)
    {
        case 0:
            cell.textLabel.text = [NSString stringWithFormat:@"这里是地址%ld",indexPath.row];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.text = @" ";
            break;
            
        case 1:
            cell.textLabel.text = [NSString stringWithFormat:@"这里是付款方式%ld",indexPath.row];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.text = @" ";
            break;
            
        case 2:
            
            if (indexPath.row == 0)
            {
                cell.textLabel.text = [NSString stringWithFormat:@"商店 : %@",self.storeName];
                cell.textLabel.textColor = [UIColor redColor];
                cell.detailTextLabel.text = @" ";
            }
            else if (indexPath.row == self.allChooseGoods.count+1)
            {
                cell.textLabel.text = [NSString stringWithFormat:@"共计 : %ld",[self countMoney]];
                cell.textLabel.textColor = [UIColor redColor];
                cell.detailTextLabel.text = @" ";
            }
            else
            {
                cell.textLabel.text = [self.allChooseGoods[indexPath.row - 1 ] objectForKey:@"goodsName"];
                cell.textLabel.textColor = [UIColor blackColor];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"x%@ ￥%@",[self.allChooseGoods[indexPath.row - 1 ] objectForKey:@"numb"],[self.allChooseGoods[indexPath.row - 1 ] objectForKey:@"money"]];
            }

            break;
            
        default:
            break;
    }
    
    return cell;
}

-(NSInteger)countMoney
{
    NSInteger sumMoney = 0;
    for (NSUInteger i = 0; i < _allChooseGoods.count; i++)
    {
        sumMoney += [[self.allChooseGoods[i] objectForKey:@"money"]integerValue];
    }
    return sumMoney;
}

-(void)setAllChooseGoods:(NSArray *)allChooseGoods
{
    _allChooseGoods = allChooseGoods;
    
    NSLog(@"%@",_allChooseGoods);
    
    self.moneyLabel.text = [NSString stringWithFormat:@"共计 : %ld",[self countMoney]];
    self.moneyLabel.textColor = [UIColor blackColor];
}

@end
