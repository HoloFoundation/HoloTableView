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
    
    NSDictionary *dict = [configer install];
    self.holo_proxy.holo_proxyData.holo_cellClsMap = dict[@"cellClsMap"];
    self.holo_proxy.holo_proxyData.holo_sectionIndexTitles = dict[@"sectionIndexTitles"];
    self.holo_proxy.holo_proxyData.holo_sectionForSectionIndexTitleHandler = dict[@"sectionForSectionIndexTitleHandler"];
}

#pragma mark - operate section
// holo_makeSections
- (void)holo_makeSections:(void (NS_NOESCAPE ^)(HoloTableViewSectionMaker *))block {
    [self _holo_makeSections:block reload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_makeSections:(void(NS_NOESCAPE ^)(HoloTableViewSectionMaker *make))block withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_makeSections:block reload:YES withReloadAnimation:animation];
}

- (void)_holo_makeSections:(void (NS_NOESCAPE ^)(HoloTableViewSectionMaker *))block reload:(BOOL)reload withReloadAnimation:(UITableViewRowAnimation)animation {
    HoloTableViewSectionMaker *maker = [HoloTableViewSectionMaker new];
    if (block) block(maker);
    
    NSMutableArray *array = [NSMutableArray new];
    for (NSDictionary *dict in [maker install]) {
        HoloSection *updateSection = dict[@"updateSection"];
        [array addObject:updateSection];
    }
    NSIndexSet *indexSet = [self.holo_proxy.holo_proxyData holo_appendSections:array];
    if (reload && indexSet.count > 0) {
        [self insertSections:indexSet withRowAnimation:animation];
    }
}

// holo_updateSections
- (void)holo_updateSections:(void (NS_NOESCAPE ^)(HoloTableViewSectionMaker *))block {
    [self _holo_updateSections:block reload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_updateSections:(void (NS_NOESCAPE ^)(HoloTableViewSectionMaker *))block withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_updateSections:block reload:YES withReloadAnimation:animation];
}

- (void)_holo_updateSections:(void (NS_NOESCAPE ^)(HoloTableViewSectionMaker *))block reload:(BOOL)reload withReloadAnimation:(UITableViewRowAnimation)animation {
    HoloTableViewSectionMaker *maker = [[HoloTableViewSectionMaker alloc] initWithProxyDataSections:self.holo_proxy.holo_proxyData.holo_sections];
    if (block) block(maker);
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet new];
    for (NSDictionary *dict in [maker install]) {
        HoloSection *targetSection = dict[@"targetSection"];
        HoloSection *updateSection = dict[@"updateSection"];
        if (!targetSection) {
            HoloLog(@"⚠️[HoloTableView] No found section with the tag: %@.", updateSection.tag);
            continue;
        }
        [indexSet addIndex:[dict[@"targetIndex"] integerValue]];
        
        targetSection.headerHeight = updateSection.headerHeight;
        targetSection.footerHeight = updateSection.footerHeight;
        if (targetSection.header) targetSection.header = updateSection.header;
        if (targetSection.footer) targetSection.footer = updateSection.footer;
        if (targetSection.willDisplayHeaderHandler) targetSection.willDisplayHeaderHandler = updateSection.willDisplayHeaderHandler;
        if (targetSection.willDisplayFooterHandler) targetSection.willDisplayFooterHandler = updateSection.willDisplayFooterHandler;
        if (targetSection.didEndDisplayingHeaderHandler) targetSection.didEndDisplayingHeaderHandler = updateSection.didEndDisplayingHeaderHandler;
        if (targetSection.didEndDisplayingFooterHandler) targetSection.didEndDisplayingFooterHandler = updateSection.didEndDisplayingFooterHandler;
    }
    
    if (reload && indexSet.count > 0) {
        [self reloadSections:indexSet withRowAnimation:animation];
    }
}

// holo_removeAllSections
- (void)holo_removeAllSections {
    [self _holo_removeAllSectionsWithReload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_removeAllSectionsWithReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_removeAllSectionsWithReload:YES withReloadAnimation:animation];
}

- (void)_holo_removeAllSectionsWithReload:(BOOL)reload withReloadAnimation:(UITableViewRowAnimation)animation {
    NSIndexSet *indexSet = [self.holo_proxy.holo_proxyData holo_removeAllSection];
    if (reload && indexSet.count > 0) {
        [self deleteSections:indexSet withRowAnimation:animation];
    }
}

// holo_removeSection
- (void)holo_removeSection:(NSString *)tag {
    [self _holo_removeSection:tag reload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_removeSection:(NSString *)tag withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_removeSection:tag reload:YES withReloadAnimation:animation];
}

- (void)_holo_removeSection:(NSString *)tag reload:(BOOL)reload withReloadAnimation:(UITableViewRowAnimation)animation {
    NSIndexSet *indexSet = [self.holo_proxy.holo_proxyData holo_removeSection:tag];
    if (reload && indexSet.count > 0) {
        [self deleteSections:indexSet withRowAnimation:animation];
    }
}

#pragma mark - operate row
// holo_makeRows
- (void)holo_makeRows:(void (NS_NOESCAPE ^)(HoloTableViewRowMaker *))block {
    [self _holo_makeRows:block reload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_makeRows:(void(NS_NOESCAPE ^)(HoloTableViewRowMaker *make))block withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_makeRows:block reload:YES withReloadAnimation:animation];
}

- (void)_holo_makeRows:(void(NS_NOESCAPE ^)(HoloTableViewRowMaker *make))block reload:(BOOL)reload withReloadAnimation:(UITableViewRowAnimation)animation {
    HoloTableViewRowMaker *maker = [HoloTableViewRowMaker new];
    if (block) block(maker);
    
    HoloSection *defultSection = [self.holo_proxy.holo_proxyData holo_sectionWithTag:nil];
    NSArray *indexPaths = [self.holo_proxy.holo_proxyData holo_appendRows:[maker install] toSection:nil];
    if (reload && indexPaths.count > 0) {
        if (!defultSection) {
            NSInteger index = self.holo_proxy.holo_proxyData.holo_sections.count - 1;
            [self insertSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:animation];
        } else {
            [self insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
        }
    }
}

// holo_updateRows
- (void)holo_updateRows:(void (NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *))block {
    [self _holo_updateRows:block reload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_updateRows:(void (NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *))block withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_updateRows:block reload:YES withReloadAnimation:animation];
}

- (void)_holo_updateRows:(void (NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *))block reload:(BOOL)reload withReloadAnimation:(UITableViewRowAnimation)animation {
    HoloTableViewUpdateRowMaker *maker = [[HoloTableViewUpdateRowMaker alloc] initWithProxyDataSections:self.holo_proxy.holo_proxyData.holo_sections];
    if (block) block(maker);
    
    NSMutableArray *indexPaths = [NSMutableArray new];
    for (NSDictionary *dict in [maker install]) {
        HoloRow *targetRow = dict[@"targetRow"];
        HoloRow *updateRow = dict[@"updateRow"];
        if (!targetRow) {
            HoloLog(@"⚠️[HoloTableView] No found row with the tag: %@.", updateRow.tag);
            continue;
        }
        [indexPaths addObject:dict[@"targetIndexPath"]];
        
        if (updateRow.cell) targetRow.cell = updateRow.cell;
        if (updateRow.model) targetRow.model = updateRow.model;
        targetRow.height = updateRow.height;
        targetRow.estimatedHeight = updateRow.estimatedHeight;
        targetRow.configSEL = updateRow.configSEL;
        targetRow.heightSEL = updateRow.heightSEL;
        targetRow.estimatedHeightSEL = updateRow.estimatedHeightSEL;
        targetRow.shouldHighlight = updateRow.shouldHighlight;
    }
    
    if (reload && indexPaths.count > 0) {
        [self reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    }
}

// holo_makeRowsInSection
- (void)holo_makeRowsInSection:(NSString *)tag block:(void (NS_NOESCAPE ^)(HoloTableViewRowMaker *))block {
    [self _holo_makeRowsInSection:tag block:block reload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_makeRowsInSection:(NSString *)tag block:(void (NS_NOESCAPE ^)(HoloTableViewRowMaker *))block withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_makeRowsInSection:tag block:block reload:YES withReloadAnimation:animation];
}

- (void)_holo_makeRowsInSection:(NSString *)tag block:(void (NS_NOESCAPE ^)(HoloTableViewRowMaker *))block reload:(BOOL)reload withReloadAnimation:(UITableViewRowAnimation)animation {
    HoloTableViewRowMaker *maker = [HoloTableViewRowMaker new];
    if (block) block(maker);
    
    HoloSection *defultSection = [self.holo_proxy.holo_proxyData holo_sectionWithTag:tag];
    NSArray *indexPaths = [self.holo_proxy.holo_proxyData holo_appendRows:[maker install] toSection:tag];
    if (reload && indexPaths.count > 0) {
        if (!defultSection) {
            NSInteger index = self.holo_proxy.holo_proxyData.holo_sections.count - 1;
            [self insertSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:animation];
        } else {
            [self insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
        }
    }
}

// holo_removeAllRowsInSection
- (void)holo_removeAllRowsInSection:(NSString *)tag {
    [self _holo_removeAllRowsInSection:tag reload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_removeAllRowsInSection:(NSString *)tag withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_removeAllRowsInSection:tag reload:YES withReloadAnimation:animation];
}

- (void)_holo_removeAllRowsInSection:(NSString *)tag reload:(BOOL)reload withReloadAnimation:(UITableViewRowAnimation)animation {
    NSArray *indexPaths = [self.holo_proxy.holo_proxyData holo_removeAllRowsInSection:tag];
    if (reload && indexPaths.count > 0) {
        [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    }
}

// holo_removeRow
- (void)holo_removeRow:(NSString *)tag {
    [self _holo_removeRow:tag reload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_removeRow:(NSString *)tag withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_removeRow:tag reload:YES withReloadAnimation:animation];
}

- (void)_holo_removeRow:(NSString *)tag reload:(BOOL)reload withReloadAnimation:(UITableViewRowAnimation)animation {
    NSArray *indexPaths = [self.holo_proxy.holo_proxyData holo_removeRow:tag];
    if (reload && indexPaths.count > 0) {
        [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    }
}

@end
