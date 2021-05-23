//
//  HoloTableRowRemoverTest.m
//  HoloTableView_Tests
//
//  Created by 与佳期 on 2021/5/22.
//  Copyright © 2021 gonghonglou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <HoloTableView/HoloTableView.h>

@interface HoloTableRowRemoverTest : XCTestCase

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HoloTableRowRemoverTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.tableView = [UITableView new];
    
    [self.tableView holo_makeRows:^(HoloTableViewRowMaker * _Nonnull make) {
        make.row(UITableViewCell.class).tag(TAG);
    }];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testRemoveRows {
    [self.tableView holo_makeRows:^(HoloTableViewRowMaker * _Nonnull make) {
        make.row(UITableViewCell.class).tag(@"1");
        make.row(UITableViewCell.class).tag(@"2");
        make.row(UITableViewCell.class).tag(@"2");
        make.row(UITableViewCell.class).tag(@"3");
    }];
    XCTAssertEqual(self.tableView.holo_sections.firstObject.rows.count, 5);
    
    [self.tableView holo_removeRows:@[@"1", @"2"]];
    
    XCTAssertEqual(self.tableView.holo_sections.firstObject.rows.count, 2);
    
    HoloTableRow *lastRow = self.tableView.holo_sections.firstObject.rows[1];
    XCTAssertEqual(lastRow.tag, @"3");

    [self.tableView holo_removeAllSections];
    XCTAssertEqual(self.tableView.holo_sections.firstObject.rows.count, 0);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
