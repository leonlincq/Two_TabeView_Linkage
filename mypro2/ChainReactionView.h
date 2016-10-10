//
//  ChainReactionView.h
//  mypro2
//
//  Created by etcxm on 16/10/10.
//  Copyright © 2016年 etc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^myCollectionViewBlock)(UICollectionView *collectionView,NSIndexPath *indexPath);

@interface ChainReactionView : UIView

@property (nonatomic,strong) myCollectionViewBlock myBlock;

@property (nonatomic, strong) NSArray *allNameArray;

@end
