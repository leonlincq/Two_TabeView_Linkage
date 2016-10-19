//
//  MakeOrderViewController.m
//  mypro2
//
//  Created by etcxm on 16/10/18.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "MakeOrderViewController.h"

@implementation MakeOrderViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)setAllChooseGoods:(NSArray *)allChooseGoods
{
    _allChooseGoods = allChooseGoods;
    
    NSLog(@"%@",_allChooseGoods);
}


@end
