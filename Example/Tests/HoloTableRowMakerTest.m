//
//  HoloTableRowMakerTest.m
//  HoloTableView_Tests
//
//  Created by 与佳期 on 2021/5/20.
//  Copyright © 2021 gonghonglou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <HoloTableView/HoloTableView.h>

@interface TestTableViewCell : UITableViewCell
@end
@implementation TestTableViewCell
@end

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
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testMakeRows {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    HoloTableSection *section = self.tableView.holo_sections.firstObject;
    HoloTableRow *row = section.rows.firstObject;
    
    XCTAssertEqual(row.cell, UITableViewCell.class);
    XCTAssertEqual(row.model, @"model");
    XCTAssertEqual(row.style, UITableViewCellStyleValue1);
    XCTAssertEqual(row.reuseId, @"reuseId");
    XCTAssertEqual(row.tag, TAG);
    XCTAssertEqual(row.height, 10);
    XCTAssertEqual(row.estimatedHeight, 100);
    XCTAssertEqual(row.shouldHighlight, YES);
    XCTAssertEqual(row.canEdit, YES);
    XCTAssertEqual(row.canMove, YES);
    XCTAssertEqual(row.leadingSwipeActions.count, 1);
    XCTAssertEqual(row.trailingSwipeActions.count, 1);
    XCTAssertEqual(row.editingDeleteTitle, @"editingDeleteTitle");
    XCTAssertEqual(row.editingStyle, UITableViewCellEditingStyleDelete);
}

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
    
    HoloTableSection *section = self.tableView.holo_sections.firstObject;
    HoloTableRow *row = section.rows.firstObject;
    
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
    
    
    // Multiple rows with the same tag
    
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

- (void)testRemakeRows {
    [self.tableView holo_remakeRows:^(HoloTableViewUpdateRowMaker * _Nonnull make) {
        make.tag(TAG).row(TestTableViewCell.class);
    }];
    HoloTableSection *section = self.tableView.holo_sections.firstObject;
    HoloTableRow *row = section.rows.firstObject;
    
    XCTAssertEqual(row.cell, TestTableViewCell.class);
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
    
    
    // Multiple rows with the same tag
    
    [self.tableView holo_makeRows:^(HoloTableViewRowMaker * _Nonnull make) {
        make.row(UITableViewCell.class).tag(@"1");
        make.row(UITableViewCell.class).tag(@"1");
    }];

    HoloTableRow *row1 = section.rows[1];
    HoloTableRow *row2 = section.rows[2];

    XCTAssertEqual(row1.cell, UITableViewCell.class);
    XCTAssertEqual(row2.cell, UITableViewCell.class);
    
    [self.tableView holo_remakeRows:^(HoloTableViewUpdateRowMaker * _Nonnull make) {
        make.tag(@"1").row(TestTableViewCell.class);
        make.tag(@"1").row(TestTableViewCell.class);
    }];
    
    HoloTableRow *rowNew1 = section.rows[1];
    HoloTableRow *rowNew2 = section.rows[2];
    XCTAssertEqual(rowNew1.cell, TestTableViewCell.class);
    XCTAssertEqual(rowNew2.cell, UITableViewCell.class);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
