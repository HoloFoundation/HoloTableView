//
//  HoloTableSectionMakerTest.m
//  HoloTableView_Tests
//
//  Created by 与佳期 on 2021/5/20.
//  Copyright © 2021 gonghonglou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <HoloTableView/HoloTableView.h>

@interface HoloTableSectionMakerTest : XCTestCase

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HoloTableSectionMakerTest

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
    
    
    // makeSections with rows
    
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


#pragma mark - makeSections

- (void)testMakeSections {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCTAssertEqual(self.tableView.holo_sections.count, 2);
    
    HoloTableSection *section = self.tableView.holo_sections[0];
    
    XCTAssertEqual(section.tag, TAG);
    
    XCTAssertEqual(section.header, UITableViewHeaderFooterView.class);
    XCTAssertEqual(section.footer, UITableViewHeaderFooterView.class);
    
    XCTAssertEqual(section.headerReuseId, @"headerReuseId");
    XCTAssertEqual(section.footerReuseId, @"footerReuseId");
    
    XCTAssertEqual(section.headerTitle, @"headerTitle");
    XCTAssertEqual(section.footerTitle, @"footerTitle");
   
    XCTAssertEqual(section.headerModel, @"headerModel");
    XCTAssertEqual(section.footerModel, @"footerModel");

    XCTAssertEqual(section.headerHeight, 10);
    XCTAssertEqual(section.footerHeight, 20);

    XCTAssertEqual(section.headerEstimatedHeight, 100);
    XCTAssertEqual(section.footerEstimatedHeight, 200);
}


#pragma mark - makeSections with rows

- (void)testMakeSectionsMakeRows {
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
    
    HoloTableSection *section = self.tableView.holo_sections[2];
    
    XCTAssertEqual(section.rows.count, 2);
    
    HoloTableRow *row0 = section.rows[0];
    HoloTableRow *row1 = section.rows[1];
    
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
        make.section(@"section-1").updateRows(^(HoloTableViewUpdateRowMaker * _Nonnull make) {
            make.tag(@"0").height(0);
            make.tag(@"1").height(1);
        });
    }];
    
    // section(TAG)
    // section(@"section-1")
    // section(@"section-1")
    
    XCTAssertEqual(self.tableView.holo_sections.count, 3);
    
    HoloTableSection *section = self.tableView.holo_sections[2];
    
    XCTAssertEqual(section.rows.count, 0);
}

- (void)testMakeSectionsRemakeRows {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"section-1").remakeRows(^(HoloTableViewUpdateRowMaker * _Nonnull make) {
            make.tag(@"0").height(0);
            make.tag(@"1").height(1);
        });
    }];
    
    // section(TAG)
    // section(@"section-1")
    // section(@"section-1")
    
    XCTAssertEqual(self.tableView.holo_sections.count, 3);
    
    HoloTableSection *section = self.tableView.holo_sections[2];
    
    XCTAssertEqual(section.rows.count, 0);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
