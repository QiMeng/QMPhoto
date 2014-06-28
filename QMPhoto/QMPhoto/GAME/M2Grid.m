//
//  M2Grid.m
//  m2048
//
//  Created by QiMengJin on 14-5-3.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import "M2Grid.h"
#import "M2Tile.h"
#import "M2Scene.h"

#import "BaseAnimation.h"

@interface M2Grid ()

@property (nonatomic, readwrite) NSInteger dimension;

@end

@implementation M2Grid {
    NSMutableArray *_grid;
}

#pragma mark - 初始化网格
- (instancetype)initWithDimension:(NSInteger)dimension
{
    if (self = [super init]) {
        
        _grid = [[NSMutableArray alloc] initWithCapacity:dimension];
        
        for (NSInteger i = 0; i < dimension; i++) {
            NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:dimension];
            for (NSInteger j = 0; j < dimension; j++) {
                [array addObject:[[M2Cell alloc] initWithPosition:M2PositionMake(i, j)]];
            }
            [_grid addObject:array];
        }
        
        self.dimension = dimension;

    }
    
    return self;
}
#pragma mark - 网格遍历
- (void)forEach:(IteratorBlock)block reverseOrder:(BOOL)reverse
{
    if (!reverse) {
        for (NSInteger i = 0; i < self.dimension; i++) {
            for (NSInteger j = 0; j < self.dimension; j++) {
                block(M2PositionMake(i, j));
            }
        }
    } else {
        for (NSInteger i = self.dimension - 1; i >= 0; i--) {
            for (NSInteger j = self.dimension - 1; j >= 0; j--) {
                block(M2PositionMake(i, j));
            }
        }
    }
}
# pragma mark - 位置坐标的方法

- (M2Cell *)cellAtPosition:(M2Position)position
{
    if (position.x >= self.dimension || position.y >= self.dimension ||
        position.x < 0 || position.y < 0) return nil;
    return [[_grid objectAtIndex:position.x] objectAtIndex:position.y];
}

- (M2Tile *)tileAtPosition:(M2Position)position
{
    M2Cell *cell = [self cellAtPosition:position];
    return cell ? cell.tile : nil;
}


# pragma mark - 网格的可用性

- (BOOL)hasAvailableCells
{
    return [self availableCells].count != 0;
}

#pragma mark - 随机获取可用的网格

- (M2Cell *)randomAvailableCell
{
    NSArray *availableCells = [self availableCells];
    if (availableCells.count) {
        return [availableCells objectAtIndex:arc4random_uniform((int)availableCells.count)];
    }
    return nil;
}

#pragma mark - 可用的网格数组
- (NSArray *)availableCells
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:self.dimension * self.dimension];
    [self forEach:^(M2Position position) {
        M2Cell *cell = [self cellAtPosition:position];
        if (!cell.tile) [array addObject:cell];
    } reverseOrder:NO];
    return array;
}


#pragma mark - 插入网格
- (void)insertTileAtRandomAvailablePositionWithDelay:(BOOL)delay
{
    M2Cell *cell = [self randomAvailableCell];
    if (cell) {
        M2Tile *tile = [M2Tile insertNewTileToCell:cell];
        [self.scene addSubview:tile];

        CABasicAnimation * a1 = [BaseAnimation scale:@1 orgin:@0 durTimes:GSTATE.animationDuration Rep:NO];
        [tile.layer addAnimation:a1 forKey:nil];
        
    }
}

#pragma mark -  移除所有的网格
- (void)removeAllTilesAnimated:(BOOL)animated
{
    [self forEach:^(M2Position position) {
        M2Tile *tile = [self tileAtPosition:position];
        if (tile)
            [tile removeAnimated:animated];
    } reverseOrder:NO];
}

@end
