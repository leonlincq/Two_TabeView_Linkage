//
//  ShopNaviView.h
//  mypro2
//
//  Created by etcxm on 16/10/11.
//  Copyright © 2016年 etc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol myNaviBackDelegate <NSObject>

-(void)dismissToHome;

@end


@interface ShopNaviView : UIView

@property (nonatomic,strong) id<myNaviBackDelegate> backdelegate;
#ifdef OBSERVE
@property (nonatomic,assign) BOOL isReturn;
#endif
@property (nonatomic,copy) NSString *shopName;

//@property (nonatomic,copy) NSString *isReturn;

@end
