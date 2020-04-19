//
//  UITableView+HoloTableView.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import "UITableView+HoloTableView.h"
#import <objc/runtime.h>
#import "UITableView+HoloTableViewProxy.h"
#import "HoloTableViewProxy.h"
#import "HoloTableViewMaker.h"
#import "HoloTableViewSectionMaker.h"
#import "HoloTableViewRowMaker.h"
#import "HoloTableViewUpdateRowMaker.h"
#import "HoloTableViewProxyData.h"
#import "HoloTableViewMacro.h"

@implementation UITableView (HoloTableView)

#pragma mark - tableView
- (void)holo_makeTableView:(void (NS_NOESCAPE ^)(HoloTableViewMaker *))block {
    HoloTableViewMaker *maker = [HoloTableViewMaker new];
    if (block) block(maker);
    
    HoloTableViewModel *tableViewModel = [maker install];
    if (tableViewModel.indexTitles) self.holo_proxy.proxyData.sectionIndexTitles = tableViewModel.indexTitles;
    if (tableViewModel.indexTitlesHandler) self.holo_proxy.proxyData.sectionForSectionIndexTitleHandler = tableViewModel.indexTitlesHandler;
    
    if (tableViewModel.delegate) self.holo_proxy.delegate = tableViewModel.delegate;
    if (tableViewModel.dataSource) self.holo_proxy.dataSource = tableViewModel.dataSource;
    if (tableViewModel.scrollDelegate) self.holo_proxy.scrollDelegate = tableViewModel.scrollDelegate;
}

#pragma mark - section
// holo_makeSections
- (void)holo_makeSections:(void (NS_NOESCAPE ^)(HoloTableViewSectionMaker *))block {
    [self _holo_insertSectionsAtIndex:NSIntegerMax block:block reload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_makeSections:(void(NS_NOESCAPE ^)(HoloTableViewSectionMaker *make))block withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_insertSectionsAtIndex:NSIntegerMax block:block reload:YES withReloadAnimation:animation];
}

- (void)holo_insertSectionsAtIndex:(NSInteger)index block:(void (NS_NOESCAPE ^)(HoloTableViewSectionMaker *))block {
    [self _holo_insertSectionsAtIndex:index block:block reload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_insertSectionsAtIndex:(NSInteger)index block:(void (NS_NOESCAPE ^)(HoloTableViewSectionMaker *))block withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_insertSectionsAtIndex:index block:block reload:YES withReloadAnimation:animation];
}

- (void)_holo_insertSectionsAtIndex:(NSInteger)index block:(void (NS_NOESCAPE ^)(HoloTableViewSectionMaker *))block reload:(BOOL)reload withReloadAnimation:(UITableViewRowAnimation)animation {
    HoloTableViewSectionMaker *maker = [HoloTableViewSectionMaker new];
    if (block) block(maker);
    
    // update headerFooterMap
    NSMutableDictionary *headerFootersMap = self.holo_proxy.proxyData.headerFootersMap.mutableCopy;
    NSMutableArray *array = [NSMutableArray new];
    for (NSDictionary *dict in [maker install]) {
        HoloTableSection *updateSection = dict[kHoloUpdateSection];
        [array addObject:updateSection];
        
        if (updateSection.header) [self _registerHeaderFooter:updateSection.header withHeaderFootersMap:headerFootersMap];
        if (updateSection.footer) [self _registerHeaderFooter:updateSection.footer withHeaderFootersMap:headerFootersMap];
        
        // update cell-cls map
        NSMutableDictionary *rowsMap = self.holo_proxy.proxyData.rowsMap.mutableCopy;
        for (HoloTableRow *row in updateSection.rows) {
            if (rowsMap[row.cell]) continue;
            
            Class cls = NSClassFromString(row.cell);
            if (!cls) {
                NSString *error = [NSString stringWithFormat:@"[HoloTableView] No found a cell class with the name: %@.", row.cell];
                NSAssert(NO, error);
            }
            if (![cls.new isKindOfClass:UITableViewCell.class]) {
                NSString *error = [NSString stringWithFormat:@"[HoloTableView] The class: %@ is neither UITableViewCell nor its subclasses.", row.cell];
                NSAssert(NO, error);
            }
            rowsMap[row.cell] = cls;
        }
        self.holo_proxy.proxyData.rowsMap = rowsMap;
    }
    self.holo_proxy.proxyData.headerFootersMap = headerFootersMap;
    
    // append sections
    NSIndexSet *indexSet = [self.holo_proxy.proxyData insertSections:array anIndex:index];
    if (reload && indexSet.count > 0) {
        [self insertSections:indexSet withRowAnimation:animation];
    }
}

// holo_updateSections
- (void)holo_updateSections:(void (NS_NOESCAPE ^)(HoloTableViewSectionMaker *))block {
    [self _holo_updateSections:block isRemark:NO reload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_updateSections:(void (NS_NOESCAPE ^)(HoloTableViewSectionMaker *))block withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_updateSections:block isRemark:NO reload:YES withReloadAnimation:animation];
}

// holo_remakeSections
- (void)holo_remakeSections:(void(NS_NOESCAPE ^)(HoloTableViewSectionMaker *make))block {
    [self _holo_updateSections:block isRemark:YES reload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_remakeSections:(void(NS_NOESCAPE ^)(HoloTableViewSectionMaker *make))block withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_updateSections:block isRemark:YES reload:YES withReloadAnimation:animation];
}

- (void)_holo_updateSections:(void (NS_NOESCAPE ^)(HoloTableViewSectionMaker *))block isRemark:(BOOL)isRemark reload:(BOOL)reload withReloadAnimation:(UITableViewRowAnimation)animation {
    HoloTableViewSectionMaker *maker = [[HoloTableViewSectionMaker alloc] initWithProxyDataSections:self.holo_proxy.proxyData.sections isRemark:isRemark];
    if (block) block(maker);
    
    // update targetSection and headerFooterMap
    NSMutableDictionary *headerFootersMap = self.holo_proxy.proxyData.headerFootersMap.mutableCopy;
    NSMutableIndexSet *indexSet = [NSMutableIndexSet new];
    for (NSDictionary *dict in [maker install]) {
        HoloTableSection *targetSection = dict[kHoloTargetSection];
        HoloTableSection *updateSection = dict[kHoloUpdateSection];
        if (!targetSection) {
            HoloLog(@"[HoloTableView] No found a section with the tag: %@.", updateSection.tag);
            continue;
        }
        [indexSet addIndex:[dict[kHoloTargetIndex] integerValue]];
        
        // set value to property which it's not kind of SEL
        unsigned int outCount;
        objc_property_t * properties = class_copyPropertyList([updateSection class], &outCount);
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            const char * propertyAttr = property_getAttributes(property);
            char t = propertyAttr[1];
            if (t != ':') { // not SEL
                const char *propertyName = property_getName(property);
                NSString *propertyNameStr = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
                
                id value = [updateSection valueForKey:propertyNameStr];
                if (value) {
                    if ([propertyNameStr isEqualToString:@"header"]) {
                        targetSection.header = updateSection.header;
                        [self _registerHeaderFooter:targetSection.header withHeaderFootersMap:headerFootersMap];
                    } else if ([propertyNameStr isEqualToString:@"footer"]) {
                        targetSection.footer = updateSection.footer;
                        [self _registerHeaderFooter:targetSection.footer withHeaderFootersMap:headerFootersMap];
                    } else {
                        [targetSection setValue:value forKey:propertyNameStr];
                    }
                } else if (isRemark) {
                    [targetSection setValue:NULL forKey:propertyNameStr];
                }
            }
        }
        
        // set value of SEL
        targetSection.headerFooterConfigSEL = updateSection.headerFooterConfigSEL;
        targetSection.headerFooterHeightSEL = updateSection.headerFooterHeightSEL;
        targetSection.headerFooterEstimatedHeightSEL = updateSection.headerFooterEstimatedHeightSEL;
    }
    self.holo_proxy.proxyData.headerFootersMap = headerFootersMap;
    
    // refresh view
    if (reload && indexSet.count > 0) {
        [self reloadSections:indexSet withRowAnimation:animation];
    }
}

// _registerHeaderFooter
- (void)_registerHeaderFooter:(NSString *)headerFooter withHeaderFootersMap:(NSMutableDictionary *)headerFooterMap {
    if (headerFooterMap[headerFooter]) return;
    
    Class cls = NSClassFromString(headerFooter);
    if (!cls) {
        NSString *error = [NSString stringWithFormat:@"[HoloTableView] No found a headerFooter class with the name: %@.", headerFooter];
        NSAssert(NO, error);
    }
    if (![cls.new isKindOfClass:UITableViewHeaderFooterView.class]) {
        NSString *error = [NSString stringWithFormat:@"[HoloTableView] The class: %@ is neither UITableViewHeaderFooterView nor its subclasses.", headerFooter];
        NSAssert(NO, error);
    }
    headerFooterMap[headerFooter] = cls;
    [self registerClass:cls forHeaderFooterViewReuseIdentifier:headerFooter];
}

// holo_removeAllSections
- (void)holo_removeAllSections {
    [self _holo_removeAllSectionsWithReload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_removeAllSectionsWithReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_removeAllSectionsWithReload:YES withReloadAnimation:animation];
}

- (void)_holo_removeAllSectionsWithReload:(BOOL)reload withReloadAnimation:(UITableViewRowAnimation)animation {
    NSIndexSet *indexSet = [self.holo_proxy.proxyData removeAllSection];
    if (reload && indexSet.count > 0) {
        [self deleteSections:indexSet withRowAnimation:animation];
    }
}

// holo_removeSections
- (void)holo_removeSections:(NSArray<NSString *> *)tags {
    [self _holo_removeSections:tags reload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_removeSections:(NSArray<NSString *> *)tags withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_removeSections:tags reload:YES withReloadAnimation:animation];
}

- (void)_holo_removeSections:(NSArray<NSString *> *)tags reload:(BOOL)reload withReloadAnimation:(UITableViewRowAnimation)animation {
    NSIndexSet *indexSet = [self.holo_proxy.proxyData removeSections:tags];
    if (indexSet.count <= 0) {
        HoloLog(@"[HoloTableView] No found any section with these tags: %@.", tags);
        return;
    }
    if (reload) [self deleteSections:indexSet withRowAnimation:animation];
}

#pragma mark - row
// holo_makeRows
- (void)holo_makeRows:(void (NS_NOESCAPE ^)(HoloTableViewRowMaker *))block {
    [self _holo_insertRowsAtIndex:NSIntegerMax inSection:nil block:block reload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_makeRows:(void(NS_NOESCAPE ^)(HoloTableViewRowMaker *make))block withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_insertRowsAtIndex:NSIntegerMax inSection:nil block:block reload:YES withReloadAnimation:animation];
}

// holo_makeRowsInSection
- (void)holo_makeRowsInSection:(NSString *)tag block:(void (NS_NOESCAPE ^)(HoloTableViewRowMaker *))block {
    [self _holo_insertRowsAtIndex:NSIntegerMax inSection:tag block:block reload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_makeRowsInSection:(NSString *)tag block:(void (NS_NOESCAPE ^)(HoloTableViewRowMaker *))block withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_insertRowsAtIndex:NSIntegerMax inSection:tag block:block reload:YES withReloadAnimation:animation];
}

- (void)holo_insertRowsAtIndex:(NSInteger)index block:(void(NS_NOESCAPE ^)(HoloTableViewRowMaker *make))block {
    [self _holo_insertRowsAtIndex:index inSection:nil block:block reload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_insertRowsAtIndex:(NSInteger)index block:(void(NS_NOESCAPE ^)(HoloTableViewRowMaker *make))block withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_insertRowsAtIndex:index inSection:nil block:block reload:YES withReloadAnimation:animation];
}

- (void)holo_insertRowsAtIndex:(NSInteger)index inSection:(NSString *)tag block:(void(NS_NOESCAPE ^)(HoloTableViewRowMaker *make))block {
    [self _holo_insertRowsAtIndex:index inSection:tag block:block reload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_insertRowsAtIndex:(NSInteger)index inSection:(NSString *)tag block:(void(NS_NOESCAPE ^)(HoloTableViewRowMaker *make))block withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_insertRowsAtIndex:index inSection:tag block:block reload:YES withReloadAnimation:animation];
}

- (void)_holo_insertRowsAtIndex:(NSInteger)index inSection:(NSString *)tag block:(void (NS_NOESCAPE ^)(HoloTableViewRowMaker *))block reload:(BOOL)reload withReloadAnimation:(UITableViewRowAnimation)animation {
    HoloTableViewRowMaker *maker = [HoloTableViewRowMaker new];
    if (block) block(maker);
    
    // update cell-cls map
    NSMutableDictionary *rowsMap = self.holo_proxy.proxyData.rowsMap.mutableCopy;
    NSMutableArray *rows = [NSMutableArray new];
    for (HoloTableRow *row in [maker install]) {
        if (rowsMap[row.cell]) {
            [rows addObject:row];
            continue;
        }
        
        Class cls = NSClassFromString(row.cell);
        if (!cls) {
            NSString *error = [NSString stringWithFormat:@"[HoloTableView] No found a cell class with the name: %@.", row.cell];
            NSAssert(NO, error);
        }
        if (![cls.new isKindOfClass:UITableViewCell.class]) {
            NSString *error = [NSString stringWithFormat:@"[HoloTableView] The class: %@ is neither UITableViewCell nor its subclasses.", row.cell];
            NSAssert(NO, error);
        }
        rowsMap[row.cell] = cls;
        [rows addObject:row];
    }
    self.holo_proxy.proxyData.rowsMap = rowsMap;
    
    // append rows and refresh view
    BOOL isNewOne = NO;
    HoloTableSection *targetSection = [self.holo_proxy.proxyData sectionWithTag:tag];
    if (!targetSection) {
        targetSection = [HoloTableSection new];
        targetSection.tag = tag;
        [self.holo_proxy.proxyData insertSections:@[targetSection] anIndex:NSIntegerMax];
        isNewOne = YES;
    }
    NSIndexSet *indexSet = [targetSection insertRows:rows atIndex:index];
    NSInteger sectionIndex = [self.holo_proxy.proxyData.sections indexOfObject:targetSection];
    if (reload && isNewOne) {
        [self insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:animation];
    } else if (reload) {
        NSMutableArray *indePathArray = [NSMutableArray new];
        [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
            [indePathArray addObject:[NSIndexPath indexPathForRow:idx inSection:sectionIndex]];
        }];
        [self insertRowsAtIndexPaths:[indePathArray copy] withRowAnimation:animation];
    }
}

// holo_updateRows
- (void)holo_updateRows:(void (NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *))block {
    [self _holo_updateRows:block isRemark:NO reload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_updateRows:(void (NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *))block withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_updateRows:block isRemark:NO reload:YES withReloadAnimation:animation];
}

// holo_remakeRows
- (void)holo_remakeRows:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block {
    [self _holo_updateRows:block isRemark:YES reload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_remakeRows:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_updateRows:block isRemark:YES reload:YES withReloadAnimation:animation];
}

- (void)_holo_updateRows:(void (NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *))block isRemark:(BOOL)isRemark reload:(BOOL)reload withReloadAnimation:(UITableViewRowAnimation)animation {
    HoloTableViewUpdateRowMaker *maker = [[HoloTableViewUpdateRowMaker alloc] initWithProxyDataSections:self.holo_proxy.proxyData.sections isRemark:isRemark];
    if (block) block(maker);
    
    // update cell-cls map
    NSMutableDictionary *rowsMap = self.holo_proxy.proxyData.rowsMap.mutableCopy;
    NSMutableArray *indexPaths = [NSMutableArray new];
    for (NSDictionary *dict in [maker install]) {
        HoloTableRow *targetRow = dict[kHoloTargetRow];
        HoloTableRow *updateRow = dict[kHoloUpdateRow];
        if (!targetRow) {
            HoloLog(@"[HoloTableView] No found a row with the tag: %@.", updateRow.tag);
            continue;
        }
        [indexPaths addObject:dict[kHoloTargetIndexPath]];
        
        // set value to property which it's not kind of SEL
        unsigned int outCount;
        objc_property_t * properties = class_copyPropertyList([updateRow class], &outCount);
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            const char * propertyAttr = property_getAttributes(property);
            char t = propertyAttr[1];
            if (t != ':') { // not SEL
                const char *propertyName = property_getName(property);
                NSString *propertyNameStr = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
                id value = [updateRow valueForKey:propertyNameStr];
                if (value) {
                    if ([propertyNameStr isEqualToString:@"cell"]) {
                        if (rowsMap[updateRow.cell]) {
                            targetRow.cell = updateRow.cell;
                            continue;
                        }
                        
                        Class cls = NSClassFromString(updateRow.cell);
                        if (!cls) {
                            NSString *error = [NSString stringWithFormat:@"[HoloTableView] No found a cell class with the name: %@.", updateRow.cell];
                            NSAssert(NO, error);
                        }
                        if (![cls.new isKindOfClass:UITableViewCell.class]) {
                            NSString *error = [NSString stringWithFormat:@"[HoloTableView] The class: %@ is neither UITableViewCell nor its subclasses.", updateRow.cell];
                            NSAssert(NO, error);
                        }
                        rowsMap[updateRow.cell] = cls;
                        targetRow.cell = updateRow.cell;
                    } else {
                        [targetRow setValue:value forKey:propertyNameStr];
                    }
                } else if (isRemark) {
                    if ([propertyNameStr isEqualToString:@"cell"]) {
                        HoloLog(@"[HoloTableView] No update the cell of the row which you wish to ramark with the tag: %@.", updateRow.tag);
                    } else {
                        [targetRow setValue:NULL forKey:propertyNameStr];
                    }
                }
            }
        }
        
        // set value of SEL
        targetRow.configSEL = updateRow.configSEL;
        targetRow.heightSEL = updateRow.heightSEL;
        targetRow.estimatedHeightSEL = updateRow.estimatedHeightSEL;
    }
    self.holo_proxy.proxyData.rowsMap = rowsMap;
    
    // refresh view
    if (reload && indexPaths.count > 0) {
        [self reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    }
}

// holo_removeAllRowsInSections
- (void)holo_removeAllRowsInSections:(NSArray<NSString *> *)tags {
    [self _holo_removeAllRowsInSections:tags reload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_removeAllRowsInSections:(NSArray<NSString *> *)tags withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_removeAllRowsInSections:tags reload:YES withReloadAnimation:animation];
}

- (void)_holo_removeAllRowsInSections:(NSArray<NSString *> *)tags reload:(BOOL)reload withReloadAnimation:(UITableViewRowAnimation)animation {
    NSArray *indexPaths = [self.holo_proxy.proxyData removeAllRowsInSections:tags];
    if (reload && indexPaths.count > 0) {
        [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    }
}

// holo_removeRows
- (void)holo_removeRows:(NSArray<NSString *> *)tags {
    [self _holo_removeRows:tags reload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_removeRows:(NSArray<NSString *> *)tags withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_removeRows:tags reload:YES withReloadAnimation:animation];
}

- (void)_holo_removeRows:(NSArray<NSString *> *)tags reload:(BOOL)reload withReloadAnimation:(UITableViewRowAnimation)animation {
    NSArray *indexPaths = [self.holo_proxy.proxyData removeRows:tags];
    if (indexPaths.count <= 0) {
        HoloLog(@"[HoloTableView] No found any row with these tags: %@.", tags);
        return;
    }
    if (reload) [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

@end
