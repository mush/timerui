//
//  CircularTimerViewExampleTests.m
//  CircularTimerViewExampleTests
//
//  Created by Ashiqur Rahman on 11/29/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RingProgressView.h"

#define EXP_START(desc) XCTestExpectation *expt = [self expectationWithDescription:desc]
#define EXP_FULFILL() [expt fulfill]
#define EXP_END() [self waitForExpectationsWithTimeout:30.0 handler:^(NSError * _Nullable error) {\
XCTAssertNil(error, "error");\
}]

@interface CircularTimerViewExampleTests : XCTestCase
@property(nonatomic) RingProgressView *ringView;
@property(nonatomic) NSTimeInterval duration;
@end

@implementation CircularTimerViewExampleTests

- (void)setUp {
    [super setUp];
    self.duration = 3.0;
    self.ringView = [[RingProgressView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    self.ringView.timerDuration = self.duration;
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPauseAndResume {
    
    [self.ringView performSelector:@selector(tap:) withObject:nil];
    
    XCTAssertEqual(self.ringView.state, RingProgressStateStarted);
    
    [self.ringView performSelector:@selector(tap:) withObject:nil];
    XCTAssertEqual(self.ringView.state, RingProgressStatePaused);
    
    [self.ringView performSelector:@selector(tap:) withObject:nil];
    XCTAssertEqual(self.ringView.state, RingProgressStateStarted);
}
-(void)testReset{
    
    EXP_START(@"testTaskForRadarSearchForCoordinate");
    
    [self.ringView performSelector:@selector(tap:) withObject:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        XCTAssertEqual(self.ringView.state, RingProgressStateCompleted);
        
        [self.ringView performSelector:@selector(tap:) withObject:nil];
        XCTAssertEqual(self.ringView.state, RingProgressStateNone);
        
        EXP_FULFILL();
    });
    
    EXP_END();

}
@end
