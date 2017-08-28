//
//  SoundTool.h
//  flappyBird
//
//  Created by dengwei on 16/1/24.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundTool : NSObject

/**
 *  播放指定名称的音效
 *
 *  @param fileName 音效文件名
 */
-(void)playSoundByFileName:(NSString *)fileName;

@end
