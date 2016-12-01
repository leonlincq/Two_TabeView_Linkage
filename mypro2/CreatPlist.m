//
//  CreatPlist.m
//  mypro2
//
//  Created by etcxm on 16/10/13.
//  Copyright © 2016年 etc. All rights reserved.
//

#import "CreatPlist.h"

@implementation CreatPlist

+(void)CreatGoodsPlist
{
    NSMutableArray *allArray = [[NSMutableArray alloc]init];
    
    for (NSUInteger  i = 1; i <= 10 ; i++)  //10家商店
    {
        NSMutableArray *tempArray = [[NSMutableArray alloc]init];
        
        for (NSUInteger  j = 1; j <= 11 ; j++)  //每家商10个商品
        {
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
            
            if (j == 1)
            {
                [tempDic setValue:[NSString stringWithFormat:@"第%ld家店地址",i] forKey:@"ShopAddress"];
                [tempDic setValue:[NSString stringWithFormat:@"store_name%02ld",i] forKey:@"storeImage"];
                [tempArray addObject:tempDic];
                continue;
            }
            switch (i)
            {
                case 1:
                    [tempDic setValue:[NSString stringWithFormat:@"转转乐|商品%ld",j-1] forKey:@"GoodsName"];
                    break;
                    
                case 2:
                    [tempDic setValue:[NSString stringWithFormat:@"意享披萨|商品%ld",j-1] forKey:@"GoodsName"];
                    break;
                    
                case 3:
                    [tempDic setValue:[NSString stringWithFormat:@"QQ脆皮鸡排|商品%ld",j-1] forKey:@"GoodsName"];
                    break;
                    
                case 4:
                    [tempDic setValue:[NSString stringWithFormat:@"骨之味|商品%ld",j-1] forKey:@"GoodsName"];
                    break;
                    
                case 5:
                    [tempDic setValue:[NSString stringWithFormat:@"甜丫丫|商品%ld",j-1] forKey:@"GoodsName"];
                    break;
                    
                case 6:
                    [tempDic setValue:[NSString stringWithFormat:@"正宗骨汤麻辣烫|商品%ld",j-1] forKey:@"GoodsName"];
                    break;
                    
                case 7:
                    [tempDic setValue:[NSString stringWithFormat:@"食尚煲仔饭|商品%ld",j-1] forKey:@"GoodsName"];
                    break;
                    
                case 8:
                    [tempDic setValue:[NSString stringWithFormat:@"鲜芋仙|商品%ld",j-1] forKey:@"GoodsName"];
                    break;
                    
                case 9:
                    [tempDic setValue:[NSString stringWithFormat:@"老塞行动咖啡|商品%ld",j-1] forKey:@"GoodsName"];
                    break;
                    
                case 10:
                    [tempDic setValue:[NSString stringWithFormat:@"85°C|商品%ld",j-1] forKey:@"GoodsName"];
                    break;
                    
                default:
                    break;
            }

            [tempDic setValue:[NSString stringWithFormat:@"GoodsImage%ld",(i-1)*10+(j-1)] forKey:@"GoodsImage"];
            
            NSUInteger temp1 = arc4random()%20;
            [tempDic setValue:[NSString stringWithFormat:@"%ld",temp1+20] forKey:@"GoodsPrice"];
            
            NSUInteger temp2 = arc4random()%10;
            [tempDic setValue:[NSString stringWithFormat:@"%ld",temp1+20-temp2] forKey:@"PreferentPrice"];
            
            NSUInteger temp3 = arc4random()%4;
            switch (temp3)
            {
                case 0:
                    [tempDic setValue:@"热销" forKey:@"Category"];
                    break;
                    
                case 1:
                    [tempDic setValue:@"套餐" forKey:@"Category"];
                    break;
                    
                case 2:
                    [tempDic setValue:@"饮品" forKey:@"Category"];
                    break;
                    
                case 3:
                    [tempDic setValue:@"单品" forKey:@"Category"];
                    break;
                    
                default:
                    break;
            }
            
            [tempArray addObject:tempDic];
        }
        [allArray addObject:tempArray];
    }
    
//    NSLog(@"%@",allArray);
    
//    NSLog(@"-->%d",[allArray writeToFile:[NSHomeDirectory() stringByAppendingPathComponent:@"GoodsDetail.plist"] atomically:YES]);
    
    
//    NSLog(@"%@",NSHomeDirectory());
}

+(void)CreatUserinfoPlist
{
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    
    [tempDic setObject:@"1000" forKey:@"余额"];
    
    NSArray *tempArray1 = @[@"福建",@"泉州",@"小林",@"12345678912"];
    NSArray *tempArray2 = @[@"福建",@"厦门",@"小林",@"12345678912"];
    NSArray *tempArray3 = @[@"福建",@"福州",@"小林",@"12345678912"];
    
    [tempDic setObject:@[tempArray1,tempArray2,tempArray3] forKey:@"地址"];
    [tempDic setObject:@"3" forKey:@"地址组数"];
    [tempDic setObject:@"123456" forKey:@"密码"];
    [tempDic setObject:@"12345678912" forKey:@"手机号码"];
    [tempDic setObject:@"小林" forKey:@"用户名"];
    
    [tempDic writeToFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]  stringByAppendingPathComponent:@"userinfo.plist"] atomically:YES];
}



@end
