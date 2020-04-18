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

- (NSIndexSet *)insertSections:(NSArray<HoloTableSection *> *)sections anIndex:(NSInteger)index {
    if (sections.count <= 0) return nil;
    
    if (index < 0) index = 0;
    if (index > self.sections.count) index = self.sections.count;
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, sections.count)];
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.sections];
    [array insertObjects:sections atIndexes:indexSet];
    self.sections = array;
    return indexSet;
}

- (NSIndexSet *)removeAllSection {
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.sections.count)];
    self.sections = [NSArray new];
    return indexSet;
}

- (NSIndexSet *)removeSections:(NSArray<NSString *> *)tags {
    NSMutableIndexSet *indexSet = [NSMutableIndexSet new];
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.sections];
    for (HoloTableSection *section in self.sections) {
        if (section.tag && [tags containsObject:section.tag]) {
            [array removeObject:section];
            NSInteger index = [self.sections indexOfObject:section];
            [indexSet addIndex:index];
        }
    }
    self.sections = array;
    return [indexSet copy];
}

- (HoloTableSection *)sectionWithTag:(NSString *)tag {
    for (HoloTableSection *section in self.sections) {
        if ([section.tag isEqualToString:tag]) return section;
    }
    return nil;
}

- (NSArray<NSIndexPath *> *)removeAllRowsInSections:(NSArray<NSString *> *)tags {
    NSMutableArray *array = [NSMutableArray new];
    for (HoloTableSection *section in self.sections) {
        if (section.tag && [tags containsObject:section.tag]) {
            NSInteger sectionIndex = [self.sections indexOfObject:section];
            for (NSInteger index = 0; index < section.rows.count; index++) {
                [array addObject:[NSIndexPath indexPathForRow:index inSection:sectionIndex]];
            }
            [section removeAllRows];
        }
    }
    return [array copy];
}

- (NSArray<NSIndexPath *> *)removeRows:(NSArray<NSString *> *)tags {
    NSMutableArray *array = [NSMutableArray new];
    for (HoloTableSection *section in self.sections) {
        NSMutableArray<HoloTableRow *> *rows = [NSMutableArray new];
        for (HoloTableRow *row in section.rows) {
            if (row.tag && [tags containsObject:row.tag]) {
                NSInteger sectionIndex = [self.sections indexOfObject:section];
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

#pragma mark - getter
- (NSArray<HoloTableSection *> *)sections {
    if (!_sections) {
        _sections = [NSArray new];
    }
    return _sections;
}

- (NSDictionary<NSString *,Class> *)rowsMap {
    if (!_rowsMap) {
        _rowsMap = [NSDictionary new];
    }
    return _rowsMap;
}

- (NSDictionary<NSString *,Class> *)headerFooterMap {
    if (!_headerFooterMap) {
        _headerFooterMap = [NSDictionary new];
    }
    return _headerFooterMap;
}

@end
