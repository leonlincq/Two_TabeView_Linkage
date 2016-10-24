//
//  GoodsDetailViewController.m
//  mypro2
//
//  Created by etcxm on 16/10/21.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "GoodsDetailViewController.h"

@interface GoodsDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *PreferentPriceLabel;

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.view.backgroundColor = [UIColor whiteColor];

}

- (instancetype)initWithDic:(NSDictionary *)dataDic
{
    self = [super init];
    if (self)
    {
        //返回按钮
        UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 40, 30, 30)];
        [backButton setImage:[UIImage imageNamed:@"back_cross"] forState:UIControlStateNormal];
        backButton.backgroundColor = [UIColor blackColor];
        [backButton.layer setCornerRadius:15.0];
        [backButton addTarget:self action:@selector(backToShopAndGoods) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backButton];
        
        //商品图片
        _imageView.image = [UIImage imageNamed:[dataDic objectForKey:@"GoodsImage"]];
        //商品名
        _goodNameLabel.text = [dataDic objectForKey:@"GoodsName"];
        //价格
        _PreferentPriceLabel.text = [NSString stringWithFormat:@"￥%@",[dataDic objectForKey:@"PreferentPrice"]];

        
    }
    return self;
}


-(void)backToShopAndGoods
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
