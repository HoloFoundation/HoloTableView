//
//  HoloTableRowUpdaterTest.m
//  HoloTableView_Tests
//
//  Created by 与佳期 on 2021/5/22.
//  Copyright © 2021 gonghonglou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <HoloTableView/HoloTableView.h>

@interface TestTableViewCell : UITableViewCell
@end
@implementation TestTableViewCell
@end


@interface HoloTableRowUpdaterTest : XCTestCase

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HoloTableRowUpdaterTest

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
        
        .shouldHighlight(YES)
        .shouldHighlightHandler(^BOOL(id  _Nullable model) {
            return YES;
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
    
    
    // update rows in section
    
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

#pragma mark - update rows

- (void)testUpdateRows {
    [self.tableView holo_updateRows:^(HoloTableViewUpdateRowMaker * _Nonnull make) {
        make.tag(TAG)
        .row(TestTableViewCell.class)
        .model(@"model-new")
        .style(UITableViewCellStyleValue2)
        .reuseId(@"reuseId-new")
        .height(101)
        .estimatedHeight(1001)
        .shouldHighlight(NO)
        .canEdit(NO)
        .canMove(NO)
        .leadingSwipeActions(@[])
        .trailingSwipeActions(@[])
        .editingDeleteTitle(@"editingDeleteTitle-new")
        .editingStyle(UITableViewCellEditingStyleInsert);
    }];
    
    XCTAssertEqual(self.tableView.holo_sections.count, 3);
    
    HoloTableSection *section = self.tableView.holo_sections[0];
    
    XCTAssertEqual(section.rows.count, 1);
    
    HoloTableRow *row = section.rows[0];
    
        
    XCTAssertEqual(row.cell, TestTableViewCell.class);
    XCTAssertEqual(row.model, @"model-new");
    XCTAssertEqual(row.style, UITableViewCellStyleValue2);
    XCTAssertEqual(row.reuseId, @"reuseId-new");
    XCTAssertEqual(row.height, 101);
    XCTAssertEqual(row.estimatedHeight, 1001);
    XCTAssertEqual(row.shouldHighlight, NO);
    XCTAssertEqual(row.canEdit, NO);
    XCTAssertEqual(row.canMove, NO);
    XCTAssertEqual(row.leadingSwipeActions.count, 0);
    XCTAssertEqual(row.trailingSwipeActions.count, 0);
    XCTAssertEqual(row.editingDeleteTitle, @"editingDeleteTitle-new");
    XCTAssertEqual(row.editingStyle, UITableViewCellEditingStyleInsert);
    
    
    // multiple rows with the same tag
    
    [self.tableView holo_makeRows:^(HoloTableViewRowMaker * _Nonnull make) {
        make.row(UITableViewCell.class).tag(@"1").height(1);
        make.row(UITableViewCell.class).tag(@"1").height(10);
    }];
    
    HoloTableRow *row1 = section.rows[1];
    HoloTableRow *row2 = section.rows[2];

    XCTAssertEqual(row1.height, 1);
    XCTAssertEqual(row2.height, 10);
    
    [self.tableView holo_updateRows:^(HoloTableViewUpdateRowMaker * _Nonnull make) {
        make.tag(@"1").height(100);
        make.tag(@"1").height(101);
    }];
    
    HoloTableRow *rowNew1 = section.rows[1];
    HoloTableRow *rowNew2 = section.rows[2];

    XCTAssertEqual(rowNew1.height, 101);
    XCTAssertEqual(rowNew2.height, 10);
}

#pragma mark - update rows in section

- (void)testUpdateRowsInSection {
    [self.tableView holo_updateRowsInSection:@"section-1" block:^(HoloTableViewUpdateRowMaker * _Nonnull make) {
        make.tag(@"0").height(1000);
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
    
    XCTAssertEqual(row0InSection1.height, 1000); // changed
    XCTAssertEqual(row1InSection1.height, 1);
    
    HoloTableRow *row0InSection2 = section2.rows[0];
    HoloTableRow *row1InSection2 = section2.rows[1];
    
    XCTAssertEqual(row0InSection2.height, 0);
    XCTAssertEqual(row1InSection2.height, 1);

    
    // when you update some rows to a section that doesn't already exist, then ignore it.

    [self.tableView holo_updateRowsInSection:@"section-1000" block:^(HoloTableViewUpdateRowMaker * _Nonnull make) {
        make.tag(@"1").height(1000);
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
