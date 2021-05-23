//
//  HoloTableRowMakerTest.m
//  HoloTableView_Tests
//
//  Created by 与佳期 on 2021/5/20.
//  Copyright © 2021 gonghonglou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <HoloTableView/HoloTableView.h>

@interface HoloTableRowMakerTest : XCTestCase

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HoloTableRowMakerTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.tableView = [UITableView new];
    
    [self.tableView holo_makeRows:^(HoloTableViewRowMaker * _Nonnull make) {
        make.row(UITableViewCell.class)
        .model(@"model")
        .modelHandler(^id _Nonnull{
            return @"modelHandler";
        })
        
        .style(UITableViewCellStyleValue1)
        .styleHandler(^UITableViewCellStyle(id  _Nullable model) {
            return UITableViewCellStyleValue2;
        })
        
        .reuseId(@"reuseId")
        .reuseIdHandler(^NSString * _Nonnull(id  _Nullable model) {
            return @"reuseIdHandler";
        })
        
        .tag(TAG)
        
        .height(10)
        .heightHandler(^CGFloat(id  _Nullable model) {
            return 11;
        })
        
        .estimatedHeight(100)
        .estimatedHeightHandler(^CGFloat(id  _Nullable model) {
            return 101;
        })
        
        .shouldHighlight(NO)
        .shouldHighlightHandler(^BOOL(id  _Nullable model) {
            return NO;
        })
        
        .canEdit(YES)
        .canEditHandler(^BOOL(id  _Nullable model) {
            return YES;
        })
        
        .canMove(YES)
        .canMoveHandler(^BOOL(id  _Nullable model) {
            return YES;
        })
        
        .leadingSwipeActions(@[[HoloTableViewRowSwipeAction new]])
        .trailingSwipeActions(@[[HoloTableViewRowSwipeAction new]])
        
        .editingDeleteTitle(@"editingDeleteTitle")
        .editingDeleteTitleHandler(^NSString * _Nonnull(id  _Nullable model) {
            return @"editingDeleteTitleHandler";
        })
        
        .editingStyle(UITableViewCellEditingStyleDelete)
        .editingStyleHandler(^UITableViewCellEditingStyle(id  _Nullable model) {
            return UITableViewCellEditingStyleInsert;
        });
    }];
    
    
    // make rows in section
    
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

#pragma mark - make rows

- (void)testMakeRows {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCTAssertEqual(self.tableView.holo_sections.count, 3);
    
    HoloTableSection *section = self.tableView.holo_sections[0];
    
    XCTAssertEqual(section.rows.count, 1);
    
    HoloTableRow *row = section.rows[0];
    
    XCTAssertEqual(row.cell, UITableViewCell.class);
    XCTAssertEqual(row.model, @"model");
    XCTAssertEqual(row.style, UITableViewCellStyleValue1);
    XCTAssertEqual(row.reuseId, @"reuseId");
    XCTAssertEqual(row.tag, TAG);
    XCTAssertEqual(row.height, 10);
    XCTAssertEqual(row.estimatedHeight, 100);
    XCTAssertEqual(row.shouldHighlight, NO);
    XCTAssertEqual(row.canEdit, YES);
    XCTAssertEqual(row.canMove, YES);
    XCTAssertEqual(row.leadingSwipeActions.count, 1);
    XCTAssertEqual(row.trailingSwipeActions.count, 1);
    XCTAssertEqual(row.editingDeleteTitle, @"editingDeleteTitle");
    XCTAssertEqual(row.editingStyle, UITableViewCellEditingStyleDelete);
}


#pragma mark - make rows in section

- (void)testMakeRowsInSection {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [self.tableView holo_makeRowsInSection:@"section-1" block:^(HoloTableViewRowMaker * _Nonnull make) {
        make.row(UITableViewCell.class).tag(@"2").model(@"2").height(2);
    }];
    
    // section(TAG)
    // section(@"section-1")
    // section(@"section-1")
    
    XCTAssertEqual(self.tableView.holo_sections.count, 3);
    
    HoloTableSection *section0 = self.tableView.holo_sections[0];
    HoloTableSection *section1 = self.tableView.holo_sections[1];
    HoloTableSection *section2 = self.tableView.holo_sections[2];
    
    XCTAssertEqual(section0.rows.count, 1);
    XCTAssertEqual(section1.rows.count, 3); // changed
    XCTAssertEqual(section2.rows.count, 2);
    
    
    // when you make some rows to a section that doesn't already exist, will automatically create a new section.
    
    [self.tableView holo_makeRowsInSection:@"section-1000" block:^(HoloTableViewRowMaker * _Nonnull make) {
        make.row(UITableViewCell.class).tag(@"2").model(@"2").height(2);
    }];
    
    // section(TAG)
    // section(@"section-1")
    // section(@"section-1")
    // section(@"section-1000")

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
