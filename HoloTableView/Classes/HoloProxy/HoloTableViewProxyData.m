//
//  HoloTableViewProxyData.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/29.
//

#import "HoloTableViewProxyData.h"
#import "HoloTableViewSectionMaker.h"
#import "HoloTableViewRowMaker.h"

@implementation HoloTableViewProxyData

- (NSIndexSet *)holo_insertSections:(NSArray<HoloTableSection *> *)sections anIndex:(NSInteger)index {
    if (sections.count <= 0) return nil;
    
    if (index < 0) index = 0;
    if (index > self.holo_sections.count) index = self.holo_sections.count;
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, sections.count)];
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holo_sections];
    [array insertObjects:sections atIndexes:indexSet];
    self.holo_sections = array;
    return indexSet;
}

- (NSIndexSet *)holo_removeAllSection {
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.holo_sections.count)];
    self.holo_sections = [NSArray new];
    return indexSet;
}

- (NSIndexSet *)holo_removeSections:(NSArray<NSString *> *)tags {
    NSMutableIndexSet *indexSet = [NSMutableIndexSet new];
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holo_sections];
    for (HoloTableSection *section in self.holo_sections) {
        if (section.tag && [tags containsObject:section.tag]) {
            [array removeObject:section];
            NSInteger index = [self.holo_sections indexOfObject:section];
            [indexSet addIndex:index];
        }
    }
    self.holo_sections = array;
    return [indexSet copy];
}

- (HoloTableSection *)holo_sectionWithTag:(NSString *)tag {
    for (HoloTableSection *section in self.holo_sections) {
        if ([section.tag isEqualToString:tag]) return section;
    }
    return nil;
}

- (NSArray<NSIndexPath *> *)holo_removeAllRowsInSections:(NSArray<NSString *> *)tags {
    NSMutableArray *array = [NSMutableArray new];
    for (HoloTableSection *section in self.holo_sections) {
        if (section.tag && [tags containsObject:section.tag]) {
            NSInteger sectionIndex = [self.holo_sections indexOfObject:section];
            for (NSInteger index = 0; index < section.rows.count; index++) {
                [array addObject:[NSIndexPath indexPathForRow:index inSection:sectionIndex]];
            }
            [section holo_removeAllRows];
        }
    }
    return [array copy];
}

- (NSArray<NSIndexPath *> *)holo_removeRows:(NSArray<NSString *> *)tags {
    NSMutableArray *array = [NSMutableArray new];
    for (HoloTableSection *section in self.holo_sections) {
        NSMutableArray<HoloTableRow *> *rows = [NSMutableArray new];
        for (HoloTableRow *row in section.rows) {
            if (row.tag && [tags containsObject:row.tag]) {
                NSInteger sectionIndex = [self.holo_sections indexOfObject:section];
                NSInteger rowIndex = [section.rows indexOfObject:row];
                [array addObject:[NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex]];
                [rows addObject:row];
            }
        }
        for (HoloTableRow *row in rows) {
            [section holo_removeRow:row];
        }
    }
    return [array copy];
}

#pragma mark - getter
- (NSArray<HoloTableSection *> *)holo_sections {
    if (!_holo_sections) {
        _holo_sections = [NSArray new];
    }
    return _holo_sections;
}

- (NSDictionary<NSString *, Class> *)holo_cellClsMap {
    if (!_holo_cellClsMap) {
        _holo_cellClsMap = [NSDictionary new];
    }
    return _holo_cellClsMap;
}

- (NSDictionary<NSString *,Class> *)holo_headerFooterMap {
    if (!_holo_headerFooterMap) {
        _holo_headerFooterMap = [NSDictionary new];
    }
    return _holo_headerFooterMap;
}

@end
