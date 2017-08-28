//
//  RateViewController.m
//  flappyBird
//
//  Created by dengwei on 16/1/24.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "RateViewController.h"
#import "Common.h"
#import "DataTool.h"

@interface RateViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *rates;
@end

@implementation RateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _rates = [NSArray arrayWithObjects:@"crazy", @"hard", @"difficult", @"general", @"ordinary", nil];
    
    [self setupUI];
    
    [self setupTableView];
}

-(void)setupUI {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"light"]];
    
    //标题
    CGFloat titleX = (kScreenWidth - kMainTitleW) / 2;
    UIImageView *titleView = [[UIImageView alloc]initWithFrame:CGRectMake(titleX, 80, kMainTitleW, kMainTitleH)];
    titleView.image = [UIImage imageNamed:@"main"];
    [self.view addSubview:titleView];
    
    //提示语
    CGFloat tipsW = 280;
    CGFloat tipsH = 40;
    CGFloat tipsX = (kScreenWidth - tipsW) / 2;
    UILabel *tips = [[UILabel alloc] initWithFrame:CGRectMake(tipsX, 150, tipsW, tipsH)];
    tips.text = @"The game difficulty";
    tips.font = [UIFont fontWithName:@"Marker Felt" size:30];
    tips.textAlignment = NSTextAlignmentCenter;
    tips.textColor = [UIColor orangeColor];
    [self.view addSubview:tips];
}

-(void)setupTableView {
    CGFloat x = 80;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, 190, kScreenWidth-2*x, kScreenHeight - 230) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.scrollEnabled = NO; //设置tableview 不能滚动
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor clearColor];
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rates.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = _rates[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Marker Felt" size:18];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone; //设置表格选择样式,不显示选中的样式
    if ([cell.textLabel.text isEqualToString:[DataTool stringForKey:kRateKey]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.textLabel.textColor = [UIColor redColor];
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = [UIColor orangeColor];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [DataTool setObject:_rates[indexPath.row] forKey:kRateKey];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
