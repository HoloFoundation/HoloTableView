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
#import "HoloTableViewUpdateRowMaker.h"
#import "HoloTableViewDataSource.h"

@implementation UITableView (HoloTableView)

#pragma mark - configure cell class map
- (void)holo_configTableView:(void(NS_NOESCAPE ^)(HoloTableViewConfiger *configer))block  {
    HoloTableViewConfiger *configer = [HoloTableViewConfiger new];
    if (block) block(configer);
    
    NSDictionary *cellClsDict = [configer install];
    [self.proxyDataSource configCellClsDict:cellClsDict];
}

#pragma mark - operate section
- (void)holo_makeSection:(void (NS_NOESCAPE ^)(HoloTableViewSectionMaker *))block {
    HoloTableViewSectionMaker *maker = [HoloTableViewSectionMaker new];
    if (block) block(maker);
    
    [self.proxyDataSource holo_appendSections:[maker install]];
}

- (void)holo_updateSection:(void (NS_NOESCAPE ^)(HoloTableViewSectionMaker *))block {
    HoloTableViewSectionMaker *maker = [HoloTableViewSectionMaker new];
    if (block) block(maker);
    
    NSMutableArray *loseSections = [NSMutableArray new];
    for (HoloSection *section in [maker install]) {
        HoloSection *updateSection = [self.proxyDataSource holo_sectionWithTag:section.tag];
        if (updateSection) {
            [self.proxyDataSource holo_updateSection:updateSection fromSection:section];
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

#pragma mark - operate row
- (void)holo_makeRows:(void (NS_NOESCAPE ^)(HoloTableViewRowMaker *))block {
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

- (void)holo_updateRows:(void (NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *))block {
    HoloTableViewUpdateRowMaker *maker = [HoloTableViewUpdateRowMaker new];
    if (block) block(maker);
    
    for (HoloUpdateRow *updateRow in [maker install]) {
        HoloSection *section = [self.proxyDataSource holo_sectionWithRowTag:updateRow.tag];
        if (section) {
            [section holo_updateRow:updateRow];
        }
    }
}

- (void)holo_makeRowsInSection:(NSString *)tag block:(void (NS_NOESCAPE ^)(HoloTableViewRowMaker *))block {
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
