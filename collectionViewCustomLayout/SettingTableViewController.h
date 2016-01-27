//
//  SettingTableViewController.h
//  collectionViewCustomLayout
//
//  Created by lanouhn on 16/1/21.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void  (^DoneBlock)(NSInteger cellColumn, CGFloat cellMargin, CGFloat cellMinHeight, CGFloat cellMaxHeight);

@interface SettingTableViewController : UITableViewController
@property(nonatomic,assign)NSInteger cellColumn;
@property(nonatomic,assign)CGFloat cellMargin;
@property(nonatomic,assign)CGFloat cellMinHeight;
@property(nonatomic,assign)CGFloat cellMaxHeight;
-(void)setDoneBlock:(DoneBlock)block;
@end
