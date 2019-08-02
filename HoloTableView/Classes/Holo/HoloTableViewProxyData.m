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

- (void)configCellClsMap:(NSDictionary *)dict {
    NSMutableDictionary *map = [NSMutableDictionary dictionaryWithDictionary:self.holo_cellClsMap];
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString *cell, NSString *cls, BOOL * _Nonnull stop) {
        map[cell] = cls;
    }];
    self.holo_cellClsMap = [map copy];
}

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

- (void)holo_appendRows:(NSArray<HoloRow *> *)rows toSection:(NSString *)tag {
    if (rows.count <= 0) return;
    
    HoloSection *targetSection;
    for (HoloSection *section in self.holo_sections) {
        if ([section.tag isEqualToString:tag] || (!section.tag && !tag)) {
            targetSection = section;
            break;
        }
    }
    if (!targetSection) {
        targetSection = [HoloSection new];
        targetSection.tag = tag;
        [self holo_appendSections:@[targetSection]];
    }
    [targetSection holo_appendRows:rows];
}

- (void)holo_removeAllRowsInSection:(NSString *)tag {
    for (HoloSection *section in self.holo_sections) {
        if ([section.tag isEqualToString:tag] || (!section.tag && !tag)) {
            [section holo_removeAllRows];
        }
    }
}

- (void)holo_removeRow:(NSString *)tag {
    for (HoloSection *section in self.holo_sections) {
        for (HoloRow *row in section.rows) {
            if ([row.tag isEqualToString:tag] || (!row.tag && !tag)) {
                [section holo_removeRow:row];
            }
        }
    }
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
