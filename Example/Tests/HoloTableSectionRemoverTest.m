//
//  HoloTableSectionRemoverTest.m
//  HoloTableView_Tests
//
//  Created by 与佳期 on 2021/5/22.
//  Copyright © 2021 gonghonglou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <HoloTableView/HoloTableView.h>

@interface HoloTableSectionRemoverTest : XCTestCase

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HoloTableSectionRemoverTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tableView = [UITableView new];
    
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(TAG);
    }];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testRemoveSections {
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"1");
        make.section(@"2");
        make.section(@"2");
        make.section(@"3");
    }];
    
    XCTAssertEqual(self.tableView.holo_sections.count, 5);
    
    [self.tableView holo_removeSections:@[@"1", @"2"]];
    
    XCTAssertEqual(self.tableView.holo_sections.count, 2);
    
    HoloTableSection *lastSection = self.tableView.holo_sections[1];
    XCTAssertEqual(lastSection.tag, @"3");
    
    [self.tableView holo_removeAllSections];
    XCTAssertEqual(self.tableView.holo_sections.count, 0);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
