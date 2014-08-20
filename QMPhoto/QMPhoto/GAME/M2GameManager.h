//
//  M2GameManager.h
//  m2048
//
//  Created by QiMengJin on 14-5-3.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class M2Scene;

typedef NS_ENUM(NSInteger, M2Direction) {
    M2DirectionUp,
    M2DirectionLeft,
    M2DirectionDown,
    M2DirectionRight
};


@interface M2GameManager : NSObject


//开始新的游戏
- (void)startNewSessionWithScene:(M2Scene *)scene;

//移动网格
- (void)moveToDirection:(M2Direction)direction;

//更新主题
- (void)updateTheme ;

@end
