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
#import "HoloTableViewConfiger.h"
#import "HoloTableViewSectionMaker.h"
#import "HoloTableViewRowMaker.h"
#import "HoloTableViewUpdateRowMaker.h"
#import "HoloTableViewProxyData.h"
#import "HoloTableViewMacro.h"

@implementation UITableView (HoloTableView)

#pragma mark - configure cell class map
- (void)holo_configureTableView:(void(NS_NOESCAPE ^)(HoloTableViewConfiger *configer))block  {
    HoloTableViewConfiger *configer = [HoloTableViewConfiger new];
    if (block) block(configer);
    
    // check cellClsMap
    NSDictionary *dict = [configer install];
    NSMutableDictionary *cellClsMap = [NSMutableDictionary new];
    [dict[kHoloCellClsMap] enumerateKeysAndObjectsUsingBlock:^(NSString *cell, NSString *cls, BOOL * _Nonnull stop) {
        Class class = NSClassFromString(cls);
        if (class) {
            [self registerClass:class forCellReuseIdentifier:cls];
            cellClsMap[cell] = class;
        } else {
            HoloLog(@"⚠️[HoloTableView] No found a class with the name: %@.", cls);
        }
    }];
    self.holo_proxy.holo_proxyData.holo_cellClsMap = cellClsMap;
    self.holo_proxy.holo_proxyData.holo_sectionIndexTitles = dict[kHoloSectionIndexTitles];
    self.holo_proxy.holo_proxyData.holo_sectionForSectionIndexTitleHandler = dict[kHoloSectionForSectionIndexTitleHandler];
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
    NSMutableDictionary *headerFooterMap = self.holo_proxy.holo_proxyData.holo_headerFooterMap.mutableCopy;
    NSMutableArray *array = [NSMutableArray new];
    for (NSDictionary *dict in [maker install]) {
        HoloSection *updateSection = dict[kHoloUpdateSection];
        [array addObject:updateSection];
        
        if (updateSection.header) [self _registerHeaderFooter:updateSection.header withHeaderFooterMap:headerFooterMap];
        if (updateSection.footer) [self _registerHeaderFooter:updateSection.footer withHeaderFooterMap:headerFooterMap];
    }
    self.holo_proxy.holo_proxyData.holo_headerFooterMap = headerFooterMap;
    
    // append sections
    NSIndexSet *indexSet = [self.holo_proxy.holo_proxyData holo_insertSections:array anIndex:index];
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
    HoloTableViewSectionMaker *maker = [[HoloTableViewSectionMaker alloc] initWithProxyDataSections:self.holo_proxy.holo_proxyData.holo_sections isRemark:isRemark];
    if (block) block(maker);
    
    // update targetSection and headerFooterMap
    NSMutableDictionary *headerFooterMap = self.holo_proxy.holo_proxyData.holo_headerFooterMap.mutableCopy;
    NSMutableIndexSet *indexSet = [NSMutableIndexSet new];
    for (NSDictionary *dict in [maker install]) {
        HoloSection *targetSection = dict[kHoloTargetSection];
        HoloSection *updateSection = dict[kHoloUpdateSection];
        if (!targetSection) {
            HoloLog(@"⚠️[HoloTableView] No found a section with the tag: %@.", updateSection.tag);
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
                if ([propertyNameStr isEqualToString:@"rows"]) continue;
                
                id value = [updateSection valueForKey:propertyNameStr];
                if (value) {
                    if ([propertyNameStr isEqualToString:@"header"]) {
                        targetSection.header = updateSection.header;
                        [self _registerHeaderFooter:targetSection.header withHeaderFooterMap:headerFooterMap];
                    } else if ([propertyNameStr isEqualToString:@"footer"]) {
                        targetSection.footer = updateSection.footer;
                        [self _registerHeaderFooter:targetSection.footer withHeaderFooterMap:headerFooterMap];
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
    self.holo_proxy.holo_proxyData.holo_headerFooterMap = headerFooterMap;
    
    // refresh view
    if (reload && indexSet.count > 0) {
        [self reloadSections:indexSet withRowAnimation:animation];
    }
}

// _registerHeaderFooter
- (void)_registerHeaderFooter:(NSString *)cls withHeaderFooterMap:(NSMutableDictionary *)headerFooterMap {
    if (!headerFooterMap[cls]) {
        Class class = NSClassFromString(cls);
        if (!class) {
            HoloLog(@"⚠️[HoloTableView] No found a headerFooter class with the name: %@.", cls);
        } else if (![[class new] isKindOfClass:[UITableViewHeaderFooterView class]]) {
            HoloLog(@"⚠️[HoloTableView] The class: %@, neither UITableViewHeaderFooterView nor its subclasses.", cls);
        } else {
            [self registerClass:class forHeaderFooterViewReuseIdentifier:cls];
            headerFooterMap[cls] = class;
        }
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
    
    // update cell-cls map and register class
    NSMutableDictionary *cellClsMap = self.holo_proxy.holo_proxyData.holo_cellClsMap.mutableCopy;
    NSMutableArray *rows = [NSMutableArray new];
    for (HoloRow *row in [maker install]) {
        Class class = NSClassFromString(row.cell);
        if (!cellClsMap[row.cell] && class) {
            [self registerClass:class forCellReuseIdentifier:row.cell];
            cellClsMap[row.cell] = class;
        }
        if (cellClsMap[row.cell]) {
            [rows addObject:row];
        } else {
            HoloLog(@"⚠️[HoloTableView] No found a cell class with the name: %@.", row.cell);
        }
    }
    self.holo_proxy.holo_proxyData.holo_cellClsMap = cellClsMap;
    
    // append rows and refresh view
    BOOL isNewOne = NO;
    HoloSection *targetSection = [self.holo_proxy.holo_proxyData holo_sectionWithTag:tag];
    if (!targetSection) {
        targetSection = [HoloSection new];
        targetSection.tag = tag;
        [self.holo_proxy.holo_proxyData holo_insertSections:@[targetSection] anIndex:NSIntegerMax];
        isNewOne = YES;
    }
    NSIndexSet *indexSet = [targetSection holo_insertRows:rows atIndex:index];
    NSInteger sectionIndex = [self.holo_proxy.holo_proxyData.holo_sections indexOfObject:targetSection];
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
    HoloTableViewUpdateRowMaker *maker = [[HoloTableViewUpdateRowMaker alloc] initWithProxyDataSections:self.holo_proxy.holo_proxyData.holo_sections isRemark:isRemark];
    if (block) block(maker);
    
    // update cell-cls map and register class
    NSMutableDictionary *cellClsMap = self.holo_proxy.holo_proxyData.holo_cellClsMap.mutableCopy;
    NSMutableArray *indexPaths = [NSMutableArray new];
    for (NSDictionary *dict in [maker install]) {
        HoloRow *targetRow = dict[kHoloTargetRow];
        HoloRow *updateRow = dict[kHoloUpdateRow];
        if (!targetRow) {
            HoloLog(@"⚠️[HoloTableView] No found a row with the tag: %@.", updateRow.tag);
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
                        Class class = NSClassFromString(updateRow.cell);
                        if (!cellClsMap[updateRow.cell] && class) {
                            [self registerClass:class forCellReuseIdentifier:updateRow.cell];
                            cellClsMap[updateRow.cell] = class;
                        }
                        if (cellClsMap[updateRow.cell]) {
                            targetRow.cell = updateRow.cell;
                        } else {
                            HoloLog(@"⚠️[HoloTableView] No found a class with the name: %@.", updateRow.cell);
                        }
                    } else {
                        [targetRow setValue:value forKey:propertyNameStr];
                    }
                } else if (isRemark) {
                    if ([propertyNameStr isEqualToString:@"cell"]) {
                        HoloLog(@"⚠️[HoloTableView] No update the cell of the row which you wish to ramark with the tag: %@.", updateRow.tag);
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
    self.holo_proxy.holo_proxyData.holo_cellClsMap = cellClsMap;
    
    // refresh view
    if (reload && indexPaths.count > 0) {
        [self reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
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
