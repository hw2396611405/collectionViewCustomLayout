//
//  SettingTableViewController.m
//  collectionViewCustomLayout
//
//  Created by lanouhn on 16/1/21.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "SettingTableViewController.h"

@interface SettingTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *columnTextField;
@property (weak, nonatomic) IBOutlet UITextField *cellMarginTextField;
@property (weak, nonatomic) IBOutlet UITextField *cellMinHeightTextField;
@property (weak, nonatomic) IBOutlet UITextField *cellMaxHeightTextField;
@property (strong,nonatomic)DoneBlock block;

@end

@implementation SettingTableViewController

#pragma mark --重写父类方法---
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self initFormData];
}


#pragma  mark -- 自定义方法 ----
-(void)setDoneBlock:(DoneBlock)block {
    _block = block;
}

-(void)initFormData {
    _columnTextField.text = [NSString stringWithFormat:@"%ld",_cellColumn];
    _cellMarginTextField.text = [NSString stringWithFormat:@"%.0lf",_cellMargin];
    _cellMinHeightTextField.text = [NSString stringWithFormat:@"%.0lf",_cellMinHeight];
    _cellMaxHeightTextField.text = [NSString stringWithFormat:@"%.0lf",_cellMaxHeight];


}

- (void)alterWithString:(NSString *)message {
    UIAlertView  *alter = [[UIAlertView  alloc]initWithTitle:@"提示" message:
                           message  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alter show];

}

#pragma mark -- 控件事件处理
- (IBAction)tapDone:(id)sender
{
    if (_block) {
        if ([_columnTextField.text isEqualToString:@""]) {
            [self alterWithString:@"Column不能为空"];
            return;
        }
        
        if ([_cellMarginTextField.text isEqualToString:@""]) {
            [self alterWithString:@"Margin不能为空"];
            return;
        }
        
        if ([_cellMinHeightTextField.text isEqualToString:@""]) {
            [self alterWithString:@"Cell Min Height不能为空"];
            return;
        }
        
        if ([_cellMaxHeightTextField.text isEqualToString:@""]) {
            [self alterWithString:@"Cell Max Height不能为空"];
            return;
        }
        
        _cellColumn     = _columnTextField.text.integerValue;
        _cellMargin     = _cellMarginTextField.text.floatValue;
        _cellMinHeight  = _cellMinHeightTextField.text.floatValue;
        _cellMaxHeight  = _cellMaxHeightTextField.text.floatValue;
        
        _block(_cellColumn, _cellMargin, _cellMinHeight, _cellMaxHeight);
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapGesture:(id)sender {
    [self.view endEditing:YES];
}



@end
