//
//  M2Tile.m
//  m2048
//
//  Created by QiMengJin on 14-5-3.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import "M2Tile.h"
#import "M2Cell.h"
#import "BaseAnimation.h"
#import "UILabel+QM_Category.h"
@implementation M2Tile {
    //等级显示文字
    UILabel *_value;
    
    //贴图
    UIImageView * _valueImage;
    
    //贴图
    UIImageView * _valueImage1;
    
    //动画数组
    NSMutableArray *_pendingActions;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _pendingActions = [[NSMutableArray alloc] init];
        
        //贴图图片
        _valueImage  = [[UIImageView alloc]initWithFrame:self.bounds];
        _valueImage.clipsToBounds = YES;
        _valueImage.backgroundColor = [UIColor clearColor];
        _valueImage.contentMode = UIViewContentModeScaleAspectFill;

        [self addSubview:_valueImage];

        
        //贴图图片
        _valueImage1  = [[UIImageView alloc]initWithFrame:self.bounds];
        _valueImage1.clipsToBounds = YES;
        _valueImage1.backgroundColor = [UIColor clearColor];
        _valueImage1.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addSubview:_valueImage1];
        
        //标题
        int border = 2;
        
//        CGRectMake(0, self.bounds.size.height - 20 - border, self.width, 20)
        _value = [UILabel allocLabelFrame:CGRectMake(0, 0, self.width, self.height)
                                 withText:@""
                            withTextColor:[UIColor whiteColor]
                                 withFont:[UIFont boldSystemFontOfSize:20]
                       withTextAlignament:NSTextAlignmentCenter
                            withBackColor:RGBA(0, 0, 0, 0.3)
                           withAdjustBool:NO];

        [self addSubview:_value];

        _value.hidden = YES;
        
        //创建的等级
        self.level = arc4random_uniform(100) < 95 ? 1 : 2;

        //刷新界面
        [self refreshValue];

        
        [self viewLineColor:[UIColor whiteColor] borderWidth:border cornerRadius:0];
    }
    return self;
}

- (void) viewLineColor:(UIColor *)color borderWidth:(float)border cornerRadius:(float)radiu{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth =border;
    self.layer.cornerRadius =radiu;
    [self.layer setMasksToBounds:YES];
}

#pragma mark - 插入网格
+ (M2Tile *)insertNewTileToCell:(M2Cell *)cell
{
    M2Tile *tile = [[M2Tile alloc] initWithFrame:[GSTATE rectOfPosition:cell.position]];
    cell.tile = tile;
    return tile;
}


# pragma mark - 共用方法

- (void)removeFromParentCell
{
    if (self.cell.tile == self){
        self.cell.tile = nil;
        [self.cell.tile removeFromSuperview];
    }
}

#pragma mark - 判断是否有可以合并的网格
- (BOOL)hasPendingMerge
{
    return _pendingActions.count > 1;
}

#pragma mark - 动画
- (void)commitPendingActions
{
    CAAnimationGroup * a4 = [BaseAnimation groupAnimation:_pendingActions durTimes:GSTATE.animationDuration Rep:0];
    [self.layer addAnimation:a4 forKey:nil];
    [_pendingActions removeAllObjects];
}


- (BOOL)canMergeWithTile:(M2Tile *)tile
{
    if (!tile) return NO;
    return [GSTATE isLevel:self.level mergeableWithLevel:tile.level];
}

#pragma mark - 判断合并.返回新的等级
- (NSInteger)mergeToTile:(M2Tile *)tile
{
    if (!tile || [tile hasPendingMerge]) return 0;
    
    NSInteger newLevel = [GSTATE mergeLevel:self.level withLevel:tile.level];
    if (newLevel > 0) {

        [self moveToCell:tile.cell];
 
        [tile removeWithDelay];
        
        [SoundClass mergerSound];
        
        [self updateLevelTo:newLevel];
        
        [_pendingActions addObject:[BaseAnimation scale:@1 orgin:@1.3 durTimes:GSTATE.animationDuration Rep:NO]];
    }
    return newLevel;
}

#pragma mark - 判断合并.返回新的等级
- (NSInteger)merge3ToTile:(M2Tile *)tile andTile:(M2Tile *)furtherTile
{
    if (!tile || [tile hasPendingMerge] || [furtherTile hasPendingMerge]) return 0;
    
    NSUInteger newLevel = MIN([GSTATE mergeLevel:self.level withLevel:tile.level],
                              [GSTATE mergeLevel:tile.level withLevel:furtherTile.level]);
    if (newLevel > 0) {
        
        [tile moveToCell:furtherTile.cell];
        [self moveToCell:furtherTile.cell];
        

        [tile removeWithDelay];
        [furtherTile removeWithDelay];
        
        [self updateLevelTo:newLevel];
        
        [_pendingActions addObject:[BaseAnimation scale:@1 orgin:@1.3 durTimes:GSTATE.animationDuration Rep:NO]];
    }
    return newLevel;
}

#pragma mark - 更新等级
- (void)updateLevelTo:(NSInteger)level
{
    self.level = level;
    
    [_pendingActions addObject:[BaseAnimation scale:@1 orgin:@1.3 durTimes:GSTATE.animationDuration Rep:NO]];
    
    [self refreshValue];
}

#pragma mark - 刷新数据
- (void)refreshValue
{
    long value = [GSTATE valueForLevel:self.level];
    _value.text = [NSString stringWithFormat:@"%ld", value];
    
    _value.textColor = [GSTATE colorForLevel:self.level];
    self.backgroundColor = [GSTATE textColorForLevel:self.level];
    
    _valueImage.image =  [TextureState imageForLevel:self.level-1];
    
    
    _valueImage1.image =  [UIImage imageNamed:[NSString stringWithFormat:@"%d",[GSTATE valueForLevel:self.level]]];//[TextureState imageForLevel:self.level-1];
    
//    _valueImage.clipsToBounds = YES;

    [self viewLineColor:[GSTATE colorForLevel:self.level] borderWidth:2 cornerRadius:0];
}

#pragma mark - 移动
- (void)moveToCell:(M2Cell *)cell
{
    

    cell.tile.frame = self.cell.tile.frame;

    [UIView animateWithDuration:GSTATE.animationDuration animations:^{
        
        self.cell.tile = nil;
        [self.cell.tile removeFromSuperview];
        
        cell.tile = self;
        cell.tile.frame = [GSTATE rectOfPosition:cell.position];
    }];
    

}


- (void)removeAnimated:(BOOL)animated
{
    [self removeFromParentCell];
    [_pendingActions addObject:[BaseAnimation scale:@0 orgin:@1 durTimes:GSTATE.animationDuration Rep:NO]];
    
    [self commitPendingActions];
    
    [self removeFromSuperview];
}


- (void)removeWithDelay
{
    [self removeFromParentCell];
  
    [self removeFromSuperview];
    
}



@end
