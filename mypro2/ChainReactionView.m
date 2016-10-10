//
//  ChainReactionView.m
//  mypro2
//
//  Created by etcxm on 16/10/10.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "ChainReactionView.h"
#import "ChainReactionLabelButton.h"
#import "Masonry.h"

#define HomeItemReuseIdentifier @"HomeItemReuseIdentifier"

@interface ChainReactionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIScrollView *channelView;        //频道View
@property (nonatomic, strong) UICollectionView *collectionView; //频道内容数据
@property (nonatomic, strong) UIView *underLine;                //底部线条
@property (nonatomic, strong) ChainReactionLabelButton *selectedLabel;  //选中的按钮
@property (nonatomic, strong) NSMutableArray *labelArray;               //频道数组

@end



@implementation ChainReactionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor orangeColor];
        
        //注册item
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:HomeItemReuseIdentifier];
        
        //添加控件
        [self addSubview:self.channelView];         //添加频道View
        [self addSubview:self.collectionView];      //添加频道的内容View
        [self addSubview:self.underLine];           //添加频道的红色下划线
        
        //设置约束
        [self.channelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self);
            make.top.equalTo(self);
            make.height.mas_equalTo(44);
        }];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.channelView.mas_bottom);
            make.bottom.leading.trailing.equalTo(self);
        }];
        
        [self.underLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(3);
            make.leading.bottom.equalTo(self.channelView);
            make.width.mas_equalTo(SCREEN_WIDTH/3);
        }];
    }
    return self;
}

#pragma mark - 懒加载

//==================
//   上面的频道名称
//==================
- (NSArray *)allNameArray
{
    if (!_allNameArray)
    {
        _allNameArray = @[@"点菜",@"评价",@"商家"];
    }
    return _allNameArray;
}

//=============
//   频道view
//=============
- (UIScrollView *)channelView
{
    if (!_channelView)
    {
        _channelView = [[UIScrollView alloc] init];
        
        //创建按钮
        CGFloat buttonWidth = SCREEN_WIDTH/3;
        CGFloat buttonHeight = 44;
        CGFloat buttonY = 0;

        self.labelArray = [NSMutableArray array];
        
        for (int i = 0; i < self.allNameArray.count; i++)
        {
            CGFloat buttonX = i * buttonWidth;
            ChainReactionLabelButton *button = [[ChainReactionLabelButton alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight)];
            button.text = self.allNameArray[i];
            button.tag = i;
            if (button.tag == 0)    //初始化为选中第0个标签页，缩放1，保存该Button
            {
                button.textScale = 1.0;
                self.selectedLabel = button;
            }
            [self.labelArray addObject:button];     //添加到labelArray上保存
            
            [button addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
            
            [_channelView addSubview:button];      //添加到scrollView上显示
        }
        _channelView.backgroundColor = [UIColor whiteColor];
        _channelView.bounces = NO;                  //scrollView自带回弹效果
        _channelView.contentSize = CGSizeMake(self.allNameArray.count * buttonWidth, 0);
        _channelView.showsHorizontalScrollIndicator = NO;
    }
    return _channelView;
}

//=============
//   底部数据
//=============
- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        //流水布局
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height - 44);
        
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

//=============
//   底部线条
//=============
- (UIView *)underLine
{
    if (!_underLine)
    {
        _underLine = [[UIView alloc] init];
        _underLine.backgroundColor = [UIColor redColor];
    }
    return _underLine;
}

#pragma mark - 数据源

//=======================================
//   多少个频道 对应的 内容（collectionView）
//=======================================
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.allNameArray.count;
}

//=======================================
//   频道 对应的 内容（collectionView）设置
//=======================================
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:HomeItemReuseIdentifier forIndexPath:indexPath];
    
    collectionView.backgroundColor = [UIColor whiteColor];
    
    _myBlock(collectionView,indexPath);
    
    return item;
}

#pragma mark - 收藏代理
//=======================================
//   监听滚动
//=======================================
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //获取collectionView的中心点
    CGPoint pointItem = [self convertPoint:self.collectionView.center toView:self.collectionView];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:pointItem];
    for (ChainReactionLabelButton *channel in self.labelArray)
    {
        if (channel.tag == indexPath.row)
        {
            self.selectedLabel = channel;
            [self setChannellabelTextAndColor];
        }
    }
    
    //1.计算一下,scrollView.contentOffset.x / scrollView.bounds.size.width;
    CGFloat value = (CGFloat)scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    if (value < 0 || value > (self.labelArray.count -1))
    {
        return;
    }

    //2.左边的索引
    int leftIndex = (int)scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    //3.右边的索引
    int rightIndex = leftIndex + 1;
    
    //4.右边的缩放比率
    CGFloat rightScale = (value - leftIndex);
    
    //5.左边的缩放比率
    CGFloat leftScale = 1 - rightScale;
    
    //6.取出左边的ChannelLabel给它设置左边对应的缩放比率
    ChainReactionLabelButton *leftChannelLabel = self.labelArray[leftIndex];
    leftChannelLabel.textScale = leftScale;
    
    //7.取出右边的ChannelLabel给它设置左边对应的缩放比率
    if (rightIndex < self.labelArray.count) {
        ChainReactionLabelButton *rightChannelLabel = self.labelArray[rightIndex];
        rightChannelLabel.textScale = rightScale;
    }
}

#pragma mark - 点击事件
//============
//   点击频道
//============
- (void)tapAction:(UITapGestureRecognizer *)recognizer
{
    ChainReactionLabelButton *chanelLabel = (ChainReactionLabelButton *)recognizer.view;
    self.selectedLabel = chanelLabel;
    [self setChannellabelTextAndColor];
    
    //跳转到对应底部界面
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:chanelLabel.tag inSection:0];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

#pragma mark - 选中按钮文字处理方法
//=======================================
//   设置频道文字 变大、变红、居中
//=======================================
- (void)setChannellabelTextAndColor
{
    //1.计算channelView应该滚动多远
    CGFloat needScrollContentOffsetX = self.selectedLabel.center.x - self.channelView.bounds.size.width * 0.5;
    
    //1.1 重新设置,点击最左边的极限值
    if (needScrollContentOffsetX < 0)
    {
        needScrollContentOffsetX = 0;
    }
    CGFloat maxScrollContentOffsetX = self.channelView.contentSize.width - self.channelView.bounds.size.width;
    
    //1.2 重新设置,点击最右边的极限值
    if (needScrollContentOffsetX > maxScrollContentOffsetX)
    {
        needScrollContentOffsetX = maxScrollContentOffsetX;
    }
    
    //2.让其滚动
    [self.channelView setContentOffset:CGPointMake(needScrollContentOffsetX, 0) animated:YES];
    
    //3.选中的最大最红,没选中的最小最黑
    for (ChainReactionLabelButton *channelLabel in self.labelArray)
    {
        if (channelLabel == self.selectedLabel)
        {
            channelLabel.textScale = 1.0; //变成最大最红
        }else{
            channelLabel.textScale = 0.0; //变成最小最黑
        }
    }
    [self underLinePosition:needScrollContentOffsetX];
}

#pragma mark - 底线的动画
//==============================
//   设置底线的动画
//==============================
- (void)underLinePosition:(CGFloat)needScrollContentOffsetX
{
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect tempFrame = self.underLine.frame;
        tempFrame.origin.x = self.selectedLabel.frame.origin.x - needScrollContentOffsetX;
        self.underLine.frame = tempFrame;
    }];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
