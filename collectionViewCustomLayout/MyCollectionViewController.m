//
//  MyCollectionViewController.m
//  collectionViewCustomLayout
//
//  Created by lanouhn on 16/1/21.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "ImageCollectionViewCell.h"
#import "customeCollectionViewlayout.h"
#import "SettingTableViewController.h"

#define CELL_COLUMN 3
#define CELL_MARGIN 2
#define CELL_MIN_HEIGHT 50
#define CELL_MAX_HEIGHT 200
#define SECTIONS_COUNT 1
#define CELL_COUNT 1000
#define SCROLL_OFFSET_Y 300

@interface MyCollectionViewController ()<CustomecollectionViewLayoutDelegate>
@property (strong,nonatomic)customeCollectionViewlayout *customeLayout;
@property (nonatomic)NSInteger cellColumn;
@property (nonatomic)CGFloat cellMargin;
@property (nonatomic)CGFloat cellMinHeght;
@property (nonatomic)CGFloat  cellMaxHeight;
@end

@implementation MyCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    _customeLayout  = (customeCollectionViewlayout *)self.collectionViewLayout;
    _customeLayout.layoutDelegate = self;
    [self initData];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

#pragma mark --自定义方法
- (void)initData {
    _cellColumn = CELL_COLUMN;
    _cellMargin = CELL_MARGIN;
    _cellMinHeght = CELL_MIN_HEIGHT;
    _cellMaxHeight = CELL_MAX_HEIGHT;
}

#pragma mark  --- 控件事件处理----
- (IBAction)tapSettingButton:(id)sender {
    SettingTableViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"SettingTableViewController"];
    vc.cellColumn = _cellColumn;
    vc.cellMargin = _cellMargin;
    vc.cellMinHeight = _cellMinHeght;
    vc.cellMaxHeight = _cellMaxHeight;
    
    [vc setDoneBlock:^(NSInteger cellColumn, CGFloat cellMargin, CGFloat cellMinHeight, CGFloat cellMaxHeight) {
        _cellColumn = cellColumn;
        _cellMargin = cellMargin;
        _cellMaxHeight = cellMaxHeight;
        _cellMinHeght = cellMinHeight;
        [self.collectionView reloadData];
        
    }];
    [self.navigationController showViewController:vc sender:nil];
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return SECTIONS_COUNT;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return CELL_COUNT;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSInteger imageIndex = arc4random() %10;
    NSString *imageName = [NSString stringWithFormat:@"00%ld.jpg",imageIndex];
    [cell.imageView  setImage:[UIImage imageNamed:imageName]];

    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (NSInteger) numberOfColumnWithCollectionView:(UICollectionView *)collectionView
                          collectionViewLayout:( customeCollectionViewlayout *)collectionViewLayout{
    return _cellColumn;
}

- (CGFloat)marginOfCellWithCollectionView:(UICollectionView *)collectionView
                     collectionViewLayout:(customeCollectionViewlayout *)collectionViewLayout{
    return _cellMargin;
}

- (CGFloat)minHeightOfCellWithCollectionView:(UICollectionView *)collectionView
                        collectionViewLayout:(customeCollectionViewlayout *)collectionViewLayout{
    return _cellMinHeght;
}

- (CGFloat)maxHeightOfCellWithCollectionView:(UICollectionView *)collectionView
                        collectionViewLayout:(customeCollectionViewlayout *)collectionViewLayout{
    return _cellMaxHeight;
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY < 0) {
        offsetY = 0;
    }
    
    self.navigationController.navigationBar.alpha = (SCROLL_OFFSET_Y - offsetY) / SCROLL_OFFSET_Y;
}




/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
