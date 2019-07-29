//
//  UITableView+HoloTableView.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import "UITableView+HoloTableView.h"
#import "UITableView+HoloTableViewProxy.h"
#import "HoloTableViewProxy.h"
#import "HoloTableViewConfiger.h"
#import "HoloTableViewSectionMaker.h"
#import "HoloTableViewRowMaker.h"
#import "HoloTableViewRowUpdateMaker.h"
#import "HoloTableViewDataSource.h"

@implementation UITableView (HoloTableView)

// 配置 cell 与 cls 的对应关系
- (void)holo_configTableView:(void(^)(HoloTableViewConfiger *configer))block {
    HoloTableViewConfiger *configer = [HoloTableViewConfiger new];
    if (block) block(configer);
    
    NSDictionary *cellClsDict = [configer install];
    [self.proxyDataSource configCellClsDict:cellClsDict];
}

// 操作 section
- (void)holo_makeSection:(void (^)(HoloTableViewSectionMaker *))block {
    HoloTableViewSectionMaker *maker = [HoloTableViewSectionMaker new];
    if (block) block(maker);
    
    [self.proxyDataSource holo_appendSections:[maker install]];
}

- (void)holo_updateSection:(void (^)(HoloTableViewSectionMaker *))block {
    HoloTableViewSectionMaker *maker = [HoloTableViewSectionMaker new];
    if (block) block(maker);
    
    NSMutableArray *loseSections = [NSMutableArray new];
    for (HoloSection *holoSection in [maker install]) {
        HoloSection *replaceSection = [self.proxyDataSource holo_sectionWithTag:holoSection.tag];
        if (replaceSection) {
            [self.proxyDataSource holo_replaceSection:replaceSection withSection:holoSection];
        } else {
            [loseSections addObject:holoSection];
        }
    }
    if (loseSections.count > 0) {
        [self.proxyDataSource holo_appendSections:loseSections];
    }
}

- (void)holo_removeAllSection {
    [self.proxyDataSource holo_removeAllSection];
}

- (void)holo_removeSection:(NSString *)tag {
    HoloSection *holoSection = [self.proxyDataSource holo_sectionWithTag:tag];
    if (holoSection) {
        [self.proxyDataSource holo_removeSection:holoSection];
    }
}

// 操作 row
- (void)holo_makeRows:(void (^)(HoloTableViewRowMaker *))block {
    HoloTableViewRowMaker *maker = [HoloTableViewRowMaker new];
    if (block) block(maker);
    
    NSArray *holoRows = [maker install];
    if (holoRows.count <= 0) return;
    
    HoloSection *holoSection = [self.proxyDataSource holo_sectionWithTag:nil];
    if (!holoSection) {
        holoSection = [HoloSection new];
        [self.proxyDataSource holo_appendSection:holoSection];
    }
    [holoSection holo_appendRows:holoRows];
}

- (void)holo_updateRows:(void (^)(HoloTableViewRowUpdateMaker *))block {
    HoloTableViewRowUpdateMaker *maker = [HoloTableViewRowUpdateMaker new];
    if (block) block(maker);
    
    for (HoloUpdateRow *holoUpdateRow in [maker install]) {
        HoloSection *holoSection = [self.proxyDataSource holo_sectionWithRowTag:holoUpdateRow.tag];
        if (holoSection) {
            [holoSection holo_updateRow:holoUpdateRow];
        }
    }
}

- (void)holo_makeRowsInSection:(NSString *)tag block:(void (^)(HoloTableViewRowMaker *))block {
    HoloTableViewRowMaker *maker = [HoloTableViewRowMaker new];
    if (block) block(maker);
    
    NSArray *holoRows = [maker install];
    if (holoRows.count <= 0) return;

    HoloSection *holoSection = [self.proxyDataSource holo_sectionWithTag:tag];
    if (holoSection) {
        [holoSection holo_appendRows:holoRows];
    } else {
        holoSection = [HoloSection new];
        holoSection.tag = tag;
        [holoSection holo_appendRows:holoRows];
        [self.proxyDataSource holo_appendSection:holoSection];
    }
}

- (void)holo_removeAllRowsInSection:(NSString *)tag {
    HoloSection *holoSection = [self.proxyDataSource holo_sectionWithTag:tag];
    if (holoSection) {
        [holoSection holo_removeAllRows];
    }
}

- (void)holo_removeRow:(NSString *)tag {
    HoloSection *holoSection = [self.proxyDataSource holo_sectionWithRowTag:tag];
    if (holoSection) {
        [holoSection holo_removeRow:tag];
    }
}

@end
