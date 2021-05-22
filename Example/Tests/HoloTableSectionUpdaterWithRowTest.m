//
//  HoloTableSectionUpdaterWithRowTest.m
//  HoloTableView_Tests
//
//  Created by 与佳期 on 2021/5/22.
//  Copyright © 2021 gonghonglou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <HoloTableView/HoloTableView.h>

@interface HoloTableSectionUpdaterWithRowTest : XCTestCase

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HoloTableSectionUpdaterWithRowTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.tableView = [UITableView new];
    
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-0").makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            make.row(UITableViewCell.class).tag(@"0").model(@"0").height(0);
            make.row(UITableViewCell.class).tag(@"1").model(@"1").height(1);
        });
        
        make.section(@"section-1").makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            make.row(UITableViewCell.class).tag(@"0").model(@"0").height(0);
            make.row(UITableViewCell.class).tag(@"1").model(@"1").height(1);
        });
    }];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
    [self.tableView holo_updateSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-1").updateRows(^(HoloTableViewUpdateRowMaker * _Nonnull make) {
            make.tag(@"0").height(100);
        });
    }];
    
    XCTAssertEqual(self.tableView.holo_sections.count, 2);
    
    HoloTableSection *section = self.tableView.holo_sections[1];
    
    XCTAssertEqual(section.rows.count, 2);
    
    HoloTableRow *row = section.rows[0];
    
    XCTAssertEqual(row.height, 100);
    
    
    // Multiple rows with the same tag
    
    [self.tableView holo_updateSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-1").makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            make.row(UITableViewCell.class).tag(@"0").model(@"0").height(0);
            make.row(UITableViewCell.class).tag(@"1").model(@"1").height(1);
        });
    }];
    
    XCTAssertEqual(section.rows.count, 4);
    
    HoloTableRow *row0 = section.rows[0];
    HoloTableRow *row1 = section.rows[1];
    HoloTableRow *row2 = section.rows[2];
    HoloTableRow *row3 = section.rows[3];
    
    XCTAssertEqual(row0.cell, UITableViewCell.class);
    XCTAssertEqual(row0.tag, @"0");
    XCTAssertEqual(row0.model, @"0");
    XCTAssertEqual(row0.height, 100);
    
    XCTAssertEqual(row1.cell, UITableViewCell.class);
    XCTAssertEqual(row1.tag, @"1");
    XCTAssertEqual(row1.model, @"1");
    XCTAssertEqual(row1.height, 1);
    
    XCTAssertEqual(row2.cell, UITableViewCell.class);
    XCTAssertEqual(row2.tag, @"0");
    XCTAssertEqual(row2.model, @"0");
    XCTAssertEqual(row2.height, 0);
    
    XCTAssertEqual(row3.cell, UITableViewCell.class);
    XCTAssertEqual(row3.tag, @"1");
    XCTAssertEqual(row3.model, @"1");
    XCTAssertEqual(row3.height, 1);
    
    
    [self.tableView holo_updateSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-1").updateRows(^(HoloTableViewUpdateRowMaker * _Nonnull make) {
            make.tag(@"1").height(20);
        });
    }];
    
    XCTAssertEqual(row1.height, 20);
    XCTAssertEqual(row3.height, 1);
}

- (void)testUpdateSectionsRemakeRows {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCTAssertEqual(self.tableView.holo_sections.count, 2);
    
    HoloTableSection *section = self.tableView.holo_sections[1];
    
    XCTAssertEqual(section.rows.count, 2);
    
    HoloTableRow *originalRow = section.rows[0];
    
    XCTAssertEqual(originalRow.height, 0);
    
    [self.tableView holo_updateSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-1").remakeRows(^(HoloTableViewUpdateRowMaker * _Nonnull make) {
            make.tag(@"0").row(UITableViewCell.class).height(100);
        });
    }];
    
    XCTAssertEqual(section.rows.count, 2);
    
    HoloTableRow *row = section.rows[0];
    
    XCTAssertEqual(row.cell, UITableViewCell.class);
    XCTAssertEqual(row.height, 100);
    XCTAssertNil(row.model);
    
    
    // Multiple rows with the same tag

    [self.tableView holo_updateSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-1").makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            make.row(UITableViewCell.class).tag(@"0").model(@"0").height(0);
            make.row(UITableViewCell.class).tag(@"1").model(@"1").height(1);
        });
    }];

    XCTAssertEqual(section.rows.count, 4);
    
    HoloTableRow *row1 = section.rows[1];
    HoloTableRow *row3 = section.rows[3];

    XCTAssertEqual(row1.cell, UITableViewCell.class);
    XCTAssertEqual(row1.tag, @"1");
    XCTAssertEqual(row1.model, @"1");
    XCTAssertEqual(row1.height, 1);

    XCTAssertEqual(row3.cell, UITableViewCell.class);
    XCTAssertEqual(row3.tag, @"1");
    XCTAssertEqual(row3.model, @"1");
    XCTAssertEqual(row3.height, 1);


    [self.tableView holo_updateSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-1").remakeRows(^(HoloTableViewUpdateRowMaker * _Nonnull make) {
            make.tag(@"1").row(UITableViewCell.class).height(100);
        });
    }];

    HoloTableRow *row1_new = section.rows[1];
    HoloTableRow *row3_old = section.rows[3];

    XCTAssertEqual(row1_new.cell, UITableViewCell.class);
    XCTAssertEqual(row1_new.tag, @"1");
    XCTAssertEqual(row1_new.model, nil);
    XCTAssertEqual(row1_new.height, 100);

    XCTAssertEqual(row3_old.cell, UITableViewCell.class);
    XCTAssertEqual(row3_old.tag, @"1");
    XCTAssertEqual(row3_old.model, @"1");
    XCTAssertEqual(row3_old.height, 1);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
