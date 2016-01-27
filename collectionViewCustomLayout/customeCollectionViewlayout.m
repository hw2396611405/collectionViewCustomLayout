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
@property (strong,nonatomic)NSMutableArray *cellXArray;
//存储每一个cell的随机高度, 避免每次加载的随机高度不同
@property (strong,nonatomic)NSMutableArray *cellHeightArray;
//记录每列cell的最新cell的Y坐标
@property (strong,nonatomic)NSMutableArray *cellYArray;
@end

@implementation customeCollectionViewlayout
#pragma mark -- <UICollectionViewLayout>虚基类中重写方法
/*
   该方法是预加载layout 只会被执行一次
 */
- (void)prepareLayout {
    [super prepareLayout];
    [self initData];
    [self initCellWidth];
    [self initCellHeight];
}
//该方法返回collectionView的ContentSize的大小
- (CGSize)collectionViewContentSize {
    CGFloat height = [self  maxCellYArrayWithArray:_cellYArray];
    return CGSizeMake(SCREEN_WIDTH, height);

}
//为每个cell绑定一个Layout属性  返回数组中所有视图布局属性实例给定的矩形
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
   [self initCellYArray];
    NSMutableArray *array = [NSMutableArray array];
    //添加cell
    for (int i = 0; i < _numberOfCellsInSections; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attributes];
        
    }
    return  array;
}

//该方法为每个cell绑定一个layout属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGRect frame = CGRectZero;
    CGFloat cellHeight  = [_cellHeightArray[indexPath.row] floatValue];
    NSInteger minYIndex = [self minCellYArrayWithArray:_cellYArray];
    CGFloat tempX= [_cellXArray[minYIndex] floatValue];
    CGFloat tempY = [_cellYArray[minYIndex] floatValue];
    frame = CGRectMake(tempX, tempY, _cellWidth, cellHeight);
    //更新相应的Y坐标
    _cellYArray[minYIndex] = @(tempY + cellHeight +_margin);
    //计算每个cell的位置
    attributes.frame = frame;
    return attributes;
}


#pragma mark -- 自定义方法的实现
//初始化相关数据
- (void)initData
{
    _numberOfSections = [self.collectionView numberOfSections];
    _numberOfCellsInSections = [self.collectionView numberOfItemsInSection:0];
    //通过回调获取列数
    _columnCount = [_layoutDelegate numberOfColumnWithCollectionView:self.collectionView collectionViewLayout:self];
    NSLog(@"%ld",(long)_columnCount);
    _margin = [_layoutDelegate marginOfCellWithCollectionView:self.collectionView collectionViewLayout:self];
    _cellMinHeight = [_layoutDelegate minHeightOfCellWithCollectionView:self.collectionView collectionViewLayout:self];
    _cellMaxheight = [_layoutDelegate maxHeightOfCellWithCollectionView:self.collectionView collectionViewLayout:self];
    
}
//根据cell的列数求出cell的宽度
- (void)initCellWidth
{
     //计算每个cell的宽度
    _cellWidth = (SCREEN_WIDTH - (_columnCount - 1)*_margin)/_columnCount;
    //为每个cell计算X坐标
    _cellXArray = [[NSMutableArray alloc]initWithCapacity:_columnCount];
    for (int i = 0; i < _columnCount; i ++) {
        CGFloat tempX = i *(_cellWidth +_margin);
        NSLog(@"-----%f",tempX);
        [_cellXArray addObject:@(tempX)];
    }

}

//随机生成cell的高度
- (void)initCellHeight {
    _cellHeightArray = [[NSMutableArray alloc]initWithCapacity:_numberOfCellsInSections];
    for (int i = 0; i < _numberOfCellsInSections; i ++) {
        CGFloat cellHeight = arc4random()%_cellMaxheight + _cellMinHeight;
        [_cellHeightArray addObject:@(cellHeight)];
    }


}


//获取CellY数组中的最大值并返回
- (CGFloat)maxCellYArrayWithArray:(NSMutableArray *)array{
    if (array.count == 0) {
        return   0.0f;
    }
    CGFloat max = [array[0] floatValue];
    for (NSNumber *number in array) {
        CGFloat temp = [number floatValue];
        if (max < temp) {
            max = temp;
        }
    }

    return  max;
}
//初始化每列cell的Y轴坐标
- (void)initCellYArray {
    _cellYArray = [[NSMutableArray alloc]initWithCapacity:_columnCount];
    for (int i = 0; i < _columnCount; i ++) {
        [_cellYArray addObject:@(0)];
    }

}
//获取cellY数组中的最小值得索引
- (CGFloat)minCellYArrayWithArray:(NSMutableArray *) array  {
    if (array.count == 0) {
        return 0.0f;
    }
    NSInteger minIndex = 0;
    CGFloat min = [array [0] floatValue];
    for (int i = 0; i < array.count; i ++) {
        CGFloat temp = [array[i] floatValue];
        if (min > temp) {
            min = temp;
            minIndex = i;
        
        }
    }
    return minIndex;

}




@end
