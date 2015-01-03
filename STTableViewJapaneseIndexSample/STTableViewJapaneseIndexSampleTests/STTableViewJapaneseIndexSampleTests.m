//
//  STTableViewJapaneseIndexSampleTests.m
//  STTableViewJapaneseIndexSampleTests
//
//  Created by EIMEI on 2015/01/02.
//  Copyright (c) 2015年 stack3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "STGrape.h"

@interface STTableViewJapaneseIndexSampleTests : XCTestCase

@end

@implementation STTableViewJapaneseIndexSampleTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testIndexes {
    NSMutableArray *grapes = [NSMutableArray arrayWithCapacity:10];
    NSArray *indexes;
    STTableViewIndex *index;
    //
    // 通常系
    //
    [grapes addObject:[[STGrape alloc] initWithName:@"メルロー"]];
    [grapes addObject:[[STGrape alloc] initWithName:@"シラー"]];
    [grapes addObject:[[STGrape alloc] initWithName:@"カベルネ・ソーヴィニヨン"]];
    [grapes addObject:[[STGrape alloc] initWithName:@"シャルドネ"]];
    [grapes addObject:[[STGrape alloc] initWithName:@"ソーヴィニヨン・ブラン"]];
    [grapes addObject:[[STGrape alloc] initWithName:@"リースリング"]];
    indexes = [STTableViewIndex generateIndexesFromObjects:grapes];
    XCTAssertEqual((NSUInteger)37, indexes.count);
    index = [STTableViewIndex findIndexByName:@"か" inArray:indexes];
    XCTAssertEqual((NSUInteger)1, index.objects.count);
    XCTAssertEqualObjects(@"カベルネ・ソーヴィニヨン", [index.objects.firstObject name]);

    index = [STTableViewIndex findIndexByName:@"さ" inArray:indexes];
    XCTAssertEqual((NSUInteger)3, index.objects.count);
    XCTAssertEqualObjects(@"シャルドネ", [[index.objects objectAtIndex:0] name]);
    XCTAssertEqualObjects(@"シラー", [[index.objects objectAtIndex:1] name]);
    XCTAssertEqualObjects(@"ソーヴィニヨン・ブラン", [[index.objects objectAtIndex:2] name]);

    index = [STTableViewIndex findIndexByName:@"ま" inArray:indexes];
    XCTAssertEqual((NSUInteger)1, index.objects.count);
    XCTAssertEqualObjects(@"メルロー", [[index.objects objectAtIndex:0] name]);

    index = [STTableViewIndex findIndexByName:@"ら" inArray:indexes];
    XCTAssertEqual((NSUInteger)1, index.objects.count);
    XCTAssertEqualObjects(@"リースリング", [[index.objects objectAtIndex:0] name]);
    //
    // 特殊系
    //
    [grapes removeAllObjects];
    [grapes addObject:[[STGrape alloc] initWithName:@"ぁ"]];
    [grapes addObject:[[STGrape alloc] initWithName:@"ぃ"]];
    [grapes addObject:[[STGrape alloc] initWithName:@"ぅ"]];
    [grapes addObject:[[STGrape alloc] initWithName:@"ぇ"]];
    [grapes addObject:[[STGrape alloc] initWithName:@"ぉ"]];
    [grapes addObject:[[STGrape alloc] initWithName:@"ヵ"]];
    [grapes addObject:[[STGrape alloc] initWithName:@"ヶ"]];
    [grapes addObject:[[STGrape alloc] initWithName:@"ゔ"]];
    [grapes addObject:[[STGrape alloc] initWithName:@"ヷ"]];
    [grapes addObject:[[STGrape alloc] initWithName:@"ヸ"]];
    [grapes addObject:[[STGrape alloc] initWithName:@"ヺ"]];
    [grapes addObject:[[STGrape alloc] initWithName:@"ゐ"]];
    [grapes addObject:[[STGrape alloc] initWithName:@"ゑ"]];

    indexes = [STTableViewIndex generateIndexesFromObjects:grapes];
    index = [STTableViewIndex findIndexByName:@"あ" inArray:indexes];
    XCTAssertEqual((NSUInteger)6, index.objects.count);
    XCTAssertEqualObjects(@"ぁ", [[index.objects objectAtIndex:0] name]);
    XCTAssertEqualObjects(@"ぃ", [[index.objects objectAtIndex:1] name]);
    XCTAssertEqualObjects(@"ぅ", [[index.objects objectAtIndex:2] name]);
    XCTAssertEqualObjects(@"ゔ", [[index.objects objectAtIndex:3] name]);
    XCTAssertEqualObjects(@"ぇ", [[index.objects objectAtIndex:4] name]);
    XCTAssertEqualObjects(@"ぉ", [[index.objects objectAtIndex:5] name]);

    indexes = [STTableViewIndex generateIndexesFromObjects:grapes];
    index = [STTableViewIndex findIndexByName:@"か" inArray:indexes];
    XCTAssertEqual((NSUInteger)2, index.objects.count);
    XCTAssertEqualObjects(@"ヵ", [[index.objects objectAtIndex:0] name]);
    XCTAssertEqualObjects(@"ヶ", [[index.objects objectAtIndex:1] name]);

    indexes = [STTableViewIndex generateIndexesFromObjects:grapes];
    index = [STTableViewIndex findIndexByName:@"わ" inArray:indexes];
    XCTAssertEqual((NSUInteger)5, index.objects.count);
    XCTAssertEqualObjects(@"ゐ", [[index.objects objectAtIndex:0] name]);
    XCTAssertEqualObjects(@"ゑ", [[index.objects objectAtIndex:1] name]);
    XCTAssertEqualObjects(@"ヷ", [[index.objects objectAtIndex:2] name]);
    XCTAssertEqualObjects(@"ヸ", [[index.objects objectAtIndex:3] name]);
    XCTAssertEqualObjects(@"ヺ", [[index.objects objectAtIndex:4] name]);
}

@end
