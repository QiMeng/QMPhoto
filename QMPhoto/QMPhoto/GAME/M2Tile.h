//
//  M2Tile.h
//  m2048
//
//  Created by QiMengJin on 14-5-3.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class M2Cell;

@interface M2Tile : UIView

//网格等级
@property (nonatomic) NSInteger level;

//网格
@property (nonatomic, weak) M2Cell *cell;


//插入网格
+ (M2Tile *)insertNewTileToCell:(M2Cell *)cell;

//提交动画
- (void)commitPendingActions;

//判断匹配
- (BOOL)canMergeWithTile:(M2Tile *)tile;


//
- (NSInteger)mergeToTile:(M2Tile *)tile;

- (NSInteger)merge3ToTile:(M2Tile *)tile andTile:(M2Tile *)furtherTile;

//移动
- (void)moveToCell:(M2Cell *)cell;


//移除
- (void)removeAnimated:(BOOL)animated;

//刷新数据
- (void)refreshValue;

@end
