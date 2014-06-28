//
//  M2GlobalState.h
//  m2048
//
//  Created by QiMengJin on 14-5-3.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "M2Position.h"

#import "SoundClass.h"

#define GSTATE [M2GlobalState state]
#define Settings [NSUserDefaults standardUserDefaults]
#define NotifCtr [NSNotificationCenter defaultCenter]

typedef NS_ENUM(NSInteger, M2GameType) {
    M2GameTypePowerOf2 = 0,
    M2GameTypePowerOf3 = 1,
    M2GameTypeFibonacci = 2
};

@interface M2GlobalState : NSObject

@property (nonatomic, readonly) NSInteger dimension;       //网格数
@property (nonatomic, readonly) NSInteger winningLevel;    //等级
@property (nonatomic, readonly) NSInteger tileSize;        //贴图大小
@property (nonatomic, readonly) NSTimeInterval animationDuration;  //动作时间
@property (nonatomic, assign) NSInteger theme;  //主题



+ (M2GlobalState *)state;   //单例

//判断此级别是否有相等的
- (BOOL)isLevel:(NSInteger)level1 mergeableWithLevel:(NSInteger)level2;
//合并两个相等的级别
- (NSInteger)mergeLevel:(NSInteger)level1 withLevel:(NSInteger)level2;
//指定级别的数值
- (NSInteger)valueForLevel:(NSInteger)level;


- (CGRect) rectOfPosition:(M2Position)position ;


#pragma mark - 主题
//设置等级颜色
- (UIImage *)imageForLevel:(NSInteger)level;

- (UIColor *)textColorForLevel:(NSInteger)level;
- (UIColor *)colorForLevel:(NSInteger)level;

@end
