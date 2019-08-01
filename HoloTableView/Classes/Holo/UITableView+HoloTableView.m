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
#import "HoloTableViewMacro.h"

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
    
    NSMutableArray *array = [NSMutableArray new];
    for (NSDictionary *dict in [maker install]) {
        HoloRow *updateSection = dict[@"updateSection"];
        [array addObject:updateSection];
    }
    [self.holo_proxy.holo_proxyData holo_appendSections:array];
}

- (void)holo_updateSection:(void (NS_NOESCAPE ^)(HoloTableViewSectionMaker *))block {
    HoloTableViewSectionMaker *maker = [[HoloTableViewSectionMaker alloc] initWithProxyDataSections:self.holo_proxy.holo_proxyData.holo_sections];
    if (block) block(maker);
    
    for (NSDictionary *dict in [maker install]) {
        HoloSection *targetSection = dict[@"targetSection"];
        HoloSection *updateSection = dict[@"updateSection"];
        if (!targetSection) {
            HoloLog(@"⚠️[HoloTableView] No found section with the tag: %@.", updateSection.tag);
            continue;
        }
        
        targetSection.headerHeight = updateSection.headerHeight;
        targetSection.footerHeight = updateSection.footerHeight;
        if (targetSection.header) targetSection.header = updateSection.header;
        if (targetSection.footer) targetSection.footer = updateSection.footer;
        if (targetSection.willDisplayHeaderHandler) targetSection.willDisplayHeaderHandler = updateSection.willDisplayHeaderHandler;
        if (targetSection.willDisplayFooterHandler) targetSection.willDisplayFooterHandler = updateSection.willDisplayFooterHandler;
        if (targetSection.didEndDisplayingHeaderHandler) targetSection.didEndDisplayingHeaderHandler = updateSection.didEndDisplayingHeaderHandler;
        if (targetSection.didEndDisplayingFooterHandler) targetSection.didEndDisplayingFooterHandler = updateSection.didEndDisplayingFooterHandler;
    }
}

- (void)holo_removeAllSection {
    [self.holo_proxy.holo_proxyData holo_removeAllSection];
}

- (void)holo_removeSection:(NSString *)tag {
    [self.holo_proxy.holo_proxyData holo_removeSection:tag];
}

#pragma mark - operate row
- (void)holo_makeRows:(void (NS_NOESCAPE ^)(HoloTableViewRowMaker *))block {
    HoloTableViewRowMaker *maker = [HoloTableViewRowMaker new];
    if (block) block(maker);
    
    NSArray *rows = [maker install];
    if (rows.count <= 0) return;
    
    [self.holo_proxy.holo_proxyData holo_appendRows:[maker install] toSection:nil];
}

- (void)holo_updateRows:(void (NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *))block {
    HoloTableViewUpdateRowMaker *maker = [[HoloTableViewUpdateRowMaker alloc] initWithProxyDataSections:self.holo_proxy.holo_proxyData.holo_sections];
    if (block) block(maker);
    
    for (NSDictionary *dict in [maker install]) {
        HoloRow *targetRow = dict[@"targetRow"];
        HoloRow *updateRow = dict[@"updateRow"];
        if (!targetRow) {
            HoloLog(@"⚠️[HoloTableView] No found section with the row: %@.", updateRow.tag);
            continue;
        }
        
        if (updateRow.cell) targetRow.cell = updateRow.cell;
        if (updateRow.model) targetRow.model = updateRow.model;
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

    [self.holo_proxy.holo_proxyData holo_appendRows:[maker install] toSection:tag];
}

- (void)holo_removeAllRowsInSection:(NSString *)tag {
    [self.holo_proxy.holo_proxyData holo_removeAllRowsInSection:tag];
}

- (void)holo_removeRow:(NSString *)tag {
    [self.holo_proxy.holo_proxyData holo_removeRow:tag];
}

@end
