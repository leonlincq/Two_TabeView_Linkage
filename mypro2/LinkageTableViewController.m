//
//  LinkageTableViewController.m
//  mypro2
//
//  Created by etcxm on 16/10/9.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "LinkageTableViewController.h"
#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"
#import "CategoryModel.h"
#import "TableViewHeaderView.h"
#import "ChainReactionView.h"

@interface LinkageTableViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSInteger _selectIndex;
    BOOL _isScrollDown;
}

@property (nonatomic, strong) NSMutableArray *categoryData;
@property (nonatomic, strong) NSMutableArray *foodData;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) UIView *shopView;



@property (nonatomic, strong) NSArray *fontName;
@property (nonatomic, strong) NSMutableArray *allFont;

@end

@implementation LinkageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    
//    self.view.backgroundColor = [UIColor whiteColor];
//    
//    _selectIndex = 0;
//    _isScrollDown = YES;
//    
//    [self.view addSubview:self.leftTableView];
//    [self.view addSubview:self.rightTableView];
//    [self.view addSubview:self.shopView];
//    
//    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    ChainReactionView *chainView = [[ChainReactionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
    
    [self.view addSubview:chainView];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 懒加载

- (NSArray *)fontName
{
    if (!_fontName)
    {
        _fontName = [UIFont familyNames];
    }
    return _fontName;
}

- (NSMutableArray *)allFont
{
    if (!_allFont)
    {
        _allFont = [[NSMutableArray alloc]init];
        
        for (NSUInteger i = 0; i < self.fontName.count; i++)
        {
            NSArray *tempArray = [UIFont fontNamesForFamilyName:self.fontName[i]];
            [_allFont addObject:tempArray];
        }
    }
    return _allFont;
}

- (NSMutableArray *)categoryData
{
    if (!_categoryData)
    {
        _categoryData = [NSMutableArray array];
    }
    return _categoryData;
}

- (NSMutableArray *)foodData
{
    if (!_foodData)
    {
        _foodData = [NSMutableArray array];
    }
    return _foodData;
}

- (UITableView *)leftTableView
{
    if (!_leftTableView)
    {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 150 + 0, 80, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.rowHeight = 55;
        _leftTableView.tableFooterView = [UIView new];
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.separatorColor = [UIColor clearColor];
        [_leftTableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:LeftTableView_CellIdentifier];
    }
    return _leftTableView;
}

- (UITableView *)rightTableView
{
    if (!_rightTableView)
    {
        _rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(80,150 + 0, SCREEN_WIDTH - 80, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.rowHeight = 80;
        _rightTableView.showsVerticalScrollIndicator = NO;
        [_rightTableView registerClass:[RightTableViewCell class] forCellReuseIdentifier:RightTableView_CellIdentifier];
    }
    return _rightTableView;
}

- (UIView *)shopView
{
    if (!_shopView)
    {
        _shopView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,150)];
        _shopView.backgroundColor = [UIColor orangeColor];
        _shopView.alpha = 0.7;
    }
    return _shopView;
}

#pragma mark - UITableView代理
//===================================================
//   该TableView有多少组
//===================================================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_leftTableView == tableView)
    {
        return 1;
    }
    else
    {
//        return self.categoryData.count;
        return self.fontName.count;
    }
}

//===================================================
//   该组有多少行
//===================================================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_leftTableView == tableView)
    {
//        return self.categoryData.count;
        return self.fontName.count;
    }
    else
    {
//        return [self.foodData[section] count];
        return [UIFont fontNamesForFamilyName:self.fontName[section]].count;
    }

}

//===================================================
//   单元格内容
//===================================================
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_leftTableView == tableView)
    {
        LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LeftTableView_CellIdentifier forIndexPath:indexPath];

//        FoodModel *model = self.categoryData[indexPath.row];
//        cell.name.text = model.name;
        
        cell.cellLabel.text = self.fontName[indexPath.row];
        return cell;
    }
    else
    {
        RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RightTableView_CellIdentifier forIndexPath:indexPath];
//        FoodModel *model = self.foodData[indexPath.section][indexPath.row];
//        cell.model = model;
        
        [cell setGoodsNameLabelText:[[UIFont fontNamesForFamilyName:self.fontName[indexPath.section]] objectAtIndex:indexPath.row]];

        return cell;
    }
}

//===================================================
//   组头高度
//===================================================
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_rightTableView == tableView)
    {
        return 20;          //以后宏定义
    }
    return 0;
}

//===================================================
//   组头展示
//===================================================
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_rightTableView == tableView)
    {
        TableViewHeaderView *view = [[TableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
//        FoodModel *model = self.categoryData[section];
//        view.name.text = model.name;
        view.headerLabel.text = self.fontName[section];
        return view;
    }
    return nil;
}

//===================================================
//   组头将要出现
//===================================================
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向上，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView) && !_isScrollDown && _rightTableView.dragging)
    {
        [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}

//===================================================
//   组头将要消失
//===================================================
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向下，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView) && _isScrollDown && _rightTableView.dragging)
    {
        [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:(section + 1) inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}

//===================================================
//   选中单元格
//===================================================
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (_leftTableView == tableView)
    {
        _selectIndex = indexPath.row;
        [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_selectIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}


#pragma mark - UISrcollView代理
//===================================================
//   标记TableView的滚动方向(是向上还是向下)
//              Table继承于Srcoll,可以用父类的代理
//===================================================
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat lastOffsetY = 0;
    
    UITableView *tableView = (UITableView *) scrollView;
    if (_rightTableView == tableView)
    {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
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
