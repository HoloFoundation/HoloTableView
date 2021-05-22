//
//  HoloTableRowMakerWithTagTest.m
//  HoloTableView_Tests
//
//  Created by 与佳期 on 2021/5/22.
//  Copyright © 2021 gonghonglou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <HoloTableView/HoloTableView.h>

@interface HoloTableRowMakerWithTagTest : XCTestCase

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HoloTableRowMakerWithTagTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.tableView = [UITableView new];
    
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"0").headerHeight(100).makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            make.row(UITableViewCell.class).tag(@"0").model(@"0").height(0);
            make.row(UITableViewCell.class).tag(@"1").model(@"1").height(1);
        });
        
        make.section(@"1").headerHeight(100).makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            make.row(UITableViewCell.class).tag(@"0").model(@"0").height(0);
            make.row(UITableViewCell.class).tag(@"1").model(@"1").height(1);
        });
        
        make.section(@"1").headerHeight(100).makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            make.row(UITableViewCell.class).tag(@"0").model(@"0").height(0);
            make.row(UITableViewCell.class).tag(@"1").model(@"1").height(1);
        });
    }];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testMakeRowsInSection {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [self.tableView holo_makeRowsInSection:@"1" block:^(HoloTableViewRowMaker * _Nonnull make) {
        make.row(UITableViewCell.class).tag(@"2").model(@"2").height(2);
    }];
    
    XCTAssertEqual(self.tableView.holo_sections.count, 3);
    
    HoloTableSection *section0 = self.tableView.holo_sections[0];
    HoloTableSection *section1 = self.tableView.holo_sections[1];
    HoloTableSection *section2 = self.tableView.holo_sections[2];
    
    XCTAssertEqual(section0.rows.count, 2);
    XCTAssertEqual(section1.rows.count, 3);
    XCTAssertEqual(section2.rows.count, 2);
}

- (void)testUpdateRowsInSection {
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
