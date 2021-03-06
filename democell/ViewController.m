//
//  ViewController.m
//  democell
//
//  Created by 王俊钢 on 2017/5/14.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "ViewController.h"
#import "AFManager.h"
#import "textCell.h"
#import "firstModel.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,mycellVdelegate>
@property (nonatomic,strong) UITableView *maintable;
@property (nonatomic,strong) NSMutableArray *datasourcearr;

@end
static NSString *kcellname = @"name1";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.datasourcearr = [NSMutableArray array];
    [self loaddatafromweb];
    [self.view addSubview:self.maintable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.maintable.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

-(void)loaddatafromweb
{
    NSString *urlstr = @"http://np.iwenyu.cn/forum/index/detail.html?id=918&page=1&token=f054925590e54922f592f3b232924e70";
    [AFManager getReqURL:urlstr block:^(id infor) {
        NSDictionary *infodit = [infor objectForKey:@"info"];
        NSArray *dicarr = [infodit objectForKey:@"all_comment"];
        for (int i = 0; i<dicarr.count; i++) {
            NSDictionary *dit = [dicarr objectAtIndex:i];
            firstModel *fmodel = [[firstModel alloc] init];
            fmodel.contentstr = [dit objectForKey:@"content"];
            fmodel.pinglunarr = [dit objectForKey:@"sonComment"];
            [self.datasourcearr addObject:fmodel];
        }
        [self.maintable reloadData];
    } errorblock:^(NSError *error) {
        
    }];
}

#pragma mark -getters

-(UITableView *)maintable
{
    if(!_maintable)
    {
        _maintable = [[UITableView alloc] init];
        _maintable.dataSource = self;
        _maintable.delegate = self;
    }
    return _maintable;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasourcearr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    textCell *cell = [tableView dequeueReusableCellWithIdentifier:kcellname];
    cell = [[textCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kcellname];
    [cell setcelldata:self.datasourcearr[indexPath.row]];
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //textCell *cell = [tableView dequeueReusableCellWithIdentifier:kcellname];
    textCell * cell = [[textCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kcellname];
    return [cell setcelldata:self.datasourcearr[indexPath.row]]+cell.texttable.frame.size.height+20;

}

-(void)myTabVClick:(UITableViewCell *)cell datadic:(NSDictionary *)dic
{
    NSLog(@"dic=======%@",dic);
}


@end
