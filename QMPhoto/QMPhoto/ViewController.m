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
            
        });
    });
    
    
    [self admobAds];

    [self performSelector:@selector(showInterstitial:) withObject:nil afterDelay:30];
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

#pragma mark - 广告

- (void)showInterstitial:(id)sender {
    // Create a new GADInterstitial each time.  A GADInterstitial
    // will only show one request in its lifetime. The property will release the
    // old one and set the new one.
    
    //    if (!self.interstitial) {
    self.interstitial = [[GADInterstitial alloc] init];
    self.interstitial.delegate = self;
    //    }
    
    // Note: Edit InterstitialExampleAppDelegate.m to update
    // INTERSTITIAL_AD_UNIT_ID with your interstitial ad unit id.
    AppDelegate *appDelegate =
    (AppDelegate *)
    [UIApplication sharedApplication].delegate;
    self.interstitial.adUnitID = appDelegate.interstitialAdUnitID;
    
    [self.interstitial loadRequest: [appDelegate createRequest]];
    //    interstitialButton_.enabled = NO;
}
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad{
    [ad presentFromRootViewController:self];
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)ad{
    
    [self performSelector:@selector(showInterstitial:) withObject:nil afterDelay:60];
}
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
//    self.interstitial.delegate = nil;
//    
    [self performSelector:@selector(showInterstitial:) withObject:nil afterDelay:60];
}
- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
    
//    [self performSelector:@selector(showInterstitial:) withObject:nil afterDelay:10];
    
}

#pragma mark - 添加广告
- (void)admobAds {
    
    //广告应用
    bannerView_ = [[GADBannerView alloc]
                   initWithFrame:CGRectMake(0.0,
                                            self.view.frame.size.height -
                                            GAD_SIZE_320x50.height,
                                            GAD_SIZE_320x50.width,
                                            GAD_SIZE_320x50.height)];

    // 指定广告单元ID。
    bannerView_.delegate = self;
    bannerView_.adUnitID = MY_BANNER_UNIT_ID;
    bannerView_.rootViewController = self;
    [self.view addSubview:bannerView_];
    [bannerView_ loadRequest:[GADRequest request]];
    
    
    //#warning 测试广告应用
    //    GADRequest *request = [GADRequest request];
    //    request.testDevices = [NSArray arrayWithObjects:GAD_SIMULATOR_ID, nil];
    //    [bannerView_ loadRequest:request];
    
}
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"Received ad successfully");
}
- (void)adView:(GADBannerView *)view
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"Failed to receive ad with error: %@", [error localizedFailureReason]);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
