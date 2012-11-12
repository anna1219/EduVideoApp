//
//  ViewController.m
//  videoApp
//
//  Created by Anna Yu on 11/7/12.
//  Copyright (c) 2012 Anna Yu. All rights reserved.
//

#import "ViewController.h"
#import "VideoUpload.h"

@interface ViewController ()

@end


@implementation ViewController

@synthesize imageView, popoverController, toolbar;
@synthesize videoUploader = _videoUploader;

- (void)viewDidLoad
{
    UIBarButtonItem *cameraButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Camera"
                                     style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(useCamera:)];
    UIBarButtonItem *cameraRollButton = [[UIBarButtonItem alloc]
                                         initWithTitle:@"Camera Roll"
                                         style:UIBarButtonItemStyleBordered
                                         target:self
                                         action:@selector(useCameraRoll:)];
    NSArray *items = [NSArray arrayWithObjects: cameraButton,
                      cameraRollButton, nil];
    [toolbar setItems:items animated:NO];
    [cameraButton release];
    [cameraRollButton release];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction) useCamera: (id)sender
{
    [self disablePopOver];
    
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        [self setUpImagePickerController:UIImagePickerControllerSourceTypeCamera:imagePicker];
        [self presentViewController:imagePicker
                           animated:YES
                         completion:NULL];
        [imagePicker release];
        newMedia = YES;        
    }
    else
    {
        newMedia = NO;
        NSLog(@"Camera does not work");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Camera is not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

- (IBAction) useCameraRoll: (id)sender
{
    if ([self disablePopOver]){}
        else if
    ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            UIImagePickerController *imagePicker =
            [[UIImagePickerController alloc] init];
            [self setUpImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary:imagePicker];
            self.popoverController = [[UIPopoverController alloc]
                                      initWithContentViewController:imagePicker];
            
            popoverController.delegate = self;
            
            [self.popoverController
             presentPopoverFromBarButtonItem:sender
             permittedArrowDirections:UIPopoverArrowDirectionUp
             animated:YES];
            
            [imagePicker release];
            newMedia = NO;
        }
}


-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info
                           objectForKey:UIImagePickerControllerMediaType];
    [self dismissViewControllerAnimated:YES completion:NULL];
    
 //       UIImage *video = [info
 //                         objectForKey:UIImagePickerControllerOriginalImage];
        NSString *mediaPath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
        NSURL *mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
        //imageView.image = video;
        
        if (newMedia)
        {
            [self SaveVideoAtPathToAppDirectory:mediaPath];        
            UISaveVideoAtPathToSavedPhotosAlbum(mediaPath,
                                                self,
                                                @selector(video:didFinishSavingWithError:contextInfo:),
                                                NULL);
            
            self.videoUploader = [[VideoUpload alloc] init];
            [self.videoUploader uploadToAmazonS3:mediaURL];
            [self.videoUploader release];
        }
}

- (void)SaveVideoAtPathToAppDirectory:(NSString *)mediaPath
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES) objectAtIndex:0];
    
    NSError *error;
    
    NSLog(@"documentPath - %@", documentPath);
    
    [[NSFileManager defaultManager] copyItemAtPath:mediaPath
                                            toPath:documentPath
                                             error:&error];    
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo: (void *)contextInfo
{
    if (!videoPath && error)
    {
        NSLog(@"Error saving video to saved photos roll: %@, %@", error, [error userInfo]);
        // Handle error;
        return;
    }
    
    // Video was saved properly. UI may need to be updated here.
}

- (Boolean)disablePopOver{
    if ([self.popoverController isPopoverVisible]) {
        [self.popoverController dismissPopoverAnimated:YES];
        [popoverController release];
        return true;}
    else return false;
    }

- (void)setUpImagePickerController:(UIImagePickerControllerSourceType)sourceType:(UIImagePickerController *)UIpicker{
    UIpicker.delegate = self;
    UIpicker.sourceType = sourceType;
    UIpicker.mediaTypes = [NSArray arrayWithObjects:
                              (NSString *) kUTTypeMovie,
                              nil];
    UIpicker.allowsEditing = NO;    
    }


@end
