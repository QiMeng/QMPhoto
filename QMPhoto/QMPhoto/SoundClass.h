//
//  SoundClass.h
//  m2048
//
//  Created by QiMengJin on 14-5-4.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundClass : NSObject

@property (nonatomic, strong) AVAudioPlayer *mergerSound;   //特效

@property (nonatomic, strong) AVAudioPlayer *backgroundSound;//背景音乐

+ (SoundClass *)state;   //单例

/**
 *  声音特效
 */
+ (void)mergerSound;

/**
 *  背景音乐
 */
+ (void)backgroundSound;

@end
