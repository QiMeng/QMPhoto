//
//  M2Grid.h
//  m2048
//
//  Created by QiMengJin on 14-5-3.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "M2Cell.h"

@class M2Scene;
typedef void (^IteratorBlock)(M2Position);

@interface M2Grid : NSObject

@property (nonatomic, readonly) NSInteger dimension;    //网格数

@property (nonatomic, weak) M2Scene *scene;


- (instancetype)initWithDimension:(NSInteger)dimension;


//遍历网格
- (void)forEach:(IteratorBlock)block reverseOrder:(BOOL)reverse;


//通过坐标获取网格数据
- (M2Cell *)cellAtPosition:(M2Position)position;


//通过坐标获取贴图
- (M2Tile *)tileAtPosition:(M2Position)position;


//判断可用的网格
- (BOOL)hasAvailableCells;


//插入网格
- (void)insertTileAtRandomAvailablePositionWithDelay:(BOOL)delay;


//移除所有的网格
- (void)removeAllTilesAnimated:(BOOL)animated;

@end
