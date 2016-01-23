//
//  customeCollectionViewlayout.h
//  collectionViewCustomLayout
//
//  Created by wanghui on 16/1/23.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  customeCollectionViewlayout;
@protocol CustomecollectionViewLayoutDelegate <NSObject>
/**
 * 确定布局行数的回调
 */
@required
- (NSInteger)numberOfColumnWithCollectionView:(UICollectionView *)collectionView
                         collectionViewLayout:( customeCollectionViewlayout *)collectionViewLayout;

/**
 * 确定cell的Margin
 */
@required
- (CGFloat)marginOfCellWithCollectionView:(UICollectionView *)collectionView
                     collectionViewLayout:( customeCollectionViewlayout *)collectionViewLayout;
/**
 * 确定cell的最小高度
 */
@required
- (CGFloat)minHeightOfCellWithCollectionView:(UICollectionView *)collectionView
                        collectionViewLayout:( customeCollectionViewlayout *)collectionViewLayout;

/**
 * 确定cell的最大高度
 */
@required
- (CGFloat)maxHeightOfCellWithCollectionView:(UICollectionView *)collectionView
                        collectionViewLayout:( customeCollectionViewlayout *)collectionViewLayout;


@end




@interface customeCollectionViewlayout : UICollectionViewLayout

@property (weak, nonatomic)id<CustomecollectionViewLayoutDelegate>layoutDelegate;


@end
