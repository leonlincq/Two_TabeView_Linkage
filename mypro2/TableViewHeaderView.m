//
//  TableViewHeaderView.m
//  mypro2
//
//  Created by etcxm on 16/10/9.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "TableViewHeaderView.h"

@implementation TableViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = RGBA(240, 240, 240, 0.8);                                //背景颜色，以后宏定义
        self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 20)];  //View大小，以后宏定义
        self.headerLabel.font = [UIFont systemFontOfSize:13];                           //字体大小，以后宏定义
        [self addSubview:self.headerLabel];
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
