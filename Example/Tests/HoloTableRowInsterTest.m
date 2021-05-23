//
//  HoloTableRowInsterTest.m
//  HoloTableView_Tests
//
//  Created by 与佳期 on 2021/5/22.
//  Copyright © 2021 gonghonglou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <HoloTableView/HoloTableView.h>

@interface HoloTableRowInsterTest : XCTestCase

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HoloTableRowInsterTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.tableView = [UITableView new];
    
    [self.tableView holo_makeRows:^(HoloTableViewRowMaker * _Nonnull make) {
        make.row(UITableViewCell.class).tag(TAG);
    }];
    
    
    // insert rows in section
    
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-1").headerHeight(100).makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            make.row(UITableViewCell.class).tag(@"0").model(@"0").height(0);
            make.row(UITableViewCell.class).tag(@"1").model(@"1").height(1);
        });
        
        make.section(@"section-1").headerHeight(100).makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            make.row(UITableViewCell.class).tag(@"0").model(@"0").height(0);
            make.row(UITableViewCell.class).tag(@"1").model(@"1").height(1);
        });
    }];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}


#pragma mark - insert rows

- (void)testInsertRows {
    [self.tableView holo_insertRowsAtIndex:0 block:^(HoloTableViewRowMaker * _Nonnull make) {
        make.row(UITableViewCell.class).tag(@"0").height(0);
        make.row(UITableViewCell.class).tag(@"1").height(1);
    }];
    
    XCTAssertEqual(self.tableView.holo_sections.count, 3);
    
    HoloTableSection *section = self.tableView.holo_sections[0];
    
    XCTAssertEqual(section.rows.count, 3);
    
    
    HoloTableRow *row0 = section.rows[0];
    HoloTableRow *row1 = section.rows[1];
    HoloTableRow *row2 = section.rows[2];
    
    XCTAssertEqual(row0.tag, @"0");
    XCTAssertEqual(row1.tag, @"1");
    XCTAssertEqual(row2.tag, TAG);
    
    XCTAssertEqual(row0.height, 0);
    XCTAssertEqual(row1.height, 1);
    XCTAssertEqual(row2.height, CGFLOAT_MIN);
    
    [self.tableView holo_insertRowsAtIndex:3 block:^(HoloTableViewRowMaker * _Nonnull make) {
        make.row(UITableViewCell.class).tag(@"3").height(3);
        make.row(UITableViewCell.class).tag(@"4").height(4);
    }];
    
    XCTAssertEqual(section.rows.count, 5);
    
    HoloTableRow *row3 = section.rows[3];
    HoloTableRow *row4 = section.rows[4];
    
    XCTAssertEqual(row3.tag, @"3");
    XCTAssertEqual(row3.height, 3);

    XCTAssertEqual(row4.tag, @"4");
    XCTAssertEqual(row4.height, 4);
}


#pragma mark - insert rows in section

- (void)testInsertRowsInSection {
    [self.tableView holo_insertRowsAtIndex:2 inSection:@"section-1" block:^(HoloTableViewRowMaker * _Nonnull make) {
        make.row(UITableViewCell.class).tag(@"2").model(@"2").height(2);
    }];
    
    XCTAssertEqual(self.tableView.holo_sections.count, 3);
    
    HoloTableSection *section0 = self.tableView.holo_sections[0];
    HoloTableSection *section1 = self.tableView.holo_sections[1];
    HoloTableSection *section2 = self.tableView.holo_sections[2];
    
    XCTAssertEqual(section0.rows.count, 1);
    XCTAssertEqual(section1.rows.count, 3); // changed
    XCTAssertEqual(section2.rows.count, 2);
    
    
    // when you insert some rows to a section that doesn't already exist, will automatically create a new section.
    
    [self.tableView holo_insertRowsAtIndex:2 inSection:@"section-1000" block:^(HoloTableViewRowMaker * _Nonnull make) {
        make.row(UITableViewCell.class).tag(@"2").model(@"2").height(2);
    }];
    
    XCTAssertEqual(self.tableView.holo_sections.count, 4);
    
    HoloTableSection *section3 = self.tableView.holo_sections[3];
    XCTAssertEqual(section3.rows.count, 1);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
