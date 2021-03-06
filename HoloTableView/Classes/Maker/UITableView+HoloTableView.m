//
//  UITableView+HoloTableView.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import "UITableView+HoloTableView.h"
#import "UITableView+HoloTableViewProxy.h"
#import "HoloTableRow.h"
#import "HoloTableViewMaker.h"
#import "HoloTableViewRowMaker.h"
#import "HoloTableSection.h"
#import "HoloTableViewSectionMaker.h"
#import "HoloTableViewUpdateRowMaker.h"
#import "HoloTableViewProxyData.h"
#import "HoloTableViewMacro.h"
#import "HoloTableViewProxy.h"

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
    [self _holo_operateSectionsWithMakerType:HoloTableViewSectionMakerTypeMake
                                     atIndex:NSIntegerMax
                                       block:block
                                      reload:NO
                                   animation:kNilOptions];
}

- (void)holo_makeSections:(void(NS_NOESCAPE ^)(HoloTableViewSectionMaker *make))block
      withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_operateSectionsWithMakerType:HoloTableViewSectionMakerTypeMake
                                     atIndex:NSIntegerMax
                                       block:block
                                      reload:YES
                                   animation:animation];
}

// holo_insertSections
- (void)holo_insertSectionsAtIndex:(NSInteger)index
                             block:(void (NS_NOESCAPE ^)(HoloTableViewSectionMaker *))block {
    [self _holo_operateSectionsWithMakerType:HoloTableViewSectionMakerTypeInsert
                                     atIndex:index
                                       block:block
                                      reload:NO
                                   animation:kNilOptions];
}

- (void)holo_insertSectionsAtIndex:(NSInteger)index
                             block:(void (NS_NOESCAPE ^)(HoloTableViewSectionMaker *))block
               withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_operateSectionsWithMakerType:HoloTableViewSectionMakerTypeInsert
                                     atIndex:index
                                       block:block
                                      reload:YES
                                   animation:animation];
}

// holo_updateSections
- (void)holo_updateSections:(void (NS_NOESCAPE ^)(HoloTableViewSectionMaker *))block {
    [self _holo_operateSectionsWithMakerType:HoloTableViewSectionMakerTypeUpdate
                                     atIndex:NSIntegerMax
                                       block:block
                                      reload:NO
                                   animation:kNilOptions];
}

- (void)holo_updateSections:(void (NS_NOESCAPE ^)(HoloTableViewSectionMaker *))block
        withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_operateSectionsWithMakerType:HoloTableViewSectionMakerTypeUpdate
                                     atIndex:NSIntegerMax
                                       block:block
                                      reload:YES
                                   animation:animation];
}

// holo_remakeSections
- (void)holo_remakeSections:(void(NS_NOESCAPE ^)(HoloTableViewSectionMaker *make))block {
    [self _holo_operateSectionsWithMakerType:HoloTableViewSectionMakerTypeRemake
                                     atIndex:NSIntegerMax
                                       block:block
                                      reload:NO
                                   animation:kNilOptions];
}

- (void)holo_remakeSections:(void(NS_NOESCAPE ^)(HoloTableViewSectionMaker *make))block
        withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_operateSectionsWithMakerType:HoloTableViewSectionMakerTypeRemake
                                     atIndex:NSIntegerMax
                                       block:block
                                      reload:YES
                                   animation:animation];
}

- (void)_holo_operateSectionsWithMakerType:(HoloTableViewSectionMakerType)makerType
                                   atIndex:(NSInteger)atIndex
                                     block:(void (NS_NOESCAPE ^)(HoloTableViewSectionMaker *))block
                                    reload:(BOOL)reload
                                 animation:(UITableViewRowAnimation)animation {
    HoloTableViewSectionMaker *maker = [[HoloTableViewSectionMaker alloc]
                                        initWithProxyDataSections:self.holo_proxy.proxyData.sections
                                        makerType:makerType];
    if (block) block(maker);
    
    // update data
    NSMutableArray *addArray = [NSMutableArray new];
    NSMutableIndexSet *updateIndexSet = [NSMutableIndexSet new];
    NSMutableArray *updateArray = [NSMutableArray arrayWithArray:self.holo_proxy.proxyData.sections];
    for (HoloTableViewSectionMakerModel *makerModel in [maker install]) {
        HoloTableSection *operateSection = makerModel.operateSection;
        if (!makerModel.operateIndex && (makerType == HoloTableViewSectionMakerTypeUpdate || makerType == HoloTableViewSectionMakerTypeRemake)) {
            HoloLog(@"[HoloTableView] No section found with the tag: `%@`.", operateSection.tag);
            continue;
        }
        
        if (makerModel.operateIndex) {
            // update || remake
            [updateIndexSet addIndex:makerModel.operateIndex.integerValue];
            if (makerType == HoloTableViewSectionMakerTypeRemake) {
                [updateArray replaceObjectAtIndex:makerModel.operateIndex.integerValue withObject:operateSection];
            }
        } else {
            // make || insert
            [addArray addObject:operateSection];
        }
    }
    self.holo_proxy.proxyData.sections = updateArray.copy;
    
    // update sections
    if (reload && updateIndexSet.count > 0) {
        [self reloadSections:updateIndexSet withRowAnimation:animation];
    }
    // append sections
    NSIndexSet *addIndexSet = [self _holo_insertSections:addArray anIndex:atIndex];
    if (reload && addIndexSet.count > 0) {
        [self insertSections:addIndexSet withRowAnimation:animation];
    }
}

// holo_removeAllSections
- (void)holo_removeAllSections {
    [self _holo_removeAllSectionsWithReload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_removeAllSectionsWithReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_removeAllSectionsWithReload:YES withReloadAnimation:animation];
}

- (void)_holo_removeAllSectionsWithReload:(BOOL)reload
                      withReloadAnimation:(UITableViewRowAnimation)animation {
    NSIndexSet *indexSet = [self _holo_removeAllSection];
    if (reload && indexSet.count > 0) {
        [self deleteSections:indexSet withRowAnimation:animation];
    }
}

// holo_removeSections
- (void)holo_removeSections:(NSArray<NSString *> *)tags {
    [self _holo_removeSections:tags reload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_removeSections:(NSArray<NSString *> *)tags
        withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_removeSections:tags reload:YES withReloadAnimation:animation];
}

- (void)_holo_removeSections:(NSArray<NSString *> *)tags
                      reload:(BOOL)reload
         withReloadAnimation:(UITableViewRowAnimation)animation {
    NSIndexSet *indexSet = [self _holo_removeSections:tags];
    if (indexSet.count <= 0) {
        HoloLog(@"[HoloTableView] No section found with these tags: `%@`.", tags);
        return;
    }
    if (reload) [self deleteSections:indexSet withRowAnimation:animation];
}

#pragma mark - row
// holo_makeRows
- (void)holo_makeRows:(void (NS_NOESCAPE ^)(HoloTableViewRowMaker *))block {
    [self _holo_insertRowsAtIndex:NSIntegerMax
                        inSection:nil
                            block:block
                           reload:NO
              withReloadAnimation:kNilOptions];
}

- (void)holo_makeRows:(void(NS_NOESCAPE ^)(HoloTableViewRowMaker *make))block
  withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_insertRowsAtIndex:NSIntegerMax
                        inSection:nil
                            block:block
                           reload:YES
              withReloadAnimation:animation];
}

// holo_makeRowsInSection
- (void)holo_makeRowsInSection:(NSString *)tag
                         block:(void (NS_NOESCAPE ^)(HoloTableViewRowMaker *))block {
    [self _holo_insertRowsAtIndex:NSIntegerMax
                        inSection:tag
                            block:block
                           reload:NO
              withReloadAnimation:kNilOptions];
}

- (void)holo_makeRowsInSection:(NSString *)tag
                         block:(void (NS_NOESCAPE ^)(HoloTableViewRowMaker *))block
           withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_insertRowsAtIndex:NSIntegerMax
                        inSection:tag
                            block:block
                           reload:YES
              withReloadAnimation:animation];
}

- (void)holo_insertRowsAtIndex:(NSInteger)index
                         block:(void(NS_NOESCAPE ^)(HoloTableViewRowMaker *make))block {
    [self _holo_insertRowsAtIndex:index
                        inSection:nil
                            block:block
                           reload:NO
              withReloadAnimation:kNilOptions];
}

- (void)holo_insertRowsAtIndex:(NSInteger)index
                         block:(void(NS_NOESCAPE ^)(HoloTableViewRowMaker *make))block withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_insertRowsAtIndex:index
                        inSection:nil
                            block:block
                           reload:YES withReloadAnimation:animation];
}

- (void)holo_insertRowsAtIndex:(NSInteger)index
                     inSection:(NSString *)tag
                         block:(void(NS_NOESCAPE ^)(HoloTableViewRowMaker *make))block {
    [self _holo_insertRowsAtIndex:index
                        inSection:tag
                            block:block
                           reload:NO
              withReloadAnimation:kNilOptions];
}

- (void)holo_insertRowsAtIndex:(NSInteger)index
                     inSection:(NSString *)tag
                         block:(void(NS_NOESCAPE ^)(HoloTableViewRowMaker *make))block
           withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_insertRowsAtIndex:index
                        inSection:tag
                            block:block
                           reload:YES
              withReloadAnimation:animation];
}

- (void)_holo_insertRowsAtIndex:(NSInteger)index
                      inSection:(NSString *)tag
                          block:(void (NS_NOESCAPE ^)(HoloTableViewRowMaker *))block reload:(BOOL)reload
            withReloadAnimation:(UITableViewRowAnimation)animation {
    HoloTableViewRowMaker *maker = [HoloTableViewRowMaker new];
    if (block) block(maker);
    
    // update data
    NSArray<HoloTableRow *> *rows = [maker install];
    
    // append rows
    BOOL isNewOne = NO;
    HoloTableSection *targetSection = [self _holo_sectionWithTag:tag];
    if (!targetSection) {
        targetSection = [HoloTableSection new];
        targetSection.tag = tag;
        [self _holo_insertSections:@[targetSection] anIndex:NSIntegerMax];
        isNewOne = YES;
    }
    NSIndexSet *indexSet = [self _holo_section:targetSection insertRows:rows atIndex:index];
    NSInteger sectionIndex = [self.holo_proxy.proxyData.sections indexOfObject:targetSection];
    
    // refresh rows
    if (reload) {
        if (isNewOne) {
            [self insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:animation];
        } else {
            NSMutableArray *indePathArray = [NSMutableArray new];
            [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                [indePathArray addObject:[NSIndexPath indexPathForRow:idx inSection:sectionIndex]];
            }];
            [self insertRowsAtIndexPaths:indePathArray.copy withRowAnimation:animation];
        }
    }
}

// holo_updateRows
- (void)holo_updateRows:(void (NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *))block {
    [self _holo_updateRowsWithMakerType:HoloTableViewUpdateRowMakerTypeUpdate
                                  block:block
                          targetSection:NO
                             sectionTag:nil
                                 reload:NO
                              animation:kNilOptions];
}

- (void)holo_updateRows:(void (NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *))block
    withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_updateRowsWithMakerType:HoloTableViewUpdateRowMakerTypeUpdate
                                  block:block
                          targetSection:NO
                             sectionTag:nil
                                 reload:YES
                              animation:animation];
}

- (void)holo_updateRowsInSection:(NSString *)tag
                           block:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block {
    [self _holo_updateRowsWithMakerType:HoloTableViewUpdateRowMakerTypeUpdate
                                  block:block
                          targetSection:YES
                             sectionTag:tag
                                 reload:NO
                              animation:kNilOptions];
}

- (void)holo_updateRowsInSection:(NSString *)tag
                           block:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block
             withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_updateRowsWithMakerType:HoloTableViewUpdateRowMakerTypeUpdate
                                  block:block
                          targetSection:YES
                             sectionTag:tag
                                 reload:YES
                              animation:animation];
}

// holo_remakeRows
- (void)holo_remakeRows:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block {
    [self _holo_updateRowsWithMakerType:HoloTableViewUpdateRowMakerTypeRemake
                                  block:block
                          targetSection:NO
                             sectionTag:nil
                                 reload:NO
                              animation:kNilOptions];
}

- (void)holo_remakeRows:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block
    withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_updateRowsWithMakerType:HoloTableViewUpdateRowMakerTypeRemake
                                  block:block
                          targetSection:NO
                             sectionTag:nil
                                 reload:YES
                              animation:animation];
}

- (void)holo_remakeRowsInSection:(NSString *)tag
                           block:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block {
    [self _holo_updateRowsWithMakerType:HoloTableViewUpdateRowMakerTypeRemake
                                  block:block
                          targetSection:YES
                             sectionTag:tag
                                 reload:NO
                              animation:kNilOptions];
}

- (void)holo_remakeRowsInSection:(NSString *)tag
                           block:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block
             withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_updateRowsWithMakerType:HoloTableViewUpdateRowMakerTypeRemake
                                  block:block
                          targetSection:YES
                             sectionTag:tag
                                 reload:YES
                              animation:animation];
}

- (void)_holo_updateRowsWithMakerType:(HoloTableViewUpdateRowMakerType)makerType
                                block:(void (NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *))block
                        targetSection:(BOOL)targetSection
                           sectionTag:(NSString * _Nullable)sectionTag
                               reload:(BOOL)reload
                            animation:(UITableViewRowAnimation)animation {
    HoloTableViewUpdateRowMaker *maker = [[HoloTableViewUpdateRowMaker alloc] initWithProxyDataSections:self.holo_proxy.proxyData.sections
                                                                                              makerType:makerType
                                                                                          targetSection:targetSection
                                                                                             sectionTag:sectionTag];
    if (block) block(maker);
    
    // update data
    NSArray<NSIndexPath *> *updateIndexPaths = [maker install];
    
    // refresh rows
    if (reload && updateIndexPaths.count > 0) {
        [self reloadRowsAtIndexPaths:updateIndexPaths withRowAnimation:animation];
    }
}

// holo_removeAllRowsInSections
- (void)holo_removeAllRowsInSections:(NSArray<NSString *> *)tags {
    [self _holo_removeAllRowsInSections:tags
                                 reload:NO
                    withReloadAnimation:kNilOptions];
}

- (void)holo_removeAllRowsInSections:(NSArray<NSString *> *)tags
                 withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_removeAllRowsInSections:tags
                                 reload:YES
                    withReloadAnimation:animation];
}

- (void)_holo_removeAllRowsInSections:(NSArray<NSString *> *)tags
                               reload:(BOOL)reload
                  withReloadAnimation:(UITableViewRowAnimation)animation {
    NSArray *indexPaths = [self _holo_removeAllRowsInSections:tags];
    if (reload && indexPaths.count > 0) {
        [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    }
}

// holo_removeRows
- (void)holo_removeRows:(NSArray<NSString *> *)tags {
    [self _holo_removeRows:tags reload:NO withReloadAnimation:kNilOptions];
}

- (void)holo_removeRows:(NSArray<NSString *> *)tags
    withReloadAnimation:(UITableViewRowAnimation)animation {
    [self _holo_removeRows:tags
                    reload:YES
       withReloadAnimation:animation];
}

- (void)_holo_removeRows:(NSArray<NSString *> *)tags
                  reload:(BOOL)reload
     withReloadAnimation:(UITableViewRowAnimation)animation {
    NSArray *indexPaths = [self _holo_removeRows:tags];
    if (indexPaths.count <= 0) {
        HoloLog(@"[HoloTableView] No row found with these tags: `%@`.", tags);
        return;
    }
    if (reload) [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}


#pragma mark - data

- (NSIndexSet *)_holo_insertSections:(NSArray<HoloTableSection *> *)sections anIndex:(NSInteger)index {
    if (sections.count <= 0) return [NSIndexSet new];
    
    if (index < 0) index = 0;
    if (index > self.holo_proxy.proxyData.sections.count) index = self.holo_proxy.proxyData.sections.count;
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, sections.count)];
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holo_proxy.proxyData.sections];
    [array insertObjects:sections atIndexes:indexSet];
    self.holo_proxy.proxyData.sections = array.copy;
    return indexSet;
}

- (NSIndexSet *)_holo_removeAllSection {
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.holo_proxy.proxyData.sections.count)];
    self.holo_proxy.proxyData.sections = [NSArray new];
    return indexSet;
}

- (NSIndexSet *)_holo_removeSections:(NSArray<NSString *> *)tags {
    NSMutableIndexSet *indexSet = [NSMutableIndexSet new];
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holo_proxy.proxyData.sections];
    for (HoloTableSection *section in self.holo_proxy.proxyData.sections) {
        if (section.tag && [tags containsObject:section.tag]) {
            [array removeObject:section];
            NSInteger index = [self.holo_proxy.proxyData.sections indexOfObject:section];
            [indexSet addIndex:index];
        }
    }
    self.holo_proxy.proxyData.sections = array.copy;
    return [indexSet copy];
}

- (HoloTableSection *)_holo_sectionWithTag:(NSString *)tag {
    for (HoloTableSection *section in self.holo_proxy.proxyData.sections) {
        if ([section.tag isEqualToString:tag] || (!section.tag && !tag)) return section;
    }
    return nil;
}

- (NSArray<NSIndexPath *> *)_holo_removeAllRowsInSections:(NSArray<NSString *> *)tags {
    NSMutableArray *array = [NSMutableArray new];
    for (HoloTableSection *section in self.holo_proxy.proxyData.sections) {
        if (section.tag && [tags containsObject:section.tag]) {
            NSInteger sectionIndex = [self.holo_proxy.proxyData.sections indexOfObject:section];
            for (NSInteger index = 0; index < section.rows.count; index++) {
                [array addObject:[NSIndexPath indexPathForRow:index inSection:sectionIndex]];
            }
            [section removeAllRows];
        }
    }
    return [array copy];
}

- (NSArray<NSIndexPath *> *)_holo_removeRows:(NSArray<NSString *> *)tags {
    NSMutableArray *array = [NSMutableArray new];
    for (HoloTableSection *section in self.holo_proxy.proxyData.sections) {
        NSMutableArray<HoloTableRow *> *rows = [NSMutableArray new];
        for (HoloTableRow *row in section.rows) {
            if (row.tag && [tags containsObject:row.tag]) {
                NSInteger sectionIndex = [self.holo_proxy.proxyData.sections indexOfObject:section];
                NSInteger rowIndex = [section.rows indexOfObject:row];
                [array addObject:[NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex]];
                [rows addObject:row];
            }
        }
        for (HoloTableRow *row in rows) {
            [section removeRow:row];
        }
    }
    return [array copy];
}

- (NSIndexSet *)_holo_section:(HoloTableSection *)section insertRows:(NSArray<HoloTableRow *> *)rows atIndex:(NSInteger)index {
    if (rows.count <= 0) return [NSIndexSet new];
    
    if (index < 0) index = 0;
    if (index > section.rows.count) index = section.rows.count;
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, rows.count)];
    NSMutableArray *array = [NSMutableArray arrayWithArray:section.rows];
    [array insertObjects:rows atIndexes:indexSet];
    section.rows = array.copy;
    return indexSet;
}

@end
