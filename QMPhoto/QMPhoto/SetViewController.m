//
//  SetViewController.m
//  QMPhoto
//
//  Created by QiMengJin on 14-6-15.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()

@end

@implementation SetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView * centerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
    centerView.backgroundColor = [UIColor colorWithRed:169/255.0 green:235/255.0 blue:237/255.0 alpha:1];
    centerView.layer.cornerRadius = 5;
    centerView.center = self.view.center;
    [self.view addSubview:centerView];
    
    VerticalButton * imageBtn = [[VerticalButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    [imageBtn setImage:[UIImage imageNamed:@"pictures"] forState:UIControlStateNormal];
    [imageBtn setTitle:@"图片" forState:UIControlStateNormal];
    
//    imageBtn.backgroundColor = [UIColor redColor];
    [centerView addSubview:imageBtn];
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
