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

- (NSIndexSet *)holo_appendSections:(NSArray<HoloSection *> *)sections {
    if (sections.count <= 0) return nil;

    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.holo_sections.count, sections.count)];
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holo_sections];
    [array addObjectsFromArray:sections];
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

- (NSArray<NSIndexPath *> *)holo_appendRows:(NSArray<HoloRow *> *)rows toSection:(NSString *)tag {
    if (rows.count <= 0) return nil;
    
    HoloSection *targetSection = [self holo_sectionWithTag:tag];
    if (!targetSection) {
        targetSection = [HoloSection new];
        targetSection.tag = tag;
        [self holo_appendSections:@[targetSection]];
    }
    
    NSInteger sectionIndex = [self.holo_sections indexOfObject:targetSection];
    NSIndexSet *indexSet = [targetSection holo_appendRows:rows];
    NSMutableArray *indePathArray = [NSMutableArray new];
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        [indePathArray addObject:[NSIndexPath indexPathForRow:idx inSection:sectionIndex]];
    }];
    return [indePathArray copy];
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

- (NSDictionary *)holo_cellClsMap {
    if (!_holo_cellClsMap) {
        _holo_cellClsMap = [NSDictionary new];
    }
    return _holo_cellClsMap;
}

@end
