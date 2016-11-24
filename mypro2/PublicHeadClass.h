//
//  PublicHeadClass.h
//  01PchDemo
//
//  Created by etcxm on 16/6/1.
//  Copyright © 2016年 中软国际. All rights reserved.
//

#ifndef PublicHeadClass_h
#define PublicHeadClass_h

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define TheTitleFont  [UIFont systemFontOfSize:18.0]
#define TheSubTitleFont  [UIFont systemFontOfSize:16.0]

#define TheBackColor RGB(100,200,100)

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)



//#define OBSERVE

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define DEFAULT_COLOR RGBA(253, 212, 49, 1)

#define SHOPDETAIL_HEIGHT   110
#define SHOPCAR_HEIGHT      50
#define NAVI_HEIGHT   self.navigationController.navigationBar.frame.size.height
#define FALSE_NAVI_HEIGHT   44  //   //导航栏高度44
#define STATUS_HEIGHT   [[UIApplication sharedApplication]statusBarFrame].size.height  //最顶上状态栏高度20
#define TABBAR_HEIGHT   self.tabBarController.tabBar.frame.size.height


#define SqliteDataPath [NSHomeDirectory() stringByAppendingPathComponent:@"MyData.sqlite"]


#endif /* PublicHeadClass_h */
