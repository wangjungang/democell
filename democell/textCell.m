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
#import "pinglunCell.h"
static NSString *textidentfid = @"textidentfid";
@interface textCell()
@property (nonatomic,strong) firstModel *fmodel;
@property (nonatomic,strong) NSMutableArray *dataarr;
@property (nonatomic,strong) secondModel *smodel;
@property (nonatomic,strong) pinglunCell *cell;

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
        [self setlayout];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

-(void)setlayout
{
    [self.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(14*HEIGHT_SCALE);
        make.left.equalTo(self).with.offset(14*WIDTH_SCALE);
        make.right.equalTo(self).with.offset(-14*WIDTH_SCALE);
    }];
    [self.texttable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentlab.mas_bottom).with.offset(14*HEIGHT_SCALE);
        make.left.equalTo(self).with.offset(14*WIDTH_SCALE);
        make.right.equalTo(self).with.offset(-14*WIDTH_SCALE);
    }];
    
}


-(CGFloat )setcelldata:(firstModel *)model
{
    self.fmodel = model;
    self.contentlab.numberOfLines = 0;
    self.contentlab.font = [UIFont systemFontOfSize:14];
   // model.contentstr = @"在自定义单元格上面，";
    
    self.contentlab.preferredMaxLayoutWidth = (DEVICE_WIDTH - 14*2*WIDTH_SCALE);
    [self.contentlab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    self.contentlab.lineBreakMode = NSLineBreakByWordWrapping;//换行方式
    self.contentlab.text = model.contentstr;
    CGSize textsize= [model.contentstr boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-28*WIDTH_SCALE, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    [self.contentlab sizeToFit];
    for (int i = 0; i<model.pinglunarr.count; i++) {
        NSDictionary *dit = [model.pinglunarr objectAtIndex:i];
        [self.dataarr addObject:dit];
    }
    
    [self layoutIfNeeded];
    CGFloat hei = textsize.height;
    self.cellheight = hei+28;
    [self.texttable reloadData];
    return self.cellheight;
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
        _texttable.scrollEnabled = NO;
    }
    return _texttable;
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    pinglunCell *cell = [[pinglunCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textidentfid];
    NSMutableArray *arr = [cell pinglundata:self.dataarr];
    NSString *contentstr = arr[indexPath.row];
    CGSize textsize= [contentstr boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-64*WIDTH_SCALE-14*WIDTH_SCALE, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    [self.texttable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo((textsize.height+16)*arr.count);
    }];
    
    return textsize.height+16;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    pinglunCell *cell = [tableView dequeueReusableCellWithIdentifier:textidentfid];
    cell = [[pinglunCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textidentfid];
    NSMutableArray *arr = [cell pinglundata:self.dataarr];
    cell.pinglunlab.text = arr[indexPath.row];
    cell.pinglunlab.backgroundColor = [UIColor lightGrayColor];
    cell.pinglunlab.font = [UIFont systemFontOfSize:14];
    cell.pinglunlab.numberOfLines = 0;
    [cell.pinglunlab sizeToFit];
    cell.pinglunlab.preferredMaxLayoutWidth = (DEVICE_WIDTH-64*WIDTH_SCALE-14*WIDTH_SCALE);
    [cell.pinglunlab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    return cell;
}

@end
