//
//  GameOverView.m
//  flappyBird
//
//  Created by dengwei on 16/1/25.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "GameOverView.h"
#import "Common.h"

#define kButtonH 70
#define kButtonW 120

@implementation GameOverView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGFloat width = self.frame.size.width;
        //game over提示
        UIImageView *gameOverView = [[UIImageView alloc] initWithFrame:CGRectMake((width-kGameOverViewW)/2, 10, kGameOverViewW, kGameOverViewH)];
        gameOverView.image = [UIImage imageNamed:@"gameover"];
        [self addSubview:gameOverView];
        
        //创建主菜单按钮
        UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        menuButton.frame = CGRectMake((width-kButtonW)/2, 110, kButtonW, kButtonH);
        [menuButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
        [self addSubview:menuButton];
        
        //创建重新开始按钮
        UIButton *restartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        restartButton.frame = CGRectMake((width-kButtonW)/2, 210, kButtonW, kButtonH);
        [restartButton setImage:[UIImage imageNamed:@"restart"] forState:UIControlStateNormal];
        [self addSubview:restartButton];
        
        //点击事件
        [menuButton addTarget:self action:@selector(onMenuButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [restartButton addTarget:self action:@selector(onRestartButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)onMenuButtonClick {
    if ([_delegate respondsToSelector:@selector(mainMenuAction)]) {
        [_delegate mainMenuAction];
    }
}

-(void)onRestartButtonClick {
    if ([_delegate respondsToSelector:@selector(restartAction)]) {
        [_delegate restartAction];
    }
}

@end
