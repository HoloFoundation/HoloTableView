//
//  HoloTableRowRemakerTest.m
//  HoloTableView_Tests
//
//  Created by 与佳期 on 2021/5/22.
//  Copyright © 2021 gonghonglou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <HoloTableView/HoloTableView.h>

@interface TestTableViewCell2 : UITableViewCell
@end
@implementation TestTableViewCell2
@end


@interface HoloTableRowRemakerTest : XCTestCase

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HoloTableRowRemakerTest

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
    
    
    // remake rows in section
    
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


#pragma mark - remake rows

- (void)testRemakeRows {
    [self.tableView holo_remakeRows:^(HoloTableViewUpdateRowMaker * _Nonnull make) {
        make.tag(TAG).row(TestTableViewCell2.class);
    }];
    
    XCTAssertEqual(self.tableView.holo_sections.count, 3);
    
    HoloTableSection *section = self.tableView.holo_sections[0];
    
    XCTAssertEqual(section.rows.count, 1);
    
    HoloTableRow *row = section.rows[0];
    
    
    XCTAssertEqual(row.cell, TestTableViewCell2.class);
    XCTAssertNil(row.model);
    XCTAssertEqual(row.style, UITableViewCellStyleDefault);
    XCTAssertNil(row.reuseId);
    XCTAssertEqual(row.height, CGFLOAT_MIN);
    XCTAssertEqual(row.estimatedHeight, CGFLOAT_MIN);
    XCTAssertEqual(row.shouldHighlight, YES);
    XCTAssertEqual(row.canEdit, NO);
    XCTAssertEqual(row.canMove, NO);
    XCTAssertEqual(row.leadingSwipeActions.count, 0);
    XCTAssertEqual(row.trailingSwipeActions.count, 0);
    XCTAssertNil(row.editingDeleteTitle);
    XCTAssertEqual(row.editingStyle, UITableViewCellEditingStyleNone);
    
    
    // multiple rows with the same tag
    
    [self.tableView holo_makeRows:^(HoloTableViewRowMaker * _Nonnull make) {
        make.row(UITableViewCell.class).tag(@"1");
        make.row(UITableViewCell.class).tag(@"1");
    }];

    HoloTableRow *row1 = section.rows[1];
    HoloTableRow *row2 = section.rows[2];

    XCTAssertEqual(row1.cell, UITableViewCell.class);
    XCTAssertEqual(row2.cell, UITableViewCell.class);
    
    [self.tableView holo_remakeRows:^(HoloTableViewUpdateRowMaker * _Nonnull make) {
        make.tag(@"1").row(TestTableViewCell2.class);
        make.tag(@"1").row(TestTableViewCell2.class);
    }];
    
    HoloTableRow *rowNew1 = section.rows[1];
    HoloTableRow *rowNew2 = section.rows[2];
    XCTAssertEqual(rowNew1.cell, TestTableViewCell2.class);
    XCTAssertEqual(rowNew2.cell, UITableViewCell.class);
}


#pragma mark - remake rows in section

- (void)testRemakeRowsInSection {
    [self.tableView holo_remakeRowsInSection:@"section-1" block:^(HoloTableViewUpdateRowMaker * _Nonnull make) {
        make.tag(@"0").row(UITableViewCell.class);
    }];
    
    // section(TAG)
    // section(@"section-1")
    // section(@"section-1")
    
    XCTAssertEqual(self.tableView.holo_sections.count, 3);
    
    HoloTableSection *section0 = self.tableView.holo_sections[0];
    HoloTableSection *section1 = self.tableView.holo_sections[1];
    HoloTableSection *section2 = self.tableView.holo_sections[2];
    
    XCTAssertEqual(section0.rows.count, 1);
    XCTAssertEqual(section1.rows.count, 2);
    XCTAssertEqual(section2.rows.count, 2);
    
    HoloTableRow *row0InSection1 = section1.rows[0];
    HoloTableRow *row1InSection1 = section1.rows[1];
    
    XCTAssertEqual(row0InSection1.height, CGFLOAT_MIN); // changed
    XCTAssertNil(row0InSection1.model);                 // changed
    XCTAssertEqual(row1InSection1.height, 1);
    
    HoloTableRow *row0InSection2 = section2.rows[0];
    HoloTableRow *row1InSection2 = section2.rows[1];
    
    XCTAssertEqual(row0InSection2.height, 0);
    XCTAssertEqual(row1InSection2.height, 1);
    
    
    // when you remake some rows to a section that doesn't already exist, then ignore it.
    
    [self.tableView holo_remakeRowsInSection:@"section-1000" block:^(HoloTableViewUpdateRowMaker * _Nonnull make) {
        make.tag(@"0").row(UITableViewCell.class);
    }];
    
    // section(TAG)
    // section(@"section-1")
    // section(@"section-1")
    
    XCTAssertEqual(self.tableView.holo_sections.count, 3);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
