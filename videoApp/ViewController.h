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
UINavigationControllerDelegate>
{
    UIImageView *imageView;
    BOOL newMedia;
}

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)useCamera;
- (IBAction)useCameraRoll;
@end