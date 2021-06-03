//
//  HoloTableSectionRemakerTest.m
//  HoloTableView_Tests
//
//  Created by 与佳期 on 2021/5/22.
//  Copyright © 2021 gonghonglou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <HoloTableView/HoloTableView.h>

@interface HoloTableSectionRemakerTest : XCTestCase

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HoloTableSectionRemakerTest

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
    
    
    // remakeSections with rows
    
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

#pragma mark - remakeSections

- (void)testRemakeSections {
    [self.tableView holo_remakeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(TAG);
    }];
    HoloTableSection *section = self.tableView.holo_sections.firstObject;
    
    XCTAssertEqual(section.header, UITableViewHeaderFooterView.class);
    XCTAssertEqual(section.footer, UITableViewHeaderFooterView.class);
    
    XCTAssertNil(section.headerReuseId);
    XCTAssertNil(section.footerReuseId);
    
    XCTAssertNil(section.headerTitle);
    XCTAssertNil(section.footerTitle);
   
    XCTAssertNil(section.headerModel);
    XCTAssertNil(section.footerModel);

    XCTAssertEqual(section.headerHeight, CGFLOAT_MIN);
    XCTAssertEqual(section.footerHeight, CGFLOAT_MIN);

    XCTAssertEqual(section.headerEstimatedHeight, CGFLOAT_MIN);
    XCTAssertEqual(section.footerEstimatedHeight, CGFLOAT_MIN);
    
    
    // multiple sections with the same tag
    
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-1").headerHeight(1);
    }];
    
    // section(TAG)
    // section(@"section-1")
    // section(@"section-1")
    
    XCTAssertEqual(self.tableView.holo_sections.count, 3);
    
    HoloTableSection *section1 = self.tableView.holo_sections[1];
    HoloTableSection *section2 = self.tableView.holo_sections[2];
    
    XCTAssertEqual(section1.headerHeight, CGFLOAT_MIN);
    XCTAssertEqual(section2.headerHeight, 1);
    
    [self.tableView holo_remakeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-1");
        make.section(@"section-1");
    }];
    
    HoloTableSection *sectionNew1 = self.tableView.holo_sections[1];
    HoloTableSection *sectionNew2 = self.tableView.holo_sections[2];
    XCTAssertEqual(sectionNew1.headerHeight, CGFLOAT_MIN);  // changed
    XCTAssertEqual(sectionNew2.headerHeight, 1);            // not changed
}


#pragma mark - remakeSections with rows

- (void)testRemakeSectionsMakeRows {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-1").makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            make.row(UITableViewCell.class).model(@"0").height(0);
            make.row(UITableViewCell.class).model(@"1").height(1);
        });
    }];
    
    // section(TAG)
    // section(@"section-1")
    // section(@"section-1")
    
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
    
    
    // found a section with the tag

    [self.tableView holo_remakeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-1").makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            make.row(UITableViewCell.class).model(@"0").height(0);
            make.row(UITableViewCell.class).model(@"1").height(1);
            make.row(UITableViewCell.class).model(@"2").height(2);
        });
    }];
    
    XCTAssertEqual(self.tableView.holo_sections.count, 3);
    
    HoloTableSection *section1_new = self.tableView.holo_sections[1];
    HoloTableSection *section2_old = self.tableView.holo_sections[2];

    XCTAssertEqual(section1_new.rows.count, 3);
    XCTAssertEqual(section2_old.rows.count, 2);
    
    HoloTableRow *row0 = section1_new.rows[0];
    HoloTableRow *row1 = section1_new.rows[1];

    XCTAssertEqual(row0.cell, UITableViewCell.class);
    XCTAssertEqual(row0.model, @"0");
    XCTAssertEqual(row0.height, 0);

    XCTAssertEqual(row1.cell, UITableViewCell.class);
    XCTAssertEqual(row1.model, @"1");
    XCTAssertEqual(row1.height, 1);
}

- (void)testRemakeSectionsUpdateRows {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [self.tableView holo_remakeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-1").updateRows(^(HoloTableViewUpdateRowMaker * _Nonnull make) {
            make.tag(@"1").height(1000);
            make.tag(@"2").height(2000);
        });
    }];
    
    // section(TAG)
    // section(@"section-1")
    
    XCTAssertEqual(self.tableView.holo_sections.count, 2);
    
    HoloTableSection *section1 = self.tableView.holo_sections[1];
    
    XCTAssertEqual(section1.rows.count, 0);
}

- (void)testRemakeSectionsRemakeRows {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [self.tableView holo_remakeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-1").remakeRows(^(HoloTableViewUpdateRowMaker * _Nonnull make) {
            make.tag(@"1").height(1000);
            make.tag(@"2").height(2000);
        });
    }];
    
    // section(TAG)
    // section(@"section-1")
    
    XCTAssertEqual(self.tableView.holo_sections.count, 2);
    
    HoloTableSection *section1 = self.tableView.holo_sections[1];
    
    XCTAssertEqual(section1.rows.count, 0);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
