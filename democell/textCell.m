//
//  textCell.m
//  democell
//
//  Created by 王俊钢 on 2017/5/14.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "textCell.h"
#import "firstModel.h"
#import "secondModel.h"
static NSString *textidentfid = @"textidentfid";
@interface textCell()
@property (nonatomic,strong) firstModel *fmodel;
@property (nonatomic,strong) NSMutableArray *dataarr;
@property (nonatomic,strong) secondModel *smodel;
@end
@implementation textCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.dataarr = [NSMutableArray array];
        [self.contentView addSubview:self.contentlab];
        [self.contentView addSubview:self.texttable];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.contentlab.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30);
    self.texttable.frame = CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 120);
}

-(void)setcelldata:(firstModel *)model
{
    self.fmodel = model;
    self.contentlab.text = model.contentstr;
    
    for (int i = 0; i<model.pinglunarr.count; i++) {
        self.smodel = [[secondModel alloc] init];
        NSDictionary *dit = [model.pinglunarr objectAtIndex:i];
        self.smodel.secondcontnetstr = [dit objectForKey:@"content"];
        [self.dataarr addObject:self.smodel.secondcontnetstr];
    }
    [self.texttable reloadData];
}

#pragma mark - getters

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.backgroundColor = [UIColor lightGrayColor];
    }
    return _contentlab;
}

-(UITableView *)texttable
{
    if(!_texttable)
    {
        _texttable = [[UITableView alloc] init];
        _texttable.dataSource = self;
        _texttable.delegate = self;
        
    }
    return _texttable;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:textidentfid];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textidentfid];
//    cell.textLabel.text = @"评论区域";
    cell.textLabel.text = self.dataarr[indexPath.row];
    return cell;
}

@end
