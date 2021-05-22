//
//  HoloTableSectionInsterTest.m
//  HoloTableView_Tests
//
//  Created by 与佳期 on 2021/5/22.
//  Copyright © 2021 gonghonglou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <HoloTableView/HoloTableView.h>

@interface HoloTableSectionInsterTest : XCTestCase

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HoloTableSectionInsterTest

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

- (void)testInsertSections {
    [self.tableView holo_insertSectionsAtIndex:0 block:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"0").headerHeight(0);
        make.section(@"1").headerHeight(1);
    }];
    
    // section(@"0")
    // section(@"1")
    // section(TAG)
    
    XCTAssertEqual(self.tableView.holo_sections.count, 3);
    
    HoloTableSection *section0 = self.tableView.holo_sections[0];
    HoloTableSection *section1 = self.tableView.holo_sections[1];
    HoloTableSection *section2 = self.tableView.holo_sections[2];
    
    XCTAssertEqual(section0.tag, @"0");
    XCTAssertEqual(section1.tag, @"1");
    XCTAssertEqual(section2.tag, TAG);

    XCTAssertEqual(section0.headerHeight, 0);
    XCTAssertEqual(section1.headerHeight, 1);
    XCTAssertEqual(section2.headerHeight, CGFLOAT_MIN);
    
    
    [self.tableView holo_insertSectionsAtIndex:3 block:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"3").headerHeight(3);
        make.section(@"4").headerHeight(4);
    }];
    
    // section(@"0")
    // section(@"1")
    // section(TAG)
    // section(@"2")
    // section(@"3")
    
    XCTAssertEqual(self.tableView.holo_sections.count, 5);

    HoloTableSection *section3 = self.tableView.holo_sections[3];
    HoloTableSection *section4 = self.tableView.holo_sections[4];

    XCTAssertEqual(section3.tag, @"3");
    XCTAssertEqual(section3.headerHeight, 3);

    XCTAssertEqual(section4.tag, @"4");
    XCTAssertEqual(section4.headerHeight, 4);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
