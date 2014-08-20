//
//  ViewController.m
//  QMPhoto
//
//  Created by QiMengJin on 14-6-14.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import "ViewController.h"

#import "AppDelegate.h"


#import "ListViewController.h"


#include "NCSGameCenter.h"

#import <SIAlertView.h>

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self updateTheme];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    preView.layer.cornerRadius = 5;
    
    [SoundClass state];
    
    UIActivityIndicatorView* activityIndicatorView = [ [ UIActivityIndicatorView alloc ]
                                                      init];
    activityIndicatorView.center = self.view.center;
    activityIndicatorView.activityIndicatorViewStyle= UIActivityIndicatorViewStyleGray;
    activityIndicatorView.hidesWhenStopped = YES;
    [ self.view addSubview:activityIndicatorView ];
    [ activityIndicatorView startAnimating ];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        

        [TextureState initImageDicFromArray:@[@"2",@"4",@"8",@"16",@"32",@"64",@"128",@"256",@"512",@"1024",@"2048",@"4096",@"8192",@"16384"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self myiCarousel];
            [UIView animateWithDuration:.3 animations:^{

                preView.alpha = 1;
                toolView.alpha = 1;
                gameView.alpha = 1;
                myCarousel.alpha = 1;
                
                [self addGame];
                [self updateScore:0];
                highestLabel.text = [NSString stringWithFormat:@"最高 %d",(int)[Settings integerForKey:@"Best Score"]];
                [[NCSGameCenter sharedGameCenter] reportScore:(int)[Settings integerForKey:@"Best Score"] forCategory:@"2Photo"];
            }];

            [activityIndicatorView stopAnimating];
            
            [self initializeBanner];
            
        });
    });
    
}

//切换主题
- (void)updateTheme {
    [gameView updateTheme];
    [myCarousel reloadData];
}


#pragma mark - 添加游戏视图
- (void)addGame {
    
    gameView.layer.cornerRadius = 5;
    //游戏界面视图
    gameView = [[M2Scene alloc]initWithFrame:CGRectMake(20,
                                                        toolView.bottom+5,
                                                        GSTATE.tileSize*GSTATE.dimension,
                                                        GSTATE.tileSize*GSTATE.dimension)];
    
    gameView.backgroundColor = [UIColor lightGrayColor];//RGBA(0, 178, 238, 0.3);//135 206 235, 0 178 238
//    [gameView viewLineColor:[UIColor whiteColor] borderWidth:3 cornerRadius:0];
    gameView.delegate = self;

    [self.view addSubview:gameView];
    
}


#pragma mark - 进入设置界面
- (IBAction)goToSetView:(id)sender {
    
    ListViewController * ctrl = [[ListViewController alloc]init];
    ctrl.delegate = self;
    [self.navigationController pushViewController: ctrl animated:YES];
    
}


#pragma mark - 重新开始
- (void)agreeGame {
    [gameView startNewGame];

}

#pragma mark - 游戏结束
- (void)endGame:(BOOL)isWin  {
    
    
    NSString * title = @"";
    
    if (isWin) {
        title = @"通关啦!";
    }else {
        
        title = @"GAME OVER!";
        
    }
    
    SIAlertView * alert = [[SIAlertView alloc]initWithTitle:title andMessage:[NSString stringWithFormat:@"得分:%@\n最高:%@",currentLabel.text,highestLabel.text]];
    
    [alert addButtonWithTitle:@"再来一次" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
        [self agreeGame];
    }];
    
    [alert addButtonWithTitle:@"排行榜" type:SIAlertViewButtonTypeCancel handler:^(SIAlertView *alertView) {
        
        [[NCSGameCenter sharedGameCenter] showLeaderboard];
        
    }];
    
    [alert show];
    
    
    
}
- (void)updateScore:(int)score {
    currentLabel.text = [NSString stringWithFormat:@"%ld", (long)score];
    if ([Settings integerForKey:@"Best Score"] < score) {
        [Settings setInteger:score forKey:@"Best Score"];
        highestLabel.text = [NSString stringWithFormat:@"最高 %ld", (long)score];
        [Settings synchronize];
        
        
        [[NCSGameCenter sharedGameCenter] reportScore:score forCategory:@"2Photo"];
    }
}

- (void)currentBaseLevel:(int)level {
    
    
    [myCarousel scrollToItemAtIndex:level-1 animated:YES];
    
}


#pragma mark - 添加展示视图
- (void)myiCarousel {
    
    if (!myCarousel) {
        //添加展示图片
        myCarousel = [[iCarousel alloc]initWithFrame:preView.bounds];
        myCarousel.clipsToBounds = YES;
        myCarousel.bounces = YES;
        myCarousel.delegate = self;
        myCarousel.dataSource = self;
        myCarousel.type = iCarouselTypeCoverFlow2;
        myCarousel.alpha = 0;
        [preView addSubview:myCarousel];
        
    }
    [myCarousel reloadData];
}

#pragma mark - iCarouselDelegate
- (CGFloat)carouselItemWidth:(iCarousel *)carousel {
    return preView.height;
}
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return TextureState.imageArray.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, preView.height-8, preView.height-8)];
        view.contentMode = UIViewContentModeScaleAspectFill;
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 5;
        view.clipsToBounds = YES;
        
    }

    
    UIImageView * tileNumImage = (UIImageView *)[view viewWithTag:200];
    if (!tileNumImage) {
        tileNumImage = [[UIImageView alloc]initWithFrame:view.bounds];
        tileNumImage.contentMode = UIViewContentModeScaleAspectFill;
        tileNumImage.backgroundColor = [UIColor clearColor];
        tileNumImage.layer.cornerRadius = 5;
        tileNumImage.clipsToBounds = YES;
        tileNumImage.tag = 200;
        [view addSubview:tileNumImage];
    }
    
    tileNumImage.image =  [UIImage imageNamed:[NSString stringWithFormat:@"%d",[GSTATE valueForLevel:index+1]]];
   
    tileNumImage.hidden = ![[NSUserDefaults standardUserDefaults] boolForKey:kShowNumTile];
    
    ((UIImageView*)view).image = [TextureState imageForLevel:index];
    
    return view;
    
}

#pragma mark - 添加iad
//自定义的函式 Banner初始化（以画面直立）
- (void)initializeBanner {
    
    //以画面直立的方式设定Banner于画面底部
    bannerView = [[ADBannerView alloc]initWithFrame:CGRectMake(0.0, 430.0, self.view.frame.size.width, 50.0)];
    
    //此Banner所能支援的类型
    bannerView.requiredContentSizeIdentifiers = [NSSet setWithObjects:ADBannerContentSizeIdentifierPortrait, ADBannerContentSizeIdentifierLandscape, nil];
    
    //目前的Banner 类型
    bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    
    //设定代理
    bannerView.delegate = self;
    
    //无法按下触发广告
    bannerView.userInteractionEnabled = NO;
    
    //设定偏位移量
    bannerView.frame = CGRectOffset(bannerView.frame, 0, 50);
    
    [self.view addSubview:bannerView];  
}
- (void)bannerViewAnimation {
    
    //动画设定
    [UIView beginAnimations:@"BannerViewAnimation" context:NULL];
    
    //以userInteractionEnabled状态排判断bannerView是否在画面内
    if (bannerView.userInteractionEnabled) {
        bannerView.frame = CGRectOffset(bannerView.frame, 0, 50);
    }
    else {
        bannerView.frame = CGRectOffset(bannerView.frame, 0, -50);
    }
    
    //开始动画
    [UIView commitAnimations];
    
    //将userInteractionEnabled做反向设定
    bannerView.userInteractionEnabled = !bannerView.userInteractionEnabled;
}
//当ADBannerView完成读取广告时会触发的事件
- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [self bannerViewAnimation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
