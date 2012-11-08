//
//  VideoUpload.m
//  videoApp
//
//  Created by Anna Yu on 11/8/12.
//  Copyright (c) 2012 Anna Yu. All rights reserved.
//

#import "VideoUpload.h"

@implementation VideoUpload

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSURL *urlvideo = [info objectForKey:UIImagePickerControllerMediaURL];
    
  //  urlvideo contains the URL of that video file that has to be uploaded. Then convert the url into NSString type because setFile method requires NSString as a parameter
    
    NSString *urlString=[urlvideo path];
    NSLog(@"urlString=%@",urlString);
    NSString *str = [NSString stringWithFormat:@"path of server"];
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setFile:urlString forKey:@"key foruploadingFile"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startSynchronous];
    NSLog(@"responseStatusCode %i",[request responseStatusCode]);
    NSLog(@"responseStatusCode %@",[request responseString]);
}


@end
