//
//  textCell.h
//  democell
//
//  Created by 王俊钢 on 2017/5/14.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class firstModel;

@interface textCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) UITableView *texttable;
-(void)setcelldata:(firstModel *)model;
@end
