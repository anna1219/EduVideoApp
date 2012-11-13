//
//  VideoUpload.h
//  videoApp
//
//  Created by Anna Yu on 11/8/12.
//  Copyright (c) 2012 Anna Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AWSiOSSDK/S3/AmazonS3Client.h>
#import <AWSiOSSDK/SimpleDB/AmazonSimpleDBClient.h>
#import <AWSiOSSDK/SQS/AmazonSQSClient.h>
#import <AWSiOSSDK/SNS/AmazonSNSClient.h>

@interface VideoUpload : NSObject
@property (strong, nonatomic) NSString *videoName;

- (void)uploadToAmazonS3:(NSURL *)videoURL;
- (void)SaveVideoAtPathToAppDirectory:(NSString *)mediaPath;
- (void)setVideoNameAsTimeCreated;

@end
