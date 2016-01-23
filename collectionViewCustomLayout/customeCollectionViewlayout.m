//
//  customeCollectionViewlayout.m
//  collectionViewCustomLayout
//
//  Created by wanghui on 16/1/23.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "customeCollectionViewlayout.h"
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface customeCollectionViewlayout ()
//section数量
@property(assign,nonatomic)NSInteger numberOfSections;
//section中cell的数量
@property (assign,nonatomic)NSInteger numberOfCellsInSections;
//瀑布流的行数
@property (assign,nonatomic)NSInteger columnCount;
//cell边距
@property (assign,nonatomic)NSInteger margin;
//cell的最小高度
@property (assign,nonatomic)NSInteger cellMinHeight;
//cell的最大高度, 最大高度比最小高度小,以最小高度为准
@property (assign,nonatomic)NSInteger cellMaxheight;
//cell 的宽度
@property(assign,nonatomic)CGFloat cellWidth;
//存储每列cell的x坐标
@property (strong,nonatomic)NSMutableArray *cellArray;
//存储每一个cell的随机高度, 避免每次加载的随机高度不同
@property (strong,nonatomic)NSMutableArray *cellHeightArray;
//记录每列cell的最新cell的Y坐标
@property (strong,nonatomic)NSMutableArray *cellYArray;
@end

@implementation customeCollectionViewlayout




@end
