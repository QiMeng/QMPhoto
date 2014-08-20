//
//  M2Scene.m
//  m2048
//
//  Created by QiMengJin on 14-5-3.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import "M2Scene.h"

#import "M2GameManager.h"

@implementation M2Scene {
    M2GameManager *_manager;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

         _manager = [[M2GameManager alloc] init];
        
        
        
        
        
        
        UISwipeGestureRecognizer *recognizer;
        
        recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [self  addGestureRecognizer:recognizer];
        
        recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        
        [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
        [self addGestureRecognizer:recognizer];
        
        recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        
        [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
        [self addGestureRecognizer:recognizer];
        
        recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        
        [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
        [self addGestureRecognizer:recognizer];
        

        
        [self startNewGame];
    }
    return self;
}


//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//    _manager = [[M2GameManager alloc] init];
//    
//    UISwipeGestureRecognizer *recognizer;
//    
//    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
//    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
//    [self  addGestureRecognizer:recognizer];
//    
//    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
//    
//    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
//    [self addGestureRecognizer:recognizer];
//    
//    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
//    
//    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
//    [self addGestureRecognizer:recognizer];
//    
//    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
//    
//    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
//    [self addGestureRecognizer:recognizer];
//    
//    [self startNewGame];
//    
//    
//}


- (void)startNewGame
{
    [_manager startNewSessionWithScene:self];
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionDown) {
        
         [_manager moveToDirection:M2DirectionUp] ;
    }
    if(recognizer.direction==UISwipeGestureRecognizerDirectionUp) {

        [_manager moveToDirection:M2DirectionDown];
    }
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {

        [_manager moveToDirection:M2DirectionLeft];
    }
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {

        [_manager moveToDirection:M2DirectionRight];
    }
    
}

- (void)updateTheme {
    
    [_manager updateTheme];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context=UIGraphicsGetCurrentContext();//设置一个空白view，准备画画
    CGContextSetRGBStrokeColor(context, 255.0, 255.0, 255.0, 3.0);//设置当前笔头颜色
    CGContextSetLineWidth(context, 2.0);//设置当前画笔粗细
    CGContextMoveToPoint(context, 0, 0);//将花笔移到某点
    CGContextAddLineToPoint(context, self.frame.size.width*(0/4.0), self.frame.size.height*(4/4.0));//设置一个终点
    CGContextAddLineToPoint(context, self.frame.size.width*(1/4.0), self.frame.size.height*(4/4.0));//设置一个终点
    CGContextAddLineToPoint(context, self.frame.size.width*(1/4.0), self.frame.size.height*(0/4.0));//设置一个终点
    CGContextAddLineToPoint(context, self.frame.size.width*(2/4.0), self.frame.size.height*(0/4.0));//设置一个终点
    CGContextAddLineToPoint(context, self.frame.size.width*(2/4.0), self.frame.size.height*(4/4.0));//设置一个终点
    CGContextAddLineToPoint(context, self.frame.size.width*(3/4.0), self.frame.size.height*(4/4.0));//设置一个终点
    CGContextAddLineToPoint(context, self.frame.size.width*(3/4.0), self.frame.size.height*(0/4.0));//设置一个终点
    CGContextAddLineToPoint(context, self.frame.size.width*(4/4.0), self.frame.size.height*(0/4.0));//设置一个终点
    CGContextAddLineToPoint(context, self.frame.size.width*(4/4.0), self.frame.size.height*(4/4.0));//设置一个终点
    
    CGContextAddLineToPoint(context, self.frame.size.width*(0/4.0), self.frame.size.height*(4/4.0));//设置一个终点
    CGContextAddLineToPoint(context, self.frame.size.width*(0/4.0), self.frame.size.height*(3/4.0));//设置一个终点
    CGContextAddLineToPoint(context, self.frame.size.width*(4/4.0), self.frame.size.height*(3/4.0));//设置一个终点
    CGContextAddLineToPoint(context, self.frame.size.width*(4/4.0), self.frame.size.height*(2/4.0));//设置一个终点
    CGContextAddLineToPoint(context, self.frame.size.width*(0/4.0), self.frame.size.height*(2/4.0));//设置一个终点
    CGContextAddLineToPoint(context, self.frame.size.width*(0/4.0), self.frame.size.height*(1/4.0));//设置一个终点
    CGContextAddLineToPoint(context, self.frame.size.width*(4/4.0), self.frame.size.height*(1/4.0));//设置一个终点
    CGContextAddLineToPoint(context, self.frame.size.width*(4/4.0), self.frame.size.height*(0/4.0));//设置一个终点
    CGContextAddLineToPoint(context, self.frame.size.width*(0/4.0), self.frame.size.height*(0/4.0));//设置一个终点
    
    
    CGContextStrokePath(context);

}

@end
