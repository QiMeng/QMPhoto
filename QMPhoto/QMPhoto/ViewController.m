//
//  ViewController.m
//  QMPhoto
//
//  Created by QiMengJin on 14-6-14.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import "ViewController.h"

#import "AppDelegate.h"

#import "SetViewController.h"

#import "ListViewController.h"

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
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    preView.layer.cornerRadius = 5;
    gameView.layer.cornerRadius = 5;
    
    
    
    
    
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
            }];

            [activityIndicatorView stopAnimating];
            
        });
    });
    
    
    

    
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self showInterstitial:nil];
}

- (IBAction)goToSetView:(id)sender {
    
    
    ListViewController * ctrl = [[ListViewController alloc]init];
    
    [self.navigationController pushViewController: ctrl animated:YES];
    
//    SetViewController * ctrl = [[SetViewController alloc]init];
//    
////    ctrl.delegate = self;
//    
//    
//    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:ctrl];
//    
//    formSheet.transitionStyle = MZFormSheetTransitionStyleFade;
//    
//    formSheet.cornerRadius = 0;
//    
//    formSheet.shouldDismissOnBackgroundViewTap = YES;
//    
//    formSheet.shouldCenterVertically = YES;
//    
//    formSheet.presentedFormSheetSize = self.view.bounds.size;
//    
//    
//    [self mz_presentFormSheetController:formSheet animated:YES completionHandler:^(MZFormSheetController *formSheetController) {
//        
//    }];
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


/// Called when an interstitial ad request succeeded. Show it at the next transition point in your
/// application such as when transitioning between view controllers.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad{
    [ad presentFromRootViewController:self];
}


/// Called just after dismissing an interstitial and it has animated off the screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad{
    
    [self performSelector:@selector(showInterstitial:) withObject:nil afterDelay:10];
}
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
//    self.interstitial.delegate = nil;
//    
    [self performSelector:@selector(showInterstitial:) withObject:nil afterDelay:10];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
