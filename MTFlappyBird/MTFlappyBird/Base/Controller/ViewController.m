//
//  ViewController.m
//  flappyBird
//
//  Created by dengwei on 16/1/22.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "ViewController.h"
#import "GameViewController.h"
#import "Common.h"
#import "DataTool.h"
#import "RateViewController.h"
#import "RankViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    if ([DataTool stringForKey:kRateKey] == nil) {
        [DataTool setObject:@"general" forKey:kRateKey];
    }
    if ([DataTool objectForKey:kRankKey] == nil) {
        NSArray *ranks = [NSArray arrayWithObjects:@"0", @"0", @"0", @"0", @"0", nil];
        [DataTool setObject:ranks forKey:kRankKey];
    }    
    [self setupUI];
}

-(void)setupUI{
    //开始底部图片
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:bgView];
    
    //标题
    CGFloat titleX = (kScreenWidth - kMainTitleW) / 2;
    UIImageView *titleView = [[UIImageView alloc]initWithFrame:CGRectMake(titleX, 80, kMainTitleW, kMainTitleH)];
    titleView.image = [UIImage imageNamed:@"main"];
    [self.view addSubview:titleView];
    
    //分数
    CGFloat scoreViewX = (kScreenWidth - kScoreViewW) / 2;
    UIImageView *scoreView = [[UIImageView alloc]initWithFrame:CGRectMake(scoreViewX, 205, kScoreViewW, kScoreViewH)];
    scoreView.image = [UIImage imageNamed:@"score"];
    [self.view addSubview:scoreView];
    //显示分数
    CGFloat bestX = 200;
    CGFloat bestY = 285;
    CGFloat bestW = 40;
    CGFloat bestH = 20;
    UILabel *bestScore = [[UILabel alloc] initWithFrame:CGRectMake(bestX, bestY, bestW, bestH)];
    bestScore.text = [NSString stringWithFormat:@"%zi", [DataTool integerForKey:kBestScoreKey]];
    bestScore.font = [UIFont fontWithName:@"Marker Felt" size:16];
    bestScore.textAlignment = NSTextAlignmentRight;
    bestScore.textColor = [UIColor orangeColor];
    [self.view addSubview:bestScore];
    
    CGFloat scoreX = 200;
    CGFloat scoreY = 240;
    CGFloat scoreW = 40;
    CGFloat scoreH = 20;
    UILabel *score = [[UILabel alloc] initWithFrame:CGRectMake(scoreX, scoreY, scoreW, scoreH)];
    score.text = [NSString stringWithFormat:@"%zi", [DataTool integerForKey:kCurrentScoreKey]];
    
    score.font = [UIFont fontWithName:@"Marker Felt" size:16];
    score.textAlignment = NSTextAlignmentRight;
    score.textColor = [UIColor orangeColor];
    [self.view addSubview:score];
    
    //birds动画
    NSMutableArray *birds = [[NSMutableArray alloc]init];
    UIImageView *birdViews = [[UIImageView alloc]initWithFrame:CGRectMake(140, 155, 40, 32)];
    for (NSInteger i = 1; i <= 3; i++) {
        UIImage *bird = [UIImage imageNamed:[NSString stringWithFormat:@"bird%zi", i]];
        [birds addObject:bird];
    }
    birdViews.animationImages = birds;
    birdViews.animationDuration = 1;
    birdViews.animationRepeatCount = 0;
    [birdViews startAnimating];
    [self.view addSubview:birdViews];
    
    //创建速度按钮
    UIButton *rateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat rateX = (kScreenWidth - kRateButtonW) / 2;
    rateButton.frame = CGRectMake(rateX, 355, kRateButtonW, kRateButtonH);
    [rateButton setImage:[UIImage imageNamed:@"rate"] forState:UIControlStateNormal];
    [self.view addSubview:rateButton];
    
    //创建开始按钮
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.frame = CGRectMake(50, 430, kStartButtonW, kStartButtonH);
    [startButton setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    [self.view addSubview:startButton];
    
    //创建排行榜按钮
    UIButton *rankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rankButton.frame = CGRectMake(170, 430, kRankButtonW, kRankButtonH);
    [rankButton setImage:[UIImage imageNamed:@"rank"] forState:UIControlStateNormal];
    [self.view addSubview:rankButton];
    
    //点击事件
    [startButton addTarget:self action:@selector(onStartButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [rankButton addTarget:self action:@selector(onRankButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [rateButton addTarget:self action:@selector(onRateButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 按钮响应方法
#pragma mark 点击速度
-(void)onRateButtonClick{
    RateViewController *rateController = [[RateViewController alloc] init];
    [self presentViewController:rateController animated:YES completion:nil];
}

#pragma mark 点击开始
-(void)onStartButtonClick{
    GameViewController *gameController = [[GameViewController alloc] init];
    [self presentViewController:gameController animated:YES completion:nil];
}

#pragma mark 点击排行榜
-(void)onRankButtonClick{
    RankViewController *rankController = [[RankViewController alloc] init];
    [self presentViewController:rankController animated:YES completion:nil];
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
