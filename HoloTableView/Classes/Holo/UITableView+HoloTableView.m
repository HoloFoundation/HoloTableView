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
    for (HoloSection *section in [maker install]) {
        HoloSection *replaceSection = [self.proxyDataSource holo_sectionWithTag:section.tag];
        if (replaceSection) {
            [self.proxyDataSource holo_replaceSection:replaceSection withSection:section];
        } else {
            [loseSections addObject:section];
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
    HoloSection *section = [self.proxyDataSource holo_sectionWithTag:tag];
    if (section) {
        [self.proxyDataSource holo_removeSection:section];
    }
}

// 操作 row
- (void)holo_makeRows:(void (^)(HoloTableViewRowMaker *))block {
    HoloTableViewRowMaker *maker = [HoloTableViewRowMaker new];
    if (block) block(maker);
    
    NSArray *rows = [maker install];
    if (rows.count <= 0) return;
    
    HoloSection *section = [self.proxyDataSource holo_sectionWithTag:nil];
    if (!section) {
        section = [HoloSection new];
        [self.proxyDataSource holo_appendSection:section];
    }
    [section holo_appendRows:rows];
}

- (void)holo_updateRows:(void (^)(HoloTableViewRowUpdateMaker *))block {
    HoloTableViewRowUpdateMaker *maker = [HoloTableViewRowUpdateMaker new];
    if (block) block(maker);
    
    for (HoloUpdateRow *updateRow in [maker install]) {
        HoloSection *section = [self.proxyDataSource holo_sectionWithRowTag:updateRow.tag];
        if (section) {
            [section holo_updateRow:updateRow];
        }
    }
}

- (void)holo_makeRowsInSection:(NSString *)tag block:(void (^)(HoloTableViewRowMaker *))block {
    HoloTableViewRowMaker *maker = [HoloTableViewRowMaker new];
    if (block) block(maker);
    
    NSArray *rows = [maker install];
    if (rows.count <= 0) return;

    HoloSection *section = [self.proxyDataSource holo_sectionWithTag:tag];
    if (!section) {
        section = [HoloSection new];
        section.tag = tag;
        [self.proxyDataSource holo_appendSection:section];
    }
    [section holo_appendRows:rows];
}

- (void)holo_removeAllRowsInSection:(NSString *)tag {
    HoloSection *section = [self.proxyDataSource holo_sectionWithTag:tag];
    if (section) {
        [section holo_removeAllRows];
    }
}

- (void)holo_removeRow:(NSString *)tag {
    HoloSection *section = [self.proxyDataSource holo_sectionWithRowTag:tag];
    if (section) {
        [section holo_removeRow:tag];
    }
}

@end
