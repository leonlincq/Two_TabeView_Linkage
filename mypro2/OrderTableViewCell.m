//
//  OrderTableViewCell.m
//  mypro2
//
//  Created by etcxm on 16/10/20.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "OrderTableViewCell.h"

@interface OrderTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;

@property (weak, nonatomic) IBOutlet UILabel *shopName;

@property (weak, nonatomic) IBOutlet UILabel *goodsdetail;

@property (weak, nonatomic) IBOutlet UIButton *leftButton;

@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@end


@implementation OrderTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        tempView.backgroundColor = [UIColor redColor];
        [self addSubview:tempView];
        
        _shopName.text = @"132341";
        _goodsdetail.text = @"sadgfasdf";
    }
    return self;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)leftButtonClick:(id)sender
{
    
}

- (IBAction)rightButtonClick:(id)sender
{
    
}


-(void)setName:(NSString *)name
{
    _shopName.text = name;
    _goodsdetail.text = name;
}




@end
