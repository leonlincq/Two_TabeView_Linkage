//
//  MakeOrderViewController.m
//  mypro2
//
//  Created by etcxm on 16/10/18.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "MakeOrderViewController.h"
#import "CircleRevolve.h"

#import "ManageOrder.h"
#import "OpOrder.h"

#define tempCir_TAG         101
#define tempNotiView_TAG    102
#define toOrderButton_TAG   103


@interface MakeOrderViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIView *titleView;

@property (nonatomic,strong) UITableView *orderTableView;

@property (nonatomic,strong) UIView *ButtomView;

@property (nonatomic,strong) UILabel *moneyLabel;

@property (nonatomic,assign) NSUInteger checkAddress;

@property (nonatomic,assign) BOOL isMakingOrder;

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
        _checkAddress = 0;
        _isMakingOrder = NO;
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
        toOrderButton.tag = toOrderButton_TAG;
        toOrderButton.backgroundColor = [UIColor redColor];
        [toOrderButton setTitle:@"确认下单" forState:UIControlStateNormal];
        toOrderButton.titleLabel.textColor = [UIColor whiteColor];
        toOrderButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
        [toOrderButton addTarget:self action:@selector(sureToOrder:) forControlEvents:UIControlEventTouchUpInside];
        [_ButtomView addSubview:toOrderButton];
    }
    return _ButtomView;
}

#pragma mark - 返回图片点击
- (void)backTap:(UITapGestureRecognizer *)recognizer
{
    if (_isMakingOrder)
    {
        return;
    }
    
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
            return [self readAddressNumbByPlist];       //4个地址
            
        case 1:
            return 2;       //付款方式
            
        case 2:
            return self.allChooseGoods.count + 3;   //商品 + 商店 + 配送费 + 价格
            
        default:
            return 1;   //不可能运行到这里
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
            cell.textLabel.text = [self readAddressNameByPlistAtIndex:indexPath.row];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.text = @" ";
            if (_checkAddress == indexPath.row)
            {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            break;
            
        case 1:
            if (indexPath.row == 0)
            {
                cell.textLabel.text = @"使用余额";
                cell.textLabel.textColor = [UIColor blackColor];
                cell.detailTextLabel.text = [self readMoneyByPlist];
            }
            else
            {
                cell.textLabel.text = @"使用支付宝";
                cell.textLabel.textColor = [UIColor grayColor];
                cell.detailTextLabel.text = @"暂不支持😏";
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
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
                cell.textLabel.text = @"配送费 : ";
                cell.textLabel.textColor = [UIColor blackColor];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",[self readSentMoney]];
            }
            else if (indexPath.row == self.allChooseGoods.count+2)
            {
                cell.textLabel.text =  @" ";
                cell.detailTextLabel.text =[NSString stringWithFormat:@"共计 : %ld",[self countMoney] + [self readSentMoney]];
            }
            else
            {
                cell.textLabel.text = [self.allChooseGoods[indexPath.row - 1 ] objectForKey:@"goodsName"];
                cell.textLabel.textColor = [UIColor blackColor];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"x%@ ￥%@",[self.allChooseGoods[indexPath.row - 1 ] objectForKey:@"numb"],[self.allChooseGoods[indexPath.row - 1 ] objectForKey:@"money"]];
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - 代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        _checkAddress = indexPath.row;
    }
    
    [self.orderTableView reloadData];
}


#pragma mark - 总金额计算
-(NSInteger)countMoney
{
    NSInteger sumMoney = 0;
    for (NSUInteger i = 0; i < _allChooseGoods.count; i++)
    {
        sumMoney += [[self.allChooseGoods[i] objectForKey:@"money"]integerValue];
    }
    return sumMoney;
}

#pragma mark - 读取配送费
-(NSInteger)readSentMoney
{
    NSDictionary *tempDic = self.allChooseGoods[0];
    
    return [[tempDic objectForKey:@"sentMoney"]integerValue];
}

#pragma mark - 左下角总金额
-(void)setAllChooseGoods:(NSArray *)allChooseGoods
{
    _allChooseGoods = allChooseGoods;
//    NSLog(@"%@",_allChooseGoods);
    
    self.moneyLabel.text = [NSString stringWithFormat:@"共计 : %ld",[self countMoney] + [self readSentMoney]];
    self.moneyLabel.textColor = [UIColor blackColor];
}



#pragma mark - 读取登录信息
-(NSString *)readUserNameByPlist
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"userinfo" ofType:@"plist"];
    
    NSDictionary *tempDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    return [tempDic objectForKey:@"手机号码"];
}

-(NSString *)readMoneyByPlist
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"userinfo" ofType:@"plist"];
    
    NSDictionary *tempDic = [NSDictionary dictionaryWithContentsOfFile:path];

    return [tempDic objectForKey:@"余额"];
}

-(NSUInteger)readAddressNumbByPlist
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"userinfo" ofType:@"plist"];
    
    NSDictionary *tempDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSArray *tempAddress  = [tempDic objectForKey:@"地址"];

    return tempAddress.count;
}


-(NSString *)readAddressNameByPlistAtIndex:(NSUInteger)index
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"userinfo" ofType:@"plist"];
    
    NSDictionary *tempDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSArray *tempAddress  = [tempDic objectForKey:@"地址"];
    
    NSArray *detailAddress = tempAddress[index];
    
    NSString *address = [NSString  stringWithFormat:@"地址%ld : %@,%@,%@,%@",index+1,detailAddress[0],detailAddress[1],detailAddress[2],detailAddress[3]];
    
    return address;
}
#pragma mark - 修改登录信息
-(void)changeMoneyByPlist:(NSUInteger)money
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"userinfo" ofType:@"plist"];
    
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    NSUInteger myMoney = [[tempDic objectForKey:@"余额"]integerValue];
    
    [tempDic setObject:[NSString stringWithFormat:@"%ld",myMoney - money] forKey:@"余额"];
    [tempDic writeToFile:path atomically:YES];
    
}

#pragma mark - 生成订单
-(void)sureToOrder:(UIButton *)buttonClick
{
    _isMakingOrder = YES;
    buttonClick.enabled = NO;
    
    if ([[self readMoneyByPlist]integerValue]< [self countMoney] + [self readSentMoney])
    {
        UILabel *tempNotiView = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-50, 100, 100)];
        tempNotiView.backgroundColor = [UIColor grayColor];
        tempNotiView.text = @"余额不足";
        tempNotiView.textColor = [UIColor redColor];
        tempNotiView.font = [UIFont boldSystemFontOfSize:17.0];
        tempNotiView.textAlignment = NSTextAlignmentCenter;
        tempNotiView.alpha = 0.8;
        tempNotiView.layer.masksToBounds = YES;
        [tempNotiView.layer setCornerRadius:20];
        tempNotiView.tag = tempNotiView_TAG;
        [self.view addSubview:tempNotiView];
        
        [self performSelector:@selector(removeNotiView) withObject:nil afterDelay:2];
        
        return;
    }
    
    CircleRevolve *tempCir = [[CircleRevolve alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-100, 200, 200)];
    tempCir.tag = tempCir_TAG;
    [self.view addSubview:tempCir];
    
    [self performSelector:@selector(showLabelView) withObject:nil afterDelay:2];
}

-(void)showLabelView
{
    CircleRevolve *temp = [self.view viewWithTag:tempCir_TAG];
    [temp removeFromSuperview];
    
    UILabel *tempNotiView = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-50, 100, 100)];
    tempNotiView.backgroundColor = [UIColor grayColor];
    tempNotiView.text = @"订单生成成功";
    tempNotiView.textColor = [UIColor blackColor];
    tempNotiView.font = [UIFont boldSystemFontOfSize:14.0];
    tempNotiView.textAlignment = NSTextAlignmentCenter;
    tempNotiView.alpha = 0.8;
    tempNotiView.layer.masksToBounds = YES;
    [tempNotiView.layer setCornerRadius:20];
    [self.view addSubview:tempNotiView];
    
    [self changeMoneyByPlist:([self countMoney] + [self readSentMoney])];
    [self makeNewOrder];
    
    [self performSelector:@selector(backToRoot) withObject:nil afterDelay:2];
}

#pragma mark - 订单生产 判断订单号
-(void)makeNewOrder
{
    NSMutableArray *saveArray = [[NSMutableArray alloc]init];
    ManageOrder *orderModel = [[ManageOrder alloc]init];
    
    orderModel.orderNum = @"1";     //设置订单号
    while (1)
    {
        [OpOrder selectOrderByWho:orderModel withStatu:OrderSelect_orderNum andSaveArray:&saveArray];
        
        if (saveArray.count == 0)
        {
            break;
        }
        else
        {
            orderModel.orderNum = [NSString stringWithFormat:@"%ld",[orderModel.orderNum integerValue]+1];
        }
    }
    
    orderModel.orderState       = @"等待收货";      //订单状态
    orderModel.orderEva         = nil;          //订单评价
    orderModel.orderEvaStart    = nil;          //订单评价星级
    orderModel.buyer            = [self readUserNameByPlist];   //购买者
    orderModel.shopName         = self.storeName;               //商店名字
    orderModel.address          = [self readAddressNameByPlistAtIndex:self.checkAddress];   //收货地址
    
    for (NSUInteger i = 0; i < self.allChooseGoods.count; i++)
    {
        NSDictionary *tempDic = self.allChooseGoods[i];
        
        orderModel.goodName     = [tempDic objectForKey:@"goodsName"];  //商品名字
        orderModel.goodPrice    = [tempDic objectForKey:@"price"];      //商品价格
        orderModel.goodNum      = [tempDic objectForKey:@"numb"];        //商品数量
        orderModel.goodAllMoney = [tempDic objectForKey:@"money"];      //商品总金额
        
        [OpOrder addToOrder:orderModel];
    }
}

-(void)backToRoot
{
    self.presentingViewController.view.alpha = 0;
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
    } ];
}

-(void)removeNotiView
{
    UILabel *temp = [self.view viewWithTag:tempNotiView_TAG];
    [temp removeFromSuperview];
    _isMakingOrder = NO;
    UIButton *sureButton = [self.ButtomView viewWithTag:toOrderButton_TAG];
    sureButton.enabled = YES;
}



@end
