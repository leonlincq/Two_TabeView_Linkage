//
//  CircleRevolve.m
//  mypro2
//
//  Created by etcxm on 16/10/19.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "CircleRevolve.h"

#define pi 3.14159265359
#define   DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)

@implementation CircleRevolve

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CAShapeLayer *layer =[CAShapeLayer layer];
        layer.lineWidth = 10;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor =[UIColor redColor].CGColor;
        layer.frame = CGRectMake(50, 50, 100, 100);
        layer.lineCap = kCALineCapRound;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:50 startAngle:DEGREES_TO_RADIANS(270) endAngle:DEGREES_TO_RADIANS(180) clockwise:YES];
        layer.path = path.CGPath;
        [self.layer addSublayer:layer];
        
        //画一个圆
        CAKeyframeAnimation *strokeEndAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
        strokeEndAnimation.duration = 0.5;
        strokeEndAnimation.values = @[@0.0, @1];
        strokeEndAnimation.keyTimes = @[@0.0,@1];
        
        //旋转2圈
        CABasicAnimation *rotaAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotaAni.fromValue = @(DEGREES_TO_RADIANS(0));
        rotaAni.toValue = @(DEGREES_TO_RADIANS(720));
        rotaAni.autoreverses = YES;
        
        //最后填充颜色
        //创建一个CABasicAnimation对象
        CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        //设置颜色
        animation.toValue=(id)[UIColor blackColor].CGColor; //必须要用黑色
        
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.repeatCount = INFINITY;
        group.duration = 2;
        group.animations = @[strokeEndAnimation,rotaAni,animation];
        
        
        [layer addAnimation:group forKey:nil];
    }
    return self;
}

@end
