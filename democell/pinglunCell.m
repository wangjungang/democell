//
//  pinglunCell.m
//  democell
//
//  Created by 王俊钢 on 2017/5/15.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "pinglunCell.h"
#import "secondModel.h"
#import "firstModel.h"

@implementation pinglunCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.pinglunlab];
        [self setuplayout];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

-(NSMutableArray *)pinglundata:(NSMutableArray *)pinglunarr
{
    NSMutableArray *heiarr = [NSMutableArray array];
    NSMutableArray *arr = pinglunarr;
    secondModel *model = [[secondModel alloc] init];
    for (int i = 0; i<arr.count; i++) {
        NSDictionary *dit = [arr objectAtIndex:i];
        model.secondcontnetstr = [dit objectForKey:@"content"];
        model.s_nicknamestr = [dit objectForKey:@"s_nickname"];
        model.s_tonicknamestr = [dit objectForKey:@"s_to_nickname"];
        [heiarr addObject:model];
        [self layoutIfNeeded];
    }
    return heiarr;
}

-(void)setuplayout
{
    [self.pinglunlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(8*HEIGHT_SCALE);
        make.left.equalTo(self).with.offset(64*WIDTH_SCALE);
        make.right.equalTo(self).with.offset(-14*WIDTH_SCALE);
    }];
}

#pragma mark - getters

-(UILabel *)pinglunlab
{
    if(!_pinglunlab)
    {
        _pinglunlab = [[UILabel alloc] init];
        
    }
    return _pinglunlab;
}



@end
