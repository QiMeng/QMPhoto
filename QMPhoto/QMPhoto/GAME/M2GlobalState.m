//
//  M2GlobalState.m
//  m2048
//
//  Created by QiMengJin on 14-5-3.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import "M2GlobalState.h"
#import "M2Theme.h"
@interface M2GlobalState ()

@property (nonatomic, readwrite) NSInteger dimension;       //网格数
@property (nonatomic, readwrite) NSInteger winningLevel;    //等级
@property (nonatomic, readwrite) NSInteger tileSize;        //贴图大小
@property (nonatomic, readwrite) NSTimeInterval animationDuration;  //动作时间


@end

@implementation M2GlobalState



+ (M2GlobalState *)state
{
    static M2GlobalState *state = nil;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        state = [[M2GlobalState alloc] init];
    });
    
    return state;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setupDefaultState];
        [self loadGlobalState];
    }
    return self;
}

//设置默认状态配置
- (void)setupDefaultState
{
}
//加载配置
- (void)loadGlobalState
{
    self.dimension =4;
    self.animationDuration = 0.1;
}

//最高等级
- (NSInteger)winningLevel
{
    return 13;
}
//贴图的宽度
- (NSInteger)tileSize
{
        return  (DEVICE_SCREEN_WIDTH - 40)/4.0;
}
//判断此级别是否有相等的
- (BOOL)isLevel:(NSInteger)level1 mergeableWithLevel:(NSInteger)level2
{
    return level1 == level2;
}

//合并两个相等的级别
- (NSInteger)mergeLevel:(NSInteger)level1 withLevel:(NSInteger)level2
{
    if (![self isLevel:level1 mergeableWithLevel:level2])
        return 0;

    return level1 + 1;
}

- (CGRect) rectOfPosition:(M2Position)position {
    return CGRectMake(position.x * GSTATE.tileSize, position.y * GSTATE.tileSize, GSTATE.tileSize, GSTATE.tileSize);
}

//指定级别的数值
- (NSInteger)valueForLevel:(NSInteger)level
{
        NSInteger value = 1;
        NSInteger base =  2 ;
        for (NSInteger i = 0; i < level; i++) {
            value *= base;
        }
        return value;
}


#pragma mark - 主题
//设置等级颜色
- (UIImage *)imageForLevel:(NSInteger)level
{
    return [[M2Theme themeClassForType:GSTATE.theme] imageForLevel:level];
}

- (UIColor *)textColorForLevel:(NSInteger)level {
    
    return [[M2Theme themeClassForType:GSTATE.theme] textColorForLevel:level];
    
}

- (UIColor *)colorForLevel:(NSInteger)level {
    
    return [[M2Theme themeClassForType:GSTATE.theme] colorForLevel:level];
    
}


@end
