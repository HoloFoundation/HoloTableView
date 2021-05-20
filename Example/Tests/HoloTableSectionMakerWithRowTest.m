//
//  HoloTableSectionMakerWithRowTest.m
//  HoloTableView_Tests
//
//  Created by 与佳期 on 2021/5/20.
//  Copyright © 2021 gonghonglou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <HoloTableView/HoloTableView.h>

@interface HoloTableSectionMakerWithRowTest : XCTestCase

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HoloTableSectionMakerWithRowTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.tableView = [UITableView new];
    
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-0").makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            make.row(UITableViewCell.class).model(@"0").height(0);
            make.row(UITableViewCell.class).model(@"1").height(1);
        });
        
        make.section(@"section-1").makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            make.row(UITableViewCell.class).model(@"0").height(0);
            make.row(UITableViewCell.class).model(@"1").height(1);
        });
    }];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testMakeSectionsMakeRows {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-2").makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            make.row(UITableViewCell.class).model(@"0").height(0);
            make.row(UITableViewCell.class).model(@"1").height(1);
        });
    }];
    
    XCTAssertEqual(self.tableView.holo_sections.count, 3);
    
    HoloTableSection *section = self.tableView.holo_sections[2];
    HoloTableRow *row0 = section.rows[0];
    HoloTableRow *row1 = section.rows[1];

    XCTAssertEqual(section.rows.count, 2);

    XCTAssertEqual(row0.cell, UITableViewCell.class);
    XCTAssertEqual(row0.model, @"0");
    XCTAssertEqual(row0.height, 0);
    
    XCTAssertEqual(row1.cell, UITableViewCell.class);
    XCTAssertEqual(row1.model, @"1");
    XCTAssertEqual(row1.height, 1);
}

- (void)testMakeSectionsUpdateRows {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-2").updateRows(^(HoloTableViewUpdateRowMaker * _Nonnull make) {
            make.tag(@"0").height(0);
            make.tag(@"1").height(1);
        });
    }];
    
    XCTAssertEqual(self.tableView.holo_sections.count, 3);
    
    HoloTableSection *section = self.tableView.holo_sections[2];
    
    XCTAssertEqual(section.rows.count, 0);
}

- (void)testMakeSectionsRemakeRows {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-2").remakeRows(^(HoloTableViewUpdateRowMaker * _Nonnull make) {
            make.tag(@"0").height(0);
            make.tag(@"1").height(1);
        });
    }];
    
    XCTAssertEqual(self.tableView.holo_sections.count, 3);
    
    HoloTableSection *section = self.tableView.holo_sections[2];
    
    XCTAssertEqual(section.rows.count, 0);
}

- (void)testUpdateSectionsMakeRows {
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

    [self.tableView holo_updateSections:^(HoloTableViewSectionMaker * _Nonnull make) {
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

    // found a section with the tag

    [self.tableView holo_updateSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-1").makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            make.row(UITableViewCell.class).model(@"2").height(2);
            make.row(UITableViewCell.class).model(@"3").height(3);
        });
    }];

    XCTAssertEqual(self.tableView.holo_sections.count, 3);

    XCTAssertEqual(section1.rows.count, 4);

    HoloTableRow *row0 = section1.rows[0];
    HoloTableRow *row1 = section1.rows[1];
    HoloTableRow *row2 = section1.rows[2];
    HoloTableRow *row3 = section1.rows[3];

    XCTAssertEqual(row0.cell, UITableViewCell.class);
    XCTAssertEqual(row0.model, @"0");
    XCTAssertEqual(row0.height, 0);

    XCTAssertEqual(row1.cell, UITableViewCell.class);
    XCTAssertEqual(row1.model, @"1");
    XCTAssertEqual(row1.height, 1);

    XCTAssertEqual(row2.cell, UITableViewCell.class);
    XCTAssertEqual(row2.model, @"2");
    XCTAssertEqual(row2.height, 2);

    XCTAssertEqual(row3.cell, UITableViewCell.class);
    XCTAssertEqual(row3.model, @"3");
    XCTAssertEqual(row3.height, 3);
}

- (void)testUpdateSectionsUpdateRows {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
