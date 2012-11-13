//
//  VideoUpload.m
//  videoApp
//
//  Created by Anna Yu on 11/8/12.
//  Copyright (c) 2012 Anna Yu. All rights reserved.
//

#import "VideoUpload.h"

@implementation VideoUpload

- (void)uploadToAmazonS3:(NSURL *)videoURL withVideoName:(NSString *)videoName {
    NSString *MY_ACCESS_KEY_ID = @"AKIAJQNYRX3LDPFT6GSA";
    NSString *MY_SECRET_KEY = @"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";
    NSString *MY_VIDEO_BUCKET = @"eduvideoapp";
    NSString *MY_VIDEO_NAME = videoName;
    
    NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
    
    AmazonS3Client *s3 = [[[AmazonS3Client alloc] initWithAccessKey:MY_ACCESS_KEY_ID withSecretKey:MY_SECRET_KEY] autorelease];
    
 //   [s3 createBucket:[[[S3CreateBucketRequest alloc] initWithName:MY_VIDEO_BUCKET] autorelease]];
    
    S3PutObjectRequest *por = [[S3PutObjectRequest alloc] initWithKey:MY_VIDEO_NAME inBucket:MY_VIDEO_BUCKET];
    por.contentType = @"video/quicktime";
    por.data = videoData;
    [s3 putObject:por];
     NSLog(@"did upload to amazon");
    [videoData release];
}


@end
