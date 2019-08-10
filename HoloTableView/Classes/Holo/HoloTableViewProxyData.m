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

- (NSIndexSet *)holo_insertSections:(NSArray<HoloSection *> *)sections anIndex:(NSInteger)index {
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

- (NSIndexSet *)holo_removeSection:(NSString *)tag {
    NSMutableIndexSet *indexSet = [NSMutableIndexSet new];
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holo_sections];
    for (HoloSection *section in self.holo_sections) {
        if ([section.tag isEqualToString:tag] || (!section.tag && !tag)) {
            [array removeObject:section];
            NSInteger index = [self.holo_sections indexOfObject:section];
            [indexSet addIndex:index];
        }
    }
    self.holo_sections = array;
    return [indexSet copy];
}

- (HoloSection *)holo_sectionWithTag:(NSString *)tag {
    for (HoloSection *section in self.holo_sections) {
        if ([section.tag isEqualToString:tag] || (!section.tag && !tag)) {
            return section;
        }
    }
    return nil;
}

- (NSArray<NSIndexPath *> *)holo_removeAllRowsInSection:(NSString *)tag {
    NSMutableArray *array = [NSMutableArray new];
    for (HoloSection *section in self.holo_sections) {
        if ([section.tag isEqualToString:tag] || (!section.tag && !tag)) {
            NSInteger sectionIndex = [self.holo_sections indexOfObject:section];
            for (NSInteger index = 0; index < section.rows.count; index++) {
                [array addObject:[NSIndexPath indexPathForRow:index inSection:sectionIndex]];
            }
            [section holo_removeAllRows];
        }
    }
    return [array copy];
}

- (NSArray<NSIndexPath *> *)holo_removeRow:(NSString *)tag {
    NSMutableArray *array = [NSMutableArray new];
    for (HoloSection *section in self.holo_sections) {
        for (HoloRow *row in section.rows) {
            if ([row.tag isEqualToString:tag] || (!row.tag && !tag)) {
                NSInteger sectionIndex = [self.holo_sections indexOfObject:section];
                NSInteger rowIndex = [section.rows indexOfObject:row];
                [array addObject:[NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex]];
                [section holo_removeRow:row];
            }
        }
    }
    return [array copy];
}

#pragma mark - getter
- (NSArray<HoloSection *> *)holo_sections {
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
