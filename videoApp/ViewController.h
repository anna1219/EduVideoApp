//
//  ViewController.h
//  videoApp
//
//  Created by Anna Yu on 11/7/12.
//  Copyright (c) 2012 Anna Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController : UIViewController
<UIImagePickerControllerDelegate,
UINavigationControllerDelegate,UIPopoverControllerDelegate>
{
    UIToolbar *toolbar;
    UIPopoverController *popoverController;
    UIImageView *imageView;
    BOOL newMedia;
}

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
- (IBAction)useCamera;
- (IBAction)useCameraRoll: (id)sender;
@end
