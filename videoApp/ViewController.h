//
//  ViewController.h
//  videoApp
//
//  Created by Anna Yu on 11/7/12.
//  Copyright (c) 2012 Anna Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AWSiOSSDK/S3/AmazonS3Client.h>
#import <AWSiOSSDK/SimpleDB/AmazonSimpleDBClient.h>
#import <AWSiOSSDK/SQS/AmazonSQSClient.h>
#import <AWSiOSSDK/SNS/AmazonSNSClient.h>
#import "VideoUpload.h"

@interface ViewController : UIViewController
<UIImagePickerControllerDelegate,
UINavigationControllerDelegate,UIPopoverControllerDelegate>
{
    UIToolbar *toolbar;
    UIPopoverController *popoverController;
    UIImageView *imageView;
    VideoUpload *videoUploader;
    BOOL newMedia;
}

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) VideoUpload *videoUploader;
- (IBAction)useCamera;
- (IBAction)useCameraRoll: (id)sender;
- (Boolean)disablePopOver;
- (void)setUpImagePickerController: (UIImagePickerControllerSourceType)sourceType: (UIImagePickerController *)UIpicker;
@end
