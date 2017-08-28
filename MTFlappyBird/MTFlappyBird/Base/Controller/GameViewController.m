//
//  GameViewController.m
//  flappyBird
//
//  Created by dengwei on 16/1/24.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "GameViewController.h"
#import "ViewController.h"
#import "RateViewController.h"
#import "Common.h"
#import "SoundTool.h"
#import "DataTool.h"
#import "GameOverView.h"

@interface GameViewController ()<GameOverViewDelegate>
{
    UIImageView *roadView;
    NSTimer *timer;
    BOOL isTap;
    UIImageView *birdsView;
    /**gravity*/
    NSInteger number;
    NSInteger columnNumber;
    UIImageView *topPipe;
    UIImageView *bottomPipe;
    CGRect topPipeFrame;
    UILabel *columnLabel;
    GameOverView *gameOver;
}

@property (nonatomic, strong) SoundTool *soundTool;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

-(void)setupUI {
    //底图
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    imageView.image = [UIImage imageNamed:@"night"];
    [self.view addSubview:imageView];
    
    //底部图片
    roadView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 460, kScreenWidth + 50, 112)];
    roadView.image = [UIImage imageNamed:@"road"];
    [self.view addSubview:roadView];
    
    //小鸟动画
    NSMutableArray *birds = [[NSMutableArray alloc]init];
    for (NSInteger i = 1; i <= 3; i++) {
        NSString *name = [NSString stringWithFormat:@"bird%zi", i];
        UIImage *bird = [UIImage imageNamed:name];
        [birds addObject:bird];
    }
    birdsView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 180, 39, 30)];
    birdsView.animationDuration = 1;
    birdsView.animationImages = birds;
    birdsView.animationRepeatCount = 0;
    [birdsView startAnimating];
    [self.view addSubview:birdsView];
    
    isTap = NO;
    
    //第一次柱子动画
    [self pipe];
    
    //添加手势(单手单击手势)
    UIImageView *tapView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    tapView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap)];
    [tapView addGestureRecognizer:tap];
    [self.view addSubview:tapView];
    
    //物理重力系数
    number = 0;
    
    //计时器
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    
    columnNumber = 0;
    
    //已过柱子计数法及显示
    columnLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth-40, kScreenHeight-100)];
    columnLabel.text = [NSString stringWithFormat:@"%zi",columnNumber];
    columnLabel.textAlignment = NSTextAlignmentCenter;
    columnLabel.font = [UIFont fontWithName:@"Marker Felt" size:150];
    columnLabel.textColor = [UIColor colorWithRed:0.6 green:0.5 blue:0.5 alpha:0.5];
    [self.view addSubview:columnLabel];
    [self.view insertSubview:columnLabel atIndex:2];
    
    self.soundTool = [[SoundTool alloc] init];
}

#pragma mark 绘制柱子
-(void)pipe {
    //通道高度
    NSInteger tunnelHeight = 0;
    //根据游戏难度设定通道高度
    if([[DataTool stringForKey:kRateKey] isEqualToString:@"ordinary"]) {
        tunnelHeight = 100;
    }else if([[DataTool stringForKey:kRateKey] isEqualToString:@"general"]) {
        tunnelHeight = 90;
    }else if([[DataTool stringForKey:kRateKey] isEqualToString:@"difficult"]) {
        tunnelHeight = 80;
    }else if([[DataTool stringForKey:kRateKey] isEqualToString:@"hard"]) {
        tunnelHeight = 75;
    } else if([[DataTool stringForKey:kRateKey] isEqualToString:@"crazy"]) {
        tunnelHeight = 70;
    }
    
    //柱子图像
    NSInteger tall = arc4random() % 200 + 40;
    
    topPipe = [[UIImageView alloc]initWithFrame:CGRectMake(320, -20, 70, tall)];
    topPipe.image = [UIImage imageNamed:@"pipe"];
    [self.view addSubview:topPipe];

    bottomPipe = [[UIImageView alloc]initWithFrame:CGRectMake(320, tall + tunnelHeight, 70, 400)];
    bottomPipe.image = [UIImage imageNamed:@"pipe"];
    [self.view addSubview:bottomPipe];

    //把底部图片视图放在柱子视图上面
    [self.view insertSubview:roadView aboveSubview:bottomPipe];
}

#pragma mark 定时器操作
-(void)onTimer {
    //底部动画移动
    CGRect frame = roadView.frame;
    if (frame.origin.x == -15) {
        frame.origin.x = 0;
    }
    frame.origin.x--;
    roadView.frame = frame;
    
    //上升
    if (isTap == NO) {
        CGRect frame = birdsView.frame;
        frame.origin.y -= 3;
        number += 3;
        birdsView.frame = frame;
        if (number >= 60) {
            isTap = YES;
        }
    }
    
    //下降
    if(isTap == YES && birdsView.frame.origin.y < 370){
        CGRect frame = birdsView.frame;
        frame.origin.y++;
        number -= 2;
        birdsView.frame = frame;
        number = 0;
    }
    
    //柱子移动
    topPipeFrame = topPipe.frame;
    CGRect bottomPipeFrame = bottomPipe.frame;
    topPipeFrame.origin.x--;
    bottomPipeFrame.origin.x--;
    topPipe.frame = topPipeFrame;
    bottomPipe.frame = bottomPipeFrame;
    if (topPipeFrame.origin.x < -70) {
        [self pipe];
    }
    
    //碰撞检测（交集）
    bool topRet = CGRectIntersectsRect(birdsView.frame, topPipe.frame);
    bool bottomRet = CGRectIntersectsRect(birdsView.frame, bottomPipe.frame);
    if (topRet == true || bottomRet == true) {
        [self.soundTool playSoundByFileName:@"punch"];
        [self onStop];
    }
    if (topPipeFrame.origin.x == (100 + 30 - 70)) {
        [self.soundTool playSoundByFileName:@"pipe"];
        [self columnLabelClick];
    }
}

#pragma mark 更新分数
-(void)columnLabelClick {
    
    if (topPipeFrame.origin.x == (100 + 30 - 70)) {
        columnNumber++;
        columnLabel.text = [NSString stringWithFormat:@"%zi",columnNumber];
    }
}

#pragma mark 更新分数记录
-(void)updateScore {
    //更新最佳成绩
    if (columnNumber > [DataTool integerForKey:kBestScoreKey]) {
        [DataTool setInteger:columnNumber forKey:kBestScoreKey];
    }
    //更新本局分数
    [DataTool setInteger:columnNumber forKey:kCurrentScoreKey];
    //更新排行榜
    NSArray *ranks = (NSArray *)[DataTool objectForKey:kRankKey];
    NSMutableArray *newRanksM = [NSMutableArray array];
    NSInteger count = ranks.count;
    BOOL isUpdate = NO;
    for (NSInteger i = 0; i < count; i++) {
        NSString *scoreStr = ranks[i];
        NSInteger score = [scoreStr integerValue];
        if (score < columnNumber && isUpdate == NO) {
            scoreStr = [NSString stringWithFormat:@"%zi", columnNumber];
            [newRanksM addObject:scoreStr];
            isUpdate = YES;
            i--;
        } else {
            scoreStr = [NSString stringWithFormat:@"%zi", score];
            [newRanksM addObject:scoreStr];
        }
    }
    if (newRanksM.count > count) {
        [newRanksM removeLastObject];
    }
    [DataTool setObject:newRanksM forKey:kRankKey];
}

#pragma mark 弹出游戏结束操作界面
-(void)pullGameOver {
    //游戏结束操作界面
    gameOver = [[GameOverView alloc] initWithFrame:CGRectMake(20, 160, 280, 300)];
    gameOver.delegate = self;
    [self.view addSubview:gameOver];
}

#pragma mark 游戏停止
-(void)onStop {
    //更新分数
    [self updateScore];
    //停止定时器
    [timer setFireDate:[NSDate distantFuture]];
    //弹出游戏结束操作界面
    [self pullGameOver];
}

#pragma mark tap手势操作
-(void)onTap {
    isTap = NO;
}

#pragma mark - TipsViewDelegate
-(void)restartAction {
    //重新开始
    ViewController *viewController = [[ViewController alloc]init];
    [self presentViewController:viewController animated:YES completion:nil];
}

-(void)mainMenuAction {
    //主菜单
    ViewController *viewController = [[ViewController alloc]init];
    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - 隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
