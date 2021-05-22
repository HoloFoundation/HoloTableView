//
//  HoloTableSectionRemakerWithRowTest.m
//  HoloTableView_Tests
//
//  Created by 与佳期 on 2021/5/22.
//  Copyright © 2021 gonghonglou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <HoloTableView/HoloTableView.h>

@interface HoloTableSectionRemakerWithRowTest : XCTestCase

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HoloTableSectionRemakerWithRowTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.tableView = [UITableView new];
    
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-0").makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            make.row(UITableViewCell.class).tag(@"0").model(@"0").height(0);
            make.row(UITableViewCell.class).tag(@"1").model(@"1").height(1);
        });
        
        make.section(@"section-1").headerModel(@"headerModel").makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            make.row(UITableViewCell.class).tag(@"0").model(@"0").height(0);
            make.row(UITableViewCell.class).tag(@"1").model(@"1").height(1);
        });
    }];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testRemakeSectionsMakeRows {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    // @"section-0"
    // @"section-1"
    // @"section-1"
    
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-1").makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            make.row(UITableViewCell.class).model(@"0").height(0);
            make.row(UITableViewCell.class).model(@"1").height(1);
        });
    }];
    
    XCTAssertEqual(self.tableView.holo_sections.count, 3);
    
    // not found a section with the tag
    
    [self.tableView holo_remakeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-2").makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            make.row(UITableViewCell.class).model(@"0").height(0);
            make.row(UITableViewCell.class).model(@"1").height(1);
            make.row(UITableViewCell.class).model(@"2").height(2);
        });
    }];

    XCTAssertEqual(self.tableView.holo_sections.count, 3);

    HoloTableSection *section1 = self.tableView.holo_sections[1];
    HoloTableSection *section2 = self.tableView.holo_sections[2];

    XCTAssertEqual(section1.rows.count, 2);
    XCTAssertEqual(section2.rows.count, 2);

    XCTAssertEqual(section1.headerModel, @"headerModel");
    
    // found a section with the tag

    [self.tableView holo_remakeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-1").makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            make.row(UITableViewCell.class).model(@"2").height(2);
            make.row(UITableViewCell.class).model(@"3").height(3);
        });
    }];
    
    XCTAssertEqual(self.tableView.holo_sections.count, 3);
    
    HoloTableSection *section1_new = self.tableView.holo_sections[1];
    HoloTableSection *section2_old = self.tableView.holo_sections[2];

    XCTAssertEqual(section1_new.rows.count, 2);
    XCTAssertEqual(section2_old.rows.count, 2);
    
    XCTAssertEqual(section1_new.headerModel, nil);

    HoloTableRow *row0 = section1_new.rows[0];
    HoloTableRow *row1 = section1_new.rows[1];

    XCTAssertEqual(row0.cell, UITableViewCell.class);
    XCTAssertEqual(row0.model, @"2");
    XCTAssertEqual(row0.height, 2);

    XCTAssertEqual(row1.cell, UITableViewCell.class);
    XCTAssertEqual(row1.model, @"3");
    XCTAssertEqual(row1.height, 3);
}

- (void)testRemakeSectionsUpdateRows {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [self.tableView holo_remakeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-1").updateRows(^(HoloTableViewUpdateRowMaker * _Nonnull make) {
            make.tag(@"1").height(10);
            make.tag(@"2").height(20);
        });
    }];
    
    XCTAssertEqual(self.tableView.holo_sections.count, 2);
    
    HoloTableSection *section = self.tableView.holo_sections[1];

    XCTAssertEqual(section.rows.count, 0);
}

- (void)testRemakeSectionsRemakeRows {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [self.tableView holo_remakeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-1").remakeRows(^(HoloTableViewUpdateRowMaker * _Nonnull make) {
            make.tag(@"1").height(10);
            make.tag(@"2").height(20);
        });
    }];
    
    XCTAssertEqual(self.tableView.holo_sections.count, 2);
    
    HoloTableSection *section = self.tableView.holo_sections[1];

    XCTAssertEqual(section.rows.count, 0);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
