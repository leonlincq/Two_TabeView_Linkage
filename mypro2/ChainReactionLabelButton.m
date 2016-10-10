//
//  ChainReactionLabelButton.m
//  mypro2
//
//  Created by etcxm on 16/10/10.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "ChainReactionLabelButton.h"

@implementation ChainReactionLabelButton

//==============
//   重写初始化
//==============
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.textAlignment = NSTextAlignmentCenter; //文字居中
        self.font = [UIFont systemFontOfSize:20];   //字体大小
        self.userInteractionEnabled = YES;
        self.textScale = 0;
    }
    return self;
}

//============
//   重设比例
//============
- (void)setScale:(float)scale
{
    _textScale = scale;
    
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1.0];
    
    //2.让其tranform的scale发生变化
    //0.8 ~ 1.0
    CGFloat lastScale = 0.8 + (1 - 0.8) * scale;
    self.transform = CGAffineTransformMakeScale(lastScale, lastScale);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
