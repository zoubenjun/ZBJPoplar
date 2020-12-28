//
//  ZBJArrayCategoryTests.m
//  ZBJPoplarTests
//
//  Created by zoubenjun on 2020/12/28.
//

#import <XCTest/XCTest.h>
#import "NSArray+ZBJUtils.h"

@interface ZBJArrayCategoryTests : XCTestCase

@end

@implementation ZBJArrayCategoryTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testEach {
    NSArray *arr = @[@"a", @"b", @"c", @"d"];
    [arr zbj_each:^(NSInteger index, id  _Nullable obj) {
        XCTAssert([obj isEqualToString:arr[index]]);
    }];
}

- (void)testMap {
    NSArray *arr = @[@"a", @"b", @"c", @"d"];
    NSArray *newArr = [arr zbj_map:^id _Nullable(id  _Nullable obj) {
        return [NSString stringWithFormat:@"zbj_%@",obj];
    }];
    XCTAssert(newArr.count == 4);
    for (int i = 0; i < arr.count; i++) {
        NSString *str = [NSString stringWithFormat:@"zbj_%@",arr[i]];
        NSString *newStr = newArr[i];
        XCTAssert([newStr isEqualToString:str]);
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
