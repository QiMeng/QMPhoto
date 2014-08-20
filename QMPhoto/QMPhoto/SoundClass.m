//
//  SoundClass.m
//  m2048
//
//  Created by QiMengJin on 14-5-4.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import "SoundClass.h"





@implementation SoundClass
+ (SoundClass *)state
{
    static SoundClass *state = nil;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        state = [[SoundClass alloc] init];
        
        
    });
    
    return state;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:kMergerSound ofType:@"mp3"];
        NSURL *musicURL = [[NSURL alloc] initFileURLWithPath:musicFilePath];
        self.mergerSound = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];

        [self.mergerSound prepareToPlay];

    }
    return self;
}

+ (NSString *)soundStatus {
    
    //背景音乐
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kMergerSound]) {
        
        return @"关";
    }else {
        return @"开";
    }
    
    
}

//播放特效
+ (void)mergerSound {
    
    //背景音乐
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kMergerSound]) {
        [[SoundClass state].mergerSound pause];

    }else {
        [[SoundClass state].mergerSound play];
    }
    
}

+ (void)backgroundSound {
    
    //背景音乐
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kBackGroundSound]) {
        [[SoundClass state].backgroundSound pause];

    }else {
        [[SoundClass state].backgroundSound play];
    }
    

    
}

@end
