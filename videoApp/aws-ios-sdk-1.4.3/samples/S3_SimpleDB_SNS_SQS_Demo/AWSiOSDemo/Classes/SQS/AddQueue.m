/*
 * Copyright 2010-2012 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

#import "AddQueue.h"
#import "AmazonClientManager.h"


@implementation AddQueue

-(IBAction)create:(id)sender
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{

        dispatch_async(dispatch_get_main_queue(), ^{

            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        });

        SQSCreateQueueRequest *request = [[[SQSCreateQueueRequest alloc] initWithQueueName:queueName.text] autorelease];
        SQSCreateQueueResponse *response = [[AmazonClientManager sqs] createQueue:request];
        if(response.error != nil)
        {
            NSLog(@"Error: %@", response.error);
        }

        dispatch_async(dispatch_get_main_queue(), ^{

            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            [self dismissModalViewControllerAnimated:YES];
        });
    });
}

-(IBAction)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end