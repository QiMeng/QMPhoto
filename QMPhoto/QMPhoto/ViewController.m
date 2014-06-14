//
//  ViewController.m
//  QMPhoto
//
//  Created by QiMengJin on 14-6-14.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import "ViewController.h"

#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    preView.layer.cornerRadius = 5;
    gameView.layer.cornerRadius = 5;
    
    
    
    [self addiCarousel];
    
    
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self showInterstitial:nil];
}


#pragma mark - 添加展示视图
- (void)addiCarousel {
    
    if (!myCarousel) {
        //添加展示图片
        myCarousel = [[iCarousel alloc]initWithFrame:preView.bounds];
        myCarousel.clipsToBounds = YES;
        myCarousel.bounces = YES;
        myCarousel.delegate = self;
        myCarousel.dataSource = self;
        myCarousel.type = iCarouselTypeCoverFlow2;
        myCarousel.alpha = 1;
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
    return 14;
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
    NSString * tileStr = [NSString stringWithFormat:@"%d",[self valueForLevel:index+1]];
    
    ((UIImageView*)view).image = [UIImage imageNamed:tileStr];
    
    return view;
    
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


/// Called when an interstitial ad request succeeded. Show it at the next transition point in your
/// application such as when transitioning between view controllers.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad{
    [ad presentFromRootViewController:self];
}


/// Called just after dismissing an interstitial and it has animated off the screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad{
    
    [self performSelector:@selector(showInterstitial:) withObject:nil afterDelay:60];
}
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
//    self.interstitial.delegate = nil;
//    
    [self performSelector:@selector(showInterstitial:) withObject:nil afterDelay:120];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
