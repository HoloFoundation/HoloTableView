//
//  HoloTableSectionMakerTest.m
//  HoloTableView_Tests
//
//  Created by 与佳期 on 2021/5/20.
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
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testMakeSections {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    HoloTableSection *section = self.tableView.holo_sections.firstObject;
    
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
    
    HoloTableSection *section = self.tableView.holo_sections.firstObject;
    
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
    
    
    // Multiple sections with the same tag
    
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"1").headerHeight(1);
        make.section(@"1").headerHeight(10);
    }];
    
    HoloTableSection *section1 = self.tableView.holo_sections[1];
    HoloTableSection *section2 = self.tableView.holo_sections[2];
    
    XCTAssertEqual(section1.headerHeight, 1);
    XCTAssertEqual(section2.headerHeight, 10);
    
    [self.tableView holo_updateSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"1").headerHeight(100);
        make.section(@"1").headerHeight(101);
    }];
    
    HoloTableSection *sectionNew1 = self.tableView.holo_sections[1];
    HoloTableSection *sectionNew2 = self.tableView.holo_sections[2];
    
    XCTAssertEqual(sectionNew1.headerHeight, 101);
    XCTAssertEqual(sectionNew2.headerHeight, 10);
}

- (void)testRemakeSections {
    [self.tableView holo_remakeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(TAG);
    }];
    HoloTableSection *section = self.tableView.holo_sections.firstObject;
    
    XCTAssertNil(section.header);
    XCTAssertNil(section.footer);
    
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
    
    
    // Multiple sections with the same tag
    
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"1").headerHeight(1);
        make.section(@"1").headerHeight(10);
    }];
    
    HoloTableSection *section1 = self.tableView.holo_sections[1];
    HoloTableSection *section2 = self.tableView.holo_sections[2];
    
    XCTAssertEqual(section1.headerHeight, 1);
    XCTAssertEqual(section2.headerHeight, 10);
    
    [self.tableView holo_remakeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"1");
        make.section(@"1");
    }];
    
    HoloTableSection *sectionNew1 = self.tableView.holo_sections[1];
    HoloTableSection *sectionNew2 = self.tableView.holo_sections[2];
    XCTAssertEqual(sectionNew1.headerHeight, CGFLOAT_MIN);
    XCTAssertEqual(sectionNew2.headerHeight, 10);
}

- (void)testInsertSections {
    [self.tableView holo_insertSectionsAtIndex:0 block:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"0").headerHeight(0);
        make.section(@"1").headerHeight(1);
    }];
    
    HoloTableSection *section0 = self.tableView.holo_sections[0];
    HoloTableSection *section1 = self.tableView.holo_sections[1];
    HoloTableSection *originalSection = self.tableView.holo_sections[2];
    
    XCTAssertEqual(section0.tag, @"0");
    XCTAssertEqual(section1.tag, @"1");
    XCTAssertEqual(originalSection.tag, TAG);

    XCTAssertEqual(section0.headerHeight, 0);
    XCTAssertEqual(section1.headerHeight, 1);
    XCTAssertEqual(originalSection.headerHeight, 10);
    
    
    [self.tableView holo_insertSectionsAtIndex:3 block:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"3").headerHeight(3);
        make.section(@"4").headerHeight(4);
    }];
    
    HoloTableSection *section3 = self.tableView.holo_sections[3];
    HoloTableSection *section4 = self.tableView.holo_sections[4];

    XCTAssertEqual(section3.tag, @"3");
    XCTAssertEqual(section3.headerHeight, 3);

    XCTAssertEqual(section4.tag, @"4");
    XCTAssertEqual(section4.headerHeight, 4);
}


- (void)testRemoveSections {
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"1");
        make.section(@"2");
        make.section(@"2");
        make.section(@"3");
    }];
    XCTAssertEqual(self.tableView.holo_sections.count, 5);
    
    [self.tableView holo_removeSections:@[@"1", @"2"]];
    
    XCTAssertEqual(self.tableView.holo_sections.count, 2);
    
    HoloTableSection *lastSection = self.tableView.holo_sections.lastObject;
    XCTAssertEqual(lastSection.tag, @"3");
    
    [self.tableView holo_removeAllSections];
    XCTAssertEqual(self.tableView.holo_sections.count, 0);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
