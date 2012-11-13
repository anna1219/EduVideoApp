//
//  VideoUpload.m
//  videoApp
//
//  Created by Anna Yu on 11/8/12.
//  Copyright (c) 2012 Anna Yu. All rights reserved.
//

#import "VideoUpload.h"

@implementation VideoUpload
@synthesize videoName;

- (void)uploadToAmazonS3:(NSURL *)videoURL{
    NSString *MY_ACCESS_KEY_ID = @"AKIAJQNYRX3LDPFT6GSA";
    NSString *MY_SECRET_KEY = @"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";
    NSString *MY_VIDEO_BUCKET = @"eduvideoapp";
    NSString *MY_VIDEO_NAME = self.videoName;
    
    NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
    
    AmazonS3Client *s3 = [[[AmazonS3Client alloc] initWithAccessKey:MY_ACCESS_KEY_ID withSecretKey:MY_SECRET_KEY] autorelease];
    
    S3PutObjectRequest *por = [[S3PutObjectRequest alloc] initWithKey:MY_VIDEO_NAME inBucket:MY_VIDEO_BUCKET];
    por.contentType = @"video/quicktime";
    por.data = videoData;
    [s3 putObject:por];
     NSLog(@"did upload to amazon");
    [videoData release];
}

- (void)SaveVideoAtPathToAppDirectory:(NSString *)mediaPath{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES) objectAtIndex:0];
    NSString *videoFileInPath = [documentPath stringByAppendingPathComponent:self.videoName];
    
    
    NSLog(@"documentPath - %@", documentPath);
    NSLog(@"videoFile - %@", videoFileInPath);
    
    NSError *error;
    [[NSFileManager defaultManager] copyItemAtPath:mediaPath
                                            toPath:videoFileInPath
                                             error:&error];
    
    NSArray *pathArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentPath
                                                                             error:&error];
    NSLog(@"content: %@", pathArray);
}

- (void)setVideoNameAsTimeCreated{
    NSDate *newDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterLongStyle];
    NSString *dateAsString = [formatter stringForObjectValue:newDate];
    NSString *movFile = [dateAsString stringByAppendingPathComponent:@".mov"];
    movFile = [movFile stringByReplacingOccurrencesOfString:@"T/" withString:@"T"];
    movFile = [movFile stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    movFile = [movFile stringByReplacingOccurrencesOfString:@"," withString:@"_"];
    movFile = [movFile stringByReplacingOccurrencesOfString:@" " withString:@""];
    movFile = [movFile stringByReplacingOccurrencesOfString:@":" withString:@"_"];
    self.videoName = movFile;
    NSLog(@"time - %@", self.videoName);
}

@end
