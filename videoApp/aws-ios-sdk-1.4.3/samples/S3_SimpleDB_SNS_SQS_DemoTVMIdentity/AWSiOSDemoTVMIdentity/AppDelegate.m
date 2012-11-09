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

#import "AppDelegate.h"
#import "AWSiOSDemoTVMIdentityViewController.h"
#import <AWSiOSSDK/AmazonLogger.h>

#import "Crypto.h"

@implementation AppDelegate

@synthesize window = _window;

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UINavigationController *container = [UINavigationController new];
    AWSiOSDemoTVMIdentityViewController *viewController = [[AWSiOSDemoTVMIdentityViewController alloc] initWithNibName:@"AWSiOSDemoTVMIdentityViewController" bundle:nil];
    [container pushViewController:viewController animated:NO];
    [viewController release];

    self.window.rootViewController = container;
    [container release];

    [self.window makeKeyAndVisible];

    // Logging Control - Do NOT use logging for non-development builds.
#ifdef DEBUG
    [AmazonLogger verboseLogging];
#else
    [AmazonLogger turnLoggingOff];
#endif

    return YES;
}

-(void)dealloc
{
    [_window release];
    [super dealloc];
}

@end