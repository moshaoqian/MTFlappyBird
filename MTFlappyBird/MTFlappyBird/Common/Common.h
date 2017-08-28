//
//  Common.h
//  flappyBird
//
//  Created by dengwei on 16/1/24.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#ifndef flappyBird_Common_h
#define flappyBird_Common_h

/**Rank按钮高度*/
#define kRankButtonH    60

/**Rank按钮宽度*/
#define kRankButtonW    100

/**Rate按钮高度*/
#define kRateButtonH    56

/**Rate按钮宽度*/
#define kRateButtonW    70

/**Start按钮高度*/
#define kStartButtonH   60

/**Start按钮高度*/
#define kStartButtonW   100

/**游戏名宽度*/
#define kMainTitleW     200
/**游戏名高度*/
#define kMainTitleH     50

/**游戏分数区域高度*/
#define kScoreViewH     120
/**游戏分数区域宽度*/
#define kScoreViewW     200

/**游戏结束提示高度*/
#define kGameOverViewH 60
/**游戏结束提示宽度*/
#define kGameOverViewW 220

/**屏幕宽度*/
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

/**屏幕高度*/
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

/**最佳成绩*/
#define kBestScoreKey @"bestScore"
/**本局成绩*/
#define kCurrentScoreKey @"currentScore"
/**游戏难度等级*/
#define kRateKey @"rate"
/**游戏排行榜*/
#define kRankKey @"rank"

#endif
