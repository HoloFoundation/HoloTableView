//
//  HoloTableSectionUpdaterTest.m
//  HoloTableView_Tests
//
//  Created by 与佳期 on 2021/5/22.
//  Copyright © 2021 gonghonglou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <HoloTableView/HoloTableView.h>

@interface TestHeaderView : UITableViewHeaderFooterView
@end
@implementation TestHeaderView
@end

@interface TestFooterView : UITableViewHeaderFooterView
@end
@implementation TestFooterView
@end


@interface HoloTableSectionUpdaterTest : XCTestCase

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HoloTableSectionUpdaterTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tableView = [UITableView new];
    
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(TAG)
        .header(UITableViewHeaderFooterView.class)
        .footer(UITableViewHeaderFooterView.class)
        
        .headerReuseId(@"headerReuseId")
        .headerReuseIdHandler(^NSString * _Nonnull(id  _Nullable model) {
            return @"headerReuseIdHandler";
        })
        .footerReuseId(@"footerReuseId")
        .footerReuseIdHandler(^NSString * _Nonnull(id  _Nullable model) {
            return @"footerReuseIdHandler";
        })
        
        .headerTitle(@"headerTitle")
        .headerTitleHandler(^NSString * _Nonnull{
            return @"headerTitleHandler";
        })
        .footerTitle(@"footerTitle")
        .footerTitleHandler(^NSString * _Nonnull{
            return @"footerTitleHandler";
        })
        
        .headerModel(@"headerModel")
        .headerModelHandler(^id _Nonnull{
            return @"headerModelHandler";
        })
        .footerModel(@"footerModel")
        .footerModelHandler(^id _Nonnull{
            return @"footerModelHandler";
        })
        
        .headerHeight(10)
        .headerHeightHandler(^CGFloat(id  _Nullable model) {
            return 11;
        })
        .footerHeight(20)
        .footerHeightHandler(^CGFloat(id  _Nullable model) {
            return 21;
        })
        
        .headerEstimatedHeight(100)
        .headerEstimatedHeightHandler(^CGFloat(id  _Nullable model) {
            return 101;
        })
        .footerEstimatedHeight(200)
        .footerEstimatedHeightHandler(^CGFloat(id  _Nullable model) {
            return 201;
        });
    }];
    
    
    // updateSections with rows
    
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-1").makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            make.row(UITableViewCell.class).tag(@"0").model(@"0").height(0);
            make.row(UITableViewCell.class).tag(@"1").model(@"1").height(1);
        });
    }];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}


#pragma mark - updateSections

- (void)testUpdateSections {
    [self.tableView holo_updateSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(TAG)
        .header(TestHeaderView.class)
        .footer(TestFooterView.class)
        
        .headerReuseId(@"headerReuseId-new")
        .footerReuseId(@"footerReuseId-new")
        
        .headerTitle(@"headerTitle-new")
        .footerTitle(@"footerTitle-new")
        
        .headerModel(@"headerModel-new")
        .footerModel(@"footerModel-new")
        
        .headerHeight(101)
        .footerHeight(201)
        
        .headerEstimatedHeight(1001)
        .footerEstimatedHeight(2001);
    }];
    
    XCTAssertEqual(self.tableView.holo_sections.count, 2);
    
    HoloTableSection *section = self.tableView.holo_sections[0];
    
    XCTAssertEqual(section.header, TestHeaderView.class);
    XCTAssertEqual(section.footer, TestFooterView.class);
    
    XCTAssertEqual(section.headerReuseId, @"headerReuseId-new");
    XCTAssertEqual(section.footerReuseId, @"footerReuseId-new");
    
    XCTAssertEqual(section.headerTitle, @"headerTitle-new");
    XCTAssertEqual(section.footerTitle, @"footerTitle-new");
   
    XCTAssertEqual(section.headerModel, @"headerModel-new");
    XCTAssertEqual(section.footerModel, @"footerModel-new");

    XCTAssertEqual(section.headerHeight, 101);
    XCTAssertEqual(section.footerHeight, 201);

    XCTAssertEqual(section.headerEstimatedHeight, 1001);
    XCTAssertEqual(section.footerEstimatedHeight, 2001);
    
    
    // multiple sections with the same tag
    
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-1").headerHeight(10);
    }];
    
    // section(@"TAG")
    // section(@"section-1")
    // section(@"section-1")

    XCTAssertEqual(self.tableView.holo_sections.count, 3);
    
    HoloTableSection *section1 = self.tableView.holo_sections[1];
    HoloTableSection *section2 = self.tableView.holo_sections[2];
    
    XCTAssertEqual(section1.headerHeight, CGFLOAT_MIN);
    XCTAssertEqual(section2.headerHeight, 10);
    
    [self.tableView holo_updateSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-1").headerHeight(100);
        make.section(@"section-1").headerHeight(101);
    }];
    
    XCTAssertEqual(section1.headerHeight, 101); // changed
    XCTAssertEqual(section2.headerHeight, 10);  // not changed
}


#pragma mark - updateSections with rows

- (void)testUpdateSectionsMakeRows {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-1").makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            make.row(UITableViewCell.class).model(@"0").height(0);
            make.row(UITableViewCell.class).model(@"1").height(1);
        });
    }];
    
    // section(@"TAG")
    // section(@"section-1")
    // section(@"section-1")
    
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
    
    // section(@"TAG")
    // section(@"section-1")
    // section(@"section-1")

    XCTAssertEqual(self.tableView.holo_sections.count, 3);

    XCTAssertEqual(section1.rows.count, 4);
    XCTAssertEqual(section2.rows.count, 2);

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
    
    // section(TAG)
    // section(@"section-1")
    
    XCTAssertEqual(self.tableView.holo_sections.count, 2);
    
    HoloTableSection *section = self.tableView.holo_sections[1];
    
    XCTAssertEqual(section.rows.count, 2);
    
    HoloTableRow *row = section.rows[0];
    
    XCTAssertEqual(row.height, 100);
    
    
    // multiple rows with the same tag
    
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
            make.tag(@"1").height(2000);
        });
    }];
    
    XCTAssertEqual(row0.height, 100);
    XCTAssertEqual(row1.height, 2000); // changed
    XCTAssertEqual(row2.height, 0);
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
            make.tag(@"0").row(UITableViewCell.class).height(1000);
        });
    }];
    
    XCTAssertEqual(section.rows.count, 2);
    
    HoloTableRow *row = section.rows[0];
    
    XCTAssertEqual(row.cell, UITableViewCell.class);
    XCTAssertEqual(row.height, 1000);
    XCTAssertEqual(row.estimatedHeight, CGFLOAT_MIN);
    XCTAssertNil(row.model);
    
    
    // multiple rows with the same tag

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
            make.tag(@"1").row(UITableViewCell.class).height(1000);
        });
    }];

    HoloTableRow *row1_new = section.rows[1];
    HoloTableRow *row3_old = section.rows[3];

    XCTAssertEqual(row1_new.cell, UITableViewCell.class);
    XCTAssertEqual(row1_new.height, 1000);
    XCTAssertEqual(row1_new.estimatedHeight, CGFLOAT_MIN);
    XCTAssertNil(row1_new.model);
    
    XCTAssertEqual(row3_old.cell, UITableViewCell.class);
    XCTAssertEqual(row3_old.height, 1);
    XCTAssertEqual(row3_old.model, @"1");
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
