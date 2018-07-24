//
//  DemonstrationTests.m
//  DemonstrationTests
//
//  Created by wyj on 2018/5/23.
//  Copyright © 2018年 Alex. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MainListViewController.h"

@interface DemonstrationTests : XCTestCase

@end

@implementation DemonstrationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUserListRequest {
    MainListViewController *main = [[MainListViewController alloc] initWithNibName:@"MainListViewController" bundle:nil];
    [main getUserList:^(NSObject *obj) {
        NSLog(@"%@",obj);
        XCTAssertNotNil(obj,@"Data request fail");
    }];
  
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
