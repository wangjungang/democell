//
//  textCell.h
//  democell
//
//  Created by 王俊钢 on 2017/5/14.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class firstModel;

@protocol mycellVdelegate <NSObject>

-(void)myTabVClick:(UITableViewCell *)cell datadic:(NSDictionary *)dic;

@end

@interface textCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) UITableView *texttable;
-(CGFloat )setcelldata:(firstModel *)model;

@property (nonatomic,assign) CGFloat cellheight;
@property(assign,nonatomic)id<mycellVdelegate>delegate;
@end
