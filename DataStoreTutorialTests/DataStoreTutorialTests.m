//
//  DataStoreTutorialTests.m
//  DataStoreTutorialTests
//
//  Created by Pankaj on 01/08/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HomeViewController.h"
#import "DatabaseManager.h"

@interface DataStoreTutorialTests : XCTestCase {
    HomeViewController *homeViewController;
}

@end

@implementation DataStoreTutorialTests

- (void)setUp {
    [super setUp];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    homeViewController = [storyBoard instantiateViewControllerWithIdentifier:@"HomeViewController"];
}

- (void)tearDown {
    [super tearDown];
}

//Test testFetch
- (void)testDataFetch {
    
    // This deletion is added only for testing this implementation in real implementation this deletion is not require as it is managed in HomeViewController.
    [[DatabaseManager sharedInstance] deleteAllArtist];
    [[DatabaseManager sharedInstance] deleteAllGener];
    
    __weak XCTestExpectation *completionExpectation = [self expectationWithDescription:@"Fetch Data"];
    [homeViewController callLoadItunesDataWebservice:^(NSArray *arrResponse) {
        NSNumber *nCountOfArtist = [NSNumber numberWithInteger:[arrResponse count]];
        NSNumber *nExpectedCountOfArtist = [NSNumber numberWithInt:10];
        XCTAssertEqualObjects(nCountOfArtist, nExpectedCountOfArtist, @"Result is not correct!");
        [completionExpectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
