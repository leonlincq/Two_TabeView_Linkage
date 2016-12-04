//
//  tempViewController.m
//  mypro2
//
//  Created by etcxm on 16/10/11.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "tempViewController.h"
#import "RootViewController.h"
#import "CreatPlist.h"

//#import "ManageShopCar.h"
//#import "OpShopCar.h"
//
//#import "ManageOrder.h"
//#import "OpOrder.h"

#import "OrderViewController.h"



@interface tempViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *myTabView;

@property (nonatomic,strong) NSArray *myShopArray;

@end

@implementation tempViewController


+ (void)initialize
{
    [CreatPlist CreatUserinfoPlist];
}

-(UITableView *)myTabView
{
    if (!_myTabView)
    {
        _myTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - 20) style:UITableViewStylePlain];
        _myTabView.dataSource = self;
        _myTabView.delegate = self;
    }
    return _myTabView;
}

-(NSArray *)myShopArray
{
    if (!_myShopArray)
    {
        _myShopArray = [[NSArray alloc]initWithObjects:@"转转乐(湖里万达店)",@"意享披萨(钟宅店)",@"QQ脆皮鸡排",@"骨之味",@"甜丫丫",@"正宗骨汤麻辣烫",@"食尚煲仔饭(蔡塘店)",@"鲜芋仙",@"老塞行动咖啡",@"85°C",nil];
    }
    return _myShopArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myCellID = @"homeCellID";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCellID];
        
        if (indexPath.row <10)
        {
            cell.textLabel.text = self.myShopArray[indexPath.row];
            cell.textLabel.textColor = [UIColor blackColor];
        }
        else
        {
            cell.textLabel.text = @"充值";
            cell.textLabel.textColor = [UIColor redColor];
        }
    }
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 10)
    {
        
        _shopAndGoodsModel = [[SectionThirdModel alloc]init];
        _shopAndGoodsModel.storeName = self.myShopArray[indexPath.row];
        
        RootViewController *tempRoot = [[RootViewController alloc]init];
        tempRoot.shopAndGoodsModel = _shopAndGoodsModel;
        
        [self presentViewController:tempRoot animated:YES completion:^{
            
        }];
    }
    else
    {
        NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]  stringByAppendingPathComponent:@"userinfo.plist"];
        
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
        
        [tempDic setObject:@"1000" forKey:@"余额"];
        
        BOOL isOK = [tempDic writeToFile:path atomically:YES];
        
        
        UIAlertController *tempAlert = [UIAlertController alertControllerWithTitle:@"充值" message:isOK?@"充值成功":@"失败" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *tempAlertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [tempAlert addAction:tempAlertAction];
        [self presentViewController:tempAlert animated:YES completion:^{
            
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view addSubview:self.myTabView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
