//
//  OrderViewController.m
//  mypro2
//
//  Created by etcxm on 16/10/20.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "OrderViewController.h"

#import "OrderTableViewCell.h"

#import "ManageOrder.h"
#import "OpOrder.h"

typedef NS_ENUM(NSUInteger,OrderListViewState)
{
    OrderListViewState_NoLoad,
    OrderListViewState_hasLoadNoOrder,
    OrderListViewState_hasLoadAndOrder
};

@interface OrderViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *allOrderArray;

@property (nonatomic,strong) UITableView *orderListTableView;

@property (nonatomic,strong) UIView *NoLoadView;
@property (nonatomic,strong) UIView *LoadNoOrderView;
@property (nonatomic,strong) UIView *LoadAndOrderView;
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    OrderListViewState state = [self searchOrderList];
    
    //删掉 userinfo.plist 测试
    if (state == OrderListViewState_NoLoad)
    {
        [self.view addSubview:self.NoLoadView];
    }
    //删掉 MyData.sqlite 测试
    else if (state == OrderListViewState_hasLoadNoOrder)
    {
        [self.view addSubview:self.LoadNoOrderView];
    }
    //要有 userinfo.plist 和 MyData.sqlite 才能进入这里
    else if (state == OrderListViewState_hasLoadAndOrder)
    {
        [self.view addSubview:self.LoadAndOrderView];
        [self numberOrderInArray];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载
-(NSMutableArray *)allOrderArray
{
    if (!_allOrderArray)
    {
        _allOrderArray = [[NSMutableArray alloc]init];
    }
    return _allOrderArray;
}

-(UIView *)NoLoadView
{
    if (!_NoLoadView)
    {
        _NoLoadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _NoLoadView.backgroundColor = [UIColor grayColor];
        _NoLoadView.alpha = 0.4;
        
        UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(_NoLoadView.frame.size.width/2-75, _NoLoadView.frame.size.height/2-75, 150, 150)];
        iconView.image = [UIImage imageNamed:@"askLoading"];
        [_NoLoadView addSubview:iconView];
        
        UILabel *loadText = [[UILabel alloc]initWithFrame:CGRectMake(_NoLoadView.frame.size.width/2-150, iconView.frame.origin.y + 150 + 30, 300, 80)];
        loadText.text = @"您还没有登录，请登录后查看订单";
        loadText.textAlignment = NSTextAlignmentCenter;
        [_NoLoadView addSubview:loadText];
    }
    return _NoLoadView;
}


-(UIView *)LoadNoOrderView
{
    if (!_LoadNoOrderView)
    {
        _LoadNoOrderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _LoadNoOrderView.backgroundColor = [UIColor grayColor];
        _LoadNoOrderView.alpha = 0.4;
        
        UILabel *loadText = [[UILabel alloc]initWithFrame:CGRectMake(_LoadNoOrderView.frame.size.width/2-150, _LoadNoOrderView.frame.size.height/2-40, 300, 80)];
        loadText.text = @"您还下单过，快去下第一单吧";
        loadText.textColor = [UIColor blackColor];
        loadText.textAlignment = NSTextAlignmentCenter;
        [_LoadNoOrderView addSubview:loadText];
    }
    return _LoadNoOrderView;
}


-(UIView *)LoadAndOrderView
{
    if (!_LoadAndOrderView)
    {
        _LoadAndOrderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _LoadAndOrderView.backgroundColor = [UIColor grayColor];
        _LoadAndOrderView.alpha = 0.4;
        
        UITableView *orderListView = [[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_HEIGHT + NAVI_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_HEIGHT - NAVI_HEIGHT - TABBAR_HEIGHT) style:UITableViewStyleGrouped];
        orderListView.rowHeight = 120;
        orderListView.showsVerticalScrollIndicator = NO;
        [_LoadAndOrderView addSubview:orderListView];
        orderListView.dataSource = self;
        orderListView.delegate = self;
        [orderListView registerClass:[OrderTableViewCell class] forCellReuseIdentifier:@"orderListCell"];
    }
    return _LoadAndOrderView;
}

#pragma mark - 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self numberOrderInArray];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderListCell" forIndexPath:indexPath];

    cell.shopImageName = @"123";
    cell.shopName = @"asd";
    cell.detailText = @"123asd";
    
    return cell;
}

#pragma mark - 代理
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0;
}




#pragma mark - 读取订单信息
-(OrderListViewState)searchOrderList
{
//    NSLog(@"%@",NSHomeDirectory());
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]  stringByAppendingPathComponent:@"userinfo.plist"];
    
    NSDictionary *tempDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    if (tempDic == nil)
    {
        return OrderListViewState_NoLoad;
    }
    else
    {
        NSMutableArray *tempArray = [[NSMutableArray alloc]init];
        
        ManageOrder *tempManageOrder = [[ManageOrder alloc]init];
        tempManageOrder.buyer = [tempDic objectForKey:@"手机号码"];
        
        [OpOrder selectOrderByWho:tempManageOrder withStatu:OrderSelect_Buyer andSaveArray:&tempArray];
        
        if (tempArray.count == 0)
        {
            return OrderListViewState_hasLoadNoOrder;
        }
        else
        {
            self.allOrderArray = [NSMutableArray arrayWithArray:tempArray];
            return OrderListViewState_hasLoadAndOrder;
        }
    }
}

-(NSUInteger)numberOrderInArray
{
    NSMutableSet *orderSet = [[NSMutableSet alloc]init];

    for (NSUInteger i = 0; i<self.allOrderArray.count; i++)
    {
        ManageOrder *tempOrder = self.allOrderArray[i];
        
        [orderSet addObject:tempOrder.orderNum];
    }
    return orderSet.count;
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
