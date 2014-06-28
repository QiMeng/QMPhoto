//
//  ListViewController.m
//  QMPhoto
//
//  Created by QiMengJin on 14-6-15.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import "ListViewController.h"
#import "ViewController.h"

#import "PhotoViewController.h"


#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>

#include "NCSGameCenter.h"

#define ORIGINAL_MAX_WIDTH 640.0f

@interface ListViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate,VPImageCropperDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) NSArray * listArray;


@end

@implementation ListViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    
    self.title = @"设置";
    
    _listArray = @[@[@"继续",@"重新开始"],@[@"音效"],@[@"排行榜"],
                   
  TextureState.imageArray];
    
    
    
    listTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    listTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin;
    listTableView.delegate = self;
    listTableView.dataSource = self;
    [self.view addSubview:listTableView];
    
    
    
    
    
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return _listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    NSArray * array = [_listArray objectAtIndex:section];
    return array.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float height = 44;
    switch (indexPath.section) {
        case 0:
        case 1:
        case 2:
            break;
            
        default:
            
            height = 120;
            
            break;
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdetify = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdetify];
    }
    
    UIImageView * tileImage = (UIImageView *)[cell.contentView viewWithTag:201];
    if (!tileImage) {
        tileImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
        tileImage.contentMode = UIViewContentModeScaleAspectFill;
        tileImage.backgroundColor = [UIColor whiteColor];
        tileImage.layer.cornerRadius = 5;
        tileImage.clipsToBounds = YES;
        tileImage.tag = 201;
        [cell.contentView addSubview:tileImage];
    }
    
    tileImage.hidden = YES;;

    
    
    
    UIImageView * tileNumImage = (UIImageView *)[cell.contentView viewWithTag:200];
    if (!tileNumImage) {
        tileNumImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
        tileNumImage.contentMode = UIViewContentModeScaleAspectFill;
        tileNumImage.backgroundColor = [UIColor clearColor];
        tileNumImage.layer.cornerRadius = 5;
        tileNumImage.clipsToBounds = YES;
        tileNumImage.tag = 200;
        [cell.contentView addSubview:tileNumImage];
    }
    
    tileNumImage.hidden = YES;
    
    
    
    
    
    
    
    NSArray * array = [_listArray objectAtIndex:indexPath.section];
    
    id data = [array objectAtIndex:indexPath.row];
    
    if ([data isKindOfClass:[NSString class]]) {
        cell.textLabel.text = data;
    }else  {
        cell.textLabel.text = @"";
    }
    
    switch (indexPath.section) {
        case 0:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.detailTextLabel.text = @"";
            cell.imageView.image = nil;
        }
            break;
        case 1:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.detailTextLabel.text = [SoundClass soundStatus];
           cell.imageView.image = nil;
        }
            break;
        case 2:
        {
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
            cell.detailTextLabel.text = @"";
            cell.imageView.image = nil;
        }
            break;
        case 3:
        {
            cell.accessoryType = UITableViewCellAccessoryDetailButton;
            cell.detailTextLabel.text = @"";
            
            tileImage.image = [TextureState.imageArray objectAtIndex :indexPath.row];
//            cell.imageView.image = [TextureState.imageArray objectAtIndex :indexPath.row];
            
            tileNumImage.image =  [UIImage imageNamed:[NSString stringWithFormat:@"%d",[GSTATE valueForLevel:indexPath.row+1]]];
  
            tileImage.hidden = NO;;
            tileNumImage.hidden = NO;
        }
            break;
            
        default:
            break;
    }
    
    
    

    
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                    break;
                case 1:
                {
                    [_delegate agreeGame];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {

                    [[NSUserDefaults standardUserDefaults] setBool:![[NSUserDefaults standardUserDefaults] boolForKey:kMergerSound] forKey:kMergerSound];

                    [listTableView reloadData];

                    [SoundClass mergerSound];
                    
                }
                    break;
                case 1:
                {
#warning 音乐

                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            [[NCSGameCenter sharedGameCenter] showLeaderboard];
        }
            break;
        case 3:
        {
            
            selectInt = indexPath.row;
            
            [self editPortrait];

        }
            break;
            
        default:
            break;
    }

    
}




- (void)editPortrait {
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
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

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    
    
    [QMLocal saveImage:editedImage withName:[NSString stringWithFormat:@"%d",[self valueForLevel:selectInt+1]]];
    
    
    [TextureState.imageArray replaceObjectAtIndex:selectInt withObject:editedImage];
   
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
            
            [listTableView reloadData];
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
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
