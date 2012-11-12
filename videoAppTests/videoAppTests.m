//
//  videoAppTests.m
//  videoAppTests
//
//  Created by Anna Yu on 11/7/12.
//  Copyright (c) 2012 Anna Yu. All rights reserved.
//

#import "videoAppTests.h"
#import "OCMock.h"
#import "OCMockObject.h"
#import "ViewController.h"

@implementation videoAppTests

- (void)setUp
{
    id mockUIImagePickerController = [OCMockObject mockForClass:[UIImagePickerController class]];
    id mockViewController = [OCMockObject mockForClass:[ViewController class]];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)shouldReturnNewMediaIsYes
{
  //  static UIImagePickerController mockUIImagePickerController;
    
    mockUIImagePickerController.isSourceTypeAvailable = YES;
    [mockViewController useCamera];
    
    
    STFail(@"Unit tests are not implemented yet in videoAppTests");
}

@end
