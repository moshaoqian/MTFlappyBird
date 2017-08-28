//
//  GameOverView.h
//  flappyBird
//
//  Created by dengwei on 16/1/25.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GameOverViewDelegate <NSObject>

@required
/**点击重新开始按钮*/
-(void)restartAction;
/**点击主菜单按钮*/
-(void)mainMenuAction;

@end

@interface GameOverView : UIView

@property (nonatomic, assign) id <GameOverViewDelegate> delegate;

@end
