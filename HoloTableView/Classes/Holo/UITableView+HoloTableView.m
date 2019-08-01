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
#import "HoloTableViewProxyData.h"

@implementation UITableView (HoloTableView)

#pragma mark - configure cell class map
- (void)holo_configTableView:(void(NS_NOESCAPE ^)(HoloTableViewConfiger *configer))block  {
    HoloTableViewConfiger *configer = [HoloTableViewConfiger new];
    if (block) block(configer);
    
    NSDictionary *map = [configer install];
    [self.holo_proxy.holo_proxyData configCellClsMap:map];
    
    self.holo_proxy.holo_proxyData.holo_sectionIndexTitles = [configer fetchSectionIndexTitles];
    self.holo_proxy.holo_proxyData.holo_sectionForSectionIndexTitleHandler = [configer fetchSectionForSectionIndexTitleHandler];
}

#pragma mark - operate section
- (void)holo_makeSection:(void (NS_NOESCAPE ^)(HoloTableViewSectionMaker *))block {
    HoloTableViewSectionMaker *maker = [HoloTableViewSectionMaker new];
    if (block) block(maker);
    
    [self.holo_proxy.holo_proxyData holo_appendSections:[maker install]];
}

- (void)holo_updateSection:(void (NS_NOESCAPE ^)(HoloTableViewSectionMaker *))block {
    HoloTableViewSectionMaker *maker = [HoloTableViewSectionMaker new];
    if (block) block(maker);
    
    NSMutableArray *loseSections = [NSMutableArray new];
    for (HoloSection *section in [maker install]) {
        HoloSection *updateSection = [self.holo_proxy.holo_proxyData holo_sectionWithTag:section.tag];
        if (updateSection) {
            [self.holo_proxy.holo_proxyData holo_updateSection:updateSection fromSection:section];
        } else {
            [loseSections addObject:section];
        }
    }
    if (loseSections.count > 0) {
        [self.holo_proxy.holo_proxyData holo_appendSections:loseSections];
    }
}

- (void)holo_removeAllSection {
    [self.holo_proxy.holo_proxyData holo_removeAllSection];
}

- (void)holo_removeSection:(NSString *)tag {
    HoloSection *section = [self.holo_proxy.holo_proxyData holo_sectionWithTag:tag];
    if (section) {
        [self.holo_proxy.holo_proxyData holo_removeSection:section];
    }
}

#pragma mark - operate row
- (void)holo_makeRows:(void (NS_NOESCAPE ^)(HoloTableViewRowMaker *))block {
    HoloTableViewRowMaker *maker = [HoloTableViewRowMaker new];
    if (block) block(maker);
    
    NSArray *rows = [maker install];
    if (rows.count <= 0) return;
    
    HoloSection *section = [self.holo_proxy.holo_proxyData holo_sectionWithTag:nil];
    if (!section) {
        section = [HoloSection new];
        [self.holo_proxy.holo_proxyData holo_appendSection:section];
    }
    [section holo_appendRows:rows];
}

- (void)holo_updateRows:(void (NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *))block {
    HoloTableViewUpdateRowMaker *maker = [[HoloTableViewUpdateRowMaker alloc] initWithProxyDataSections:self.holo_proxy.holo_proxyData.holo_sections];
    if (block) block(maker);
    
    for (NSDictionary *dict in [maker install]) {
        HoloRow *targetRow = dict[@"targetRow"];
        HoloRow *updateRow = dict[@"updateRow"];
        
        targetRow.cell = updateRow.cell;
        targetRow.model = updateRow.model;
        targetRow.height = updateRow.height;
        targetRow.estimatedHeight = updateRow.estimatedHeight;
        targetRow.configSEL = updateRow.configSEL;
        targetRow.heightSEL = updateRow.heightSEL;
        targetRow.estimatedHeightSEL = updateRow.estimatedHeightSEL;
        targetRow.shouldHighlight = updateRow.shouldHighlight;
    }
}

- (void)holo_makeRowsInSection:(NSString *)tag block:(void (NS_NOESCAPE ^)(HoloTableViewRowMaker *))block {
    HoloTableViewRowMaker *maker = [HoloTableViewRowMaker new];
    if (block) block(maker);
    
    NSArray *rows = [maker install];
    if (rows.count <= 0) return;

    HoloSection *section = [self.holo_proxy.holo_proxyData holo_sectionWithTag:tag];
    if (!section) {
        section = [HoloSection new];
        section.tag = tag;
        [self.holo_proxy.holo_proxyData holo_appendSection:section];
    }
    [section holo_appendRows:rows];
}

- (void)holo_removeAllRowsInSection:(NSString *)tag {
    HoloSection *section = [self.holo_proxy.holo_proxyData holo_sectionWithTag:tag];
    if (section) {
        [section holo_removeAllRows];
    }
}

- (void)holo_removeRow:(NSString *)tag {
    [self.holo_proxy.holo_proxyData holo_removeRow:tag];
}

@end
