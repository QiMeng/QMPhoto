//
//  M2GameManager.m
//  m2048
//
//  Created by QiMengJin on 14-5-3.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import "M2GameManager.h"
#import "M2Grid.h"
#import "M2Tile.h"
#import "M2Scene.h"
#import "ViewController.h"
BOOL iterate(NSInteger value, BOOL countUp, NSInteger upper, NSInteger lower) {
    return countUp ? value < upper : value > lower;
}

@implementation M2GameManager{
    //yes.游戏结束
    BOOL _over;
    
    //yes.游戏完成
    BOOL _won;
    
    //yes.继续游戏
    BOOL _keepPlaying;
    
    //当前分数
    NSInteger _score;
    
    //当前动作得到的分数
    NSInteger _pendingScore;
    
    BOOL isScore;
    
    //网格
    M2Grid *_grid;
    
    int currentInt ;
    
}

#pragma mark - 更新主题
- (void)updateTheme {
    
     __block M2Tile *tile = nil;
    [_grid forEach:^(M2Position position) {
        if ((tile = [_grid tileAtPosition:position])) {
            
            [tile refreshValue];
            
        }
    } reverseOrder:YES];
}


# pragma mark - 开始新的游戏

- (void)startNewSessionWithScene:(M2Scene *)scene
{
    currentInt = 0;
    
    if (_grid && _grid.dimension == GSTATE.dimension) {
        
        [_grid removeAllTilesAnimated:YES];
    } else {
        if (_grid) [_grid removeAllTilesAnimated:NO];
        _grid = [[M2Grid alloc] initWithDimension:GSTATE.dimension];
        _grid.scene = scene;
    }
    
    _score = 0; _over = NO; _won = NO; _keepPlaying = NO;
    _pendingScore = 0;
    [self materializePendingScore];
    
    [_grid insertTileAtRandomAvailablePositionWithDelay:NO];
    [_grid insertTileAtRandomAvailablePositionWithDelay:NO];
}


#pragma mark - 移动网格
- (void)moveToDirection:(M2Direction)direction
{
    __block M2Tile *tile = nil;
    
    BOOL reverse = direction == M2DirectionUp || direction == M2DirectionRight;
    NSInteger unit = reverse ? 1 : -1;
    
    if (direction == M2DirectionRight || direction == M2DirectionLeft) {
        [_grid forEach:^(M2Position position) {
            
            if ((tile = [_grid tileAtPosition:position])) {
                NSInteger target = position.x;
                for (NSInteger i = position.x + unit; iterate(i, reverse, _grid.dimension, -1); i += unit) {
                    M2Tile *t = [_grid tileAtPosition:M2PositionMake(i, position.y)];
                    if (!t)
                        target = i;
                    else {
                        NSInteger level = 0;
                        
                        level = [tile mergeToTile:t];

                        if (level) {
                            target = position.x;
                            _pendingScore += [GSTATE valueForLevel:level];
                            isScore = YES;
                        }
                        
                        break;
                    }
                    
                }
                
                if (target != position.x) {
                    [tile moveToCell:[_grid cellAtPosition:M2PositionMake(target, position.y)]];
                    isScore = YES;
                    
                }
            }
        } reverseOrder:reverse];
    }
    
    else {
        [_grid forEach:^(M2Position position) {
            if ((tile = [_grid tileAtPosition:position])) {
                NSInteger target = position.y;
                for (NSInteger i = position.y + unit; iterate(i, reverse, _grid.dimension, -1); i += unit) {
                    M2Tile *t = [_grid tileAtPosition:M2PositionMake(position.x, i)];
                    
                    if (!t) target = i;
                    
                    else {
                        NSInteger level = 0;
                        
                        level = [tile mergeToTile:t];
                        
                        if (level) {
                            target = position.y;
                            _pendingScore += [GSTATE valueForLevel:level];
                            isScore = YES;
                        }
                        
                        break;
                    }
                }

                if (target != position.y) {
                    
                    [tile moveToCell:[_grid cellAtPosition:M2PositionMake(position.x, target)]];
                    isScore = YES;
                }
                
            }
        } reverseOrder:reverse];
    }
    
    if (!isScore)
        return;
    
    
    [_grid forEach:^(M2Position position) {
        M2Tile *tile = [_grid tileAtPosition:position];
        if (tile) {
            [tile commitPendingActions];
            if (tile.level >= GSTATE.winningLevel)
                _won = YES;
            
            
            currentInt = currentInt>tile.level?currentInt:tile.level;
        }
    } reverseOrder:reverse];
    
    // 更新分数
    [self materializePendingScore];
    
    

    if (!_keepPlaying && _won) {

        _keepPlaying = YES;

        [_grid.scene.delegate endGame:YES];
        return;
    }
    
    [_grid insertTileAtRandomAvailablePositionWithDelay:YES];
    
    
    if (![self movesAvailable]) {
        [_grid.scene.delegate endGame:NO];


    }
}

#pragma mark - 更新分数
- (void)materializePendingScore
{
    _score += _pendingScore;
    _pendingScore = 0;
    isScore = NO;

    [_grid.scene.delegate updateScore:_score];
    
    
    [_grid.scene.delegate currentBaseLevel:currentInt];
}
#pragma mark -遍历相邻是否存在相同的
- (BOOL)movesAvailable
{
    return [_grid hasAvailableCells] || [self adjacentMatchesAvailable];
}

- (BOOL)adjacentMatchesAvailable
{
    for (NSInteger i = 0; i < _grid.dimension; i++) {
        for (NSInteger j = 0; j < _grid.dimension; j++) {

            M2Tile *tile = [_grid tileAtPosition:M2PositionMake(i, j)];
            
            if (!tile)
                continue;
            if ([tile canMergeWithTile:[_grid tileAtPosition:M2PositionMake(i + 1, j)]] ||
                [tile canMergeWithTile:[_grid tileAtPosition:M2PositionMake(i, j + 1)]]) {
                return YES;
            }
            
        }
    }
    return NO;
}




@end
