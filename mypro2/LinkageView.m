//
//  LinkageView.m
//  mypro2
//
//  Created by etcxm on 16/10/10.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "LinkageView.h"
#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"
#import "CategoryModel.h"
#import "TableViewHeaderView.h"


@interface LinkageView () <UITableViewDelegate, UITableViewDataSource>
{
    NSInteger _selectIndex;
    BOOL _isScrollDown;
}

@property (nonatomic, strong) NSMutableArray *categoryData;
@property (nonatomic, strong) NSMutableArray *foodData;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;

@property (nonatomic, strong) NSMutableArray *currenShopAllGood;
@property (nonatomic, strong) CategoryModel *goodmodel;

@property (nonatomic, strong) NSArray *goodCategory;

@property (nonatomic, strong) NSMutableArray *Category_taocan;
@property (nonatomic, strong) NSMutableArray *Category_dangpin;
@property (nonatomic, strong) NSMutableArray *Category_yinpin;
@property (nonatomic, strong) NSMutableArray *Category_rexiao;

@property (nonatomic,strong) NSArray *buttonStates;

@end


@implementation LinkageView

- (instancetype)initWithFrame:(CGRect)frame  andSetModel:(SectionThirdModel *)shopAndGoodsModel
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _shopAndGoodsModel = shopAndGoodsModel;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self searchCurrenShopDetail];
        
        _selectIndex = 0;
        _isScrollDown = YES;
        
        [self addSubview:self.leftTableView];
        [self addSubview:self.rightTableView];
        
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeCell:) name:@"ButtonAndArray" object:nil];
    }
    return self;
}



#pragma mark - 懒加载
- (NSMutableArray *)currenShopAllGood
{
    if (!_currenShopAllGood)
    {
        _currenShopAllGood = [[NSMutableArray alloc]init];
    }
    return _currenShopAllGood;
}

- (CategoryModel *)goodmodel
{
    if (!_goodmodel)
    {
        _goodmodel = [[CategoryModel alloc]init];
    }
    return _goodmodel;
}

- (NSArray *)goodCategory
{
    if (!_goodCategory)
    {
        _goodCategory = [[NSArray alloc]init];
    }
    return _goodCategory;
}

- (NSMutableArray *)Category_taocan
{
    if (!_Category_taocan)
    {
        _Category_taocan = [[NSMutableArray alloc]init];
    }
    return _Category_taocan;
}

- (NSMutableArray *)Category_dangpin
{
    if (!_Category_dangpin)
    {
        _Category_dangpin = [[NSMutableArray alloc]init];
    }
    return _Category_dangpin;
}

- (NSMutableArray *)Category_yinpin
{
    if (!_Category_yinpin)
    {
        _Category_yinpin = [[NSMutableArray alloc]init];
    }
    return _Category_yinpin;
}

- (NSMutableArray *)Category_rexiao
{
    if (!_Category_rexiao)
    {
        _Category_rexiao = [[NSMutableArray alloc]init];
    }
    return _Category_rexiao;
}

- (NSArray *)buttonStates
{
    if (!_buttonStates)
    {
        _buttonStates = [[NSArray alloc]init];
    }
    return _buttonStates;
}


- (UITableView *)leftTableView
{
    if (!_leftTableView)
    {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 80, self.frame.size.height) style:UITableViewStylePlain];
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
        _rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(80,0, SCREEN_WIDTH - 80, self.frame.size.height) style:UITableViewStylePlain];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.rowHeight = 80;
        _rightTableView.showsVerticalScrollIndicator = NO;
        [_rightTableView registerClass:[RightTableViewCell class] forCellReuseIdentifier:RightTableView_CellIdentifier];
    }
    return _rightTableView;
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
        return _goodCategory.count;
    }
}

//===================================================
//   该组有多少行
//===================================================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_leftTableView == tableView)
    {
        return _goodCategory.count;   //4种类别
    }
    else
    {
        NSString *tempString = _goodCategory[section];
        
        if ([tempString isEqualToString:@"套餐"])
        {
            return _Category_taocan.count;
        }
        if ([tempString isEqualToString:@"单品"])
        {
            return _Category_dangpin.count;
        }
        if ([tempString isEqualToString:@"饮品"])
        {
            return _Category_yinpin.count;
        }
        if ([tempString isEqualToString:@"热销"])
        {
            return _Category_rexiao.count;
        }
        return 1;   //防报警
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
        
        cell.cellLabel.text = _goodCategory[indexPath.row];
        return cell;
    }
    else
    {
        RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RightTableView_CellIdentifier forIndexPath:indexPath];
        cell.indexPath = indexPath;
        
        if ([self.goodCategory[indexPath.section]isEqualToString:@"套餐"])
        {
            cell.goodModel = [self GoodModelWithaArray:self.Category_taocan IndexPath:indexPath];
        }
        
        if ([self.goodCategory[indexPath.section] isEqualToString:@"单品"])
        {
            cell.goodModel = [self GoodModelWithaArray:self.Category_dangpin IndexPath:indexPath];
        }
        
        if ([self.goodCategory[indexPath.section] isEqualToString:@"饮品"])
        {
            cell.goodModel = [self GoodModelWithaArray:self.Category_yinpin IndexPath:indexPath];
        }

        if ([self.goodCategory[indexPath.section] isEqualToString:@"热销"])
        {
            cell.goodModel = [self GoodModelWithaArray:self.Category_rexiao IndexPath:indexPath];
        }
        
        
        if (self.buttonStates.count == 0)
        {
            cell.goodsSubButton.hidden = YES;
            cell.goodsNumb = @"0";
        }
        else
        {
            cell.goodsSubButton.hidden = YES;
            cell.goodsNumb = @"0";

            for (NSUInteger i=0; i< self.buttonStates.count ; i++)
            {
                if ([[self.buttonStates[i] objectForKey:@"indexPath"] isEqual:indexPath])
                {
                    cell.goodsSubButton.hidden = NO;
                    cell.goodsNumb = [self.buttonStates[i] objectForKey:@"numb"];
                }
            }
        }
        return cell;
    }
}

- (GoodsModel *)GoodModelWithaArray:(NSMutableArray *)array IndexPath:(NSIndexPath *)indexPath
{
    GoodsModel *tempGoodsModel = [[GoodsModel alloc]init];

    tempGoodsModel.goodsModelGoodsImage = [array[indexPath.row] objectForKey:@"GoodsImage"];
    tempGoodsModel.goodsModelGoodsName = [array[indexPath.row] objectForKey:@"GoodsName"];
    tempGoodsModel.goodsModelGoodsPrice = [array[indexPath.row] objectForKey:@"GoodsPrice"];
    tempGoodsModel.goodsModelPreferentPrice = [array[indexPath.row] objectForKey:@"PreferentPrice"];
    
    return tempGoodsModel;
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

        view.headerLabel.text = self.goodCategory[section];
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
    else if (_rightTableView == tableView)
    {
        NSString *tempString = _goodCategory[indexPath.section];
        NSDictionary *tempDic = [[NSDictionary alloc]init];
        
        if ([tempString isEqualToString:@"套餐"])
        {
            tempDic = _Category_taocan[indexPath.row];
        }
        if ([tempString isEqualToString:@"单品"])
        {
            tempDic = _Category_dangpin[indexPath.row];
        }
        if ([tempString isEqualToString:@"饮品"])
        {
            tempDic = _Category_yinpin[indexPath.row];
        }
        if ([tempString isEqualToString:@"热销"])
        {
            tempDic = _Category_rexiao[indexPath.row];
        }
    
        [self.CellDelegate ClickTabelViewCellWithGoodsDic:tempDic];
    }
}


#pragma mark - UISrcollView代理
//===================================================
//   标记TableView的滚动方向(是向上还是向下)
//              Table继承于Srcoll,可以用父类的代理
//===================================================
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isMemberOfClass:[UITableView class]])
    {

        static CGFloat lastOffsetY = 0;
        UITableView *tableView = (UITableView *) scrollView;
        if (_rightTableView == tableView)
        {
            _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
            lastOffsetY = scrollView.contentOffset.y;
        }
    }
}

#pragma mark - 重写frame
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _leftTableView.frame = CGRectMake(0, 0, 80, self.frame.size.height);
    _rightTableView.frame = CGRectMake(80,0, SCREEN_WIDTH - 80, self.frame.size.height);
}

- (void)searchCurrenShopDetail
{
    NSString *GoodsDetailPath = [[NSBundle mainBundle]pathForResource:@"GoodsDetail" ofType:@"plist"];
    
    NSArray *allArray = [NSArray arrayWithContentsOfFile:GoodsDetailPath];
    
    
    for (NSUInteger i = 0; i < 10; i ++)
    {
        NSArray *shop = allArray[i];
        NSDictionary *shopDetail = shop[0];
        NSString *storeImage = shopDetail[@"storeImage"];
        
        if([storeImage isEqualToString:self.shopAndGoodsModel.storeImage])
        {
            self.currenShopAllGood = [NSMutableArray arrayWithArray:shop];
            
            NSMutableSet *tempSet = [[NSMutableSet alloc]init];
            for (NSUInteger j = 1; j < 11; j++)
            {
                NSString *tempString = [shop[j] objectForKey:@"Category"];
    
                [tempSet addObject:tempString];

                if([tempString isEqualToString:@"套餐"])
                {
                    [self.Category_taocan addObject:shop[j]];
                }
                if([tempString isEqualToString:@"单品"])
                {
                    [self.Category_dangpin addObject:shop[j]];
                }
                if([tempString isEqualToString:@"饮品"])
                {
                    [self.Category_yinpin addObject:shop[j]];
                }
                if([tempString isEqualToString:@"热销"])
                {
                    [self.Category_rexiao addObject:shop[j]];
                }
                
            }
            _goodCategory  = [tempSet allObjects];
            
            [self writeToPlist];
            
            return;
        }
    }
}

-(void)writeToPlist
{
    NSMutableArray *allArray = [[NSMutableArray alloc]init];
    
    for (NSUInteger i = 0 ; i < _goodCategory.count ; i++)
    {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
        if ([_goodCategory[i] isEqualToString:@"套餐"])
        {
            [tempDic setObject:self.Category_taocan forKey:@"套餐"];
        }
        if ([_goodCategory[i] isEqualToString:@"单品"])
        {
            [tempDic setObject:self.Category_dangpin forKey:@"单品"];
        }
        if ([_goodCategory[i] isEqualToString:@"饮品"])
        {
            [tempDic setObject:self.Category_yinpin forKey:@"饮品"];
        }
        if ([_goodCategory[i] isEqualToString:@"热销"])
        {
            [tempDic setObject:self.Category_rexiao forKey:@"热销"];
        }
        
        [allArray addObject:tempDic];
    }
    [allArray writeToFile:[NSHomeDirectory() stringByAppendingPathComponent:@"shopCategory.plist"] atomically:YES];
    NSLog(@"%@",NSHomeDirectory());
}

#pragma mark - 接受通知
-(void)changeCell:(NSNotification *)noti
{
    self.buttonStates = noti.object;
//    NSLog(@"%@",noti.object);
    
    [self.rightTableView reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
