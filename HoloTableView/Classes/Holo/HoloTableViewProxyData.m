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

- (HoloSection *)holo_sectionWithTag:(NSString *)tag {
    for (HoloSection *section in self.holo_sections) {
        if ([section.tag isEqualToString:tag] || (!section.tag && !tag)) {
            return section;
        }
    }
    return nil;
}

- (void)holo_appendSection:(HoloSection *)section {
    if (!section) return;
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holo_sections];
    [array addObject:section];
    self.holo_sections = array;
}

- (void)holo_appendSections:(NSArray<HoloSection *> *)sections {
    if (sections.count <= 0) return;
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holo_sections];
    [array addObjectsFromArray:sections];
    self.holo_sections = array;
}

- (void)holo_updateSection:(HoloSection *)targetSection fromSection:(HoloSection *)fromSection {
    if (!targetSection || !fromSection) return;
    
    if (fromSection.header) {
        targetSection.header = fromSection.header;
    }
    if (fromSection.footer) {
        targetSection.footer = fromSection.footer;
    }
    if (fromSection.headerHeight) {
        targetSection.headerHeight = fromSection.headerHeight;
    }
    if (fromSection.footerHeight) {
        targetSection.footerHeight = fromSection.footerHeight;
    }
    if (fromSection.willDisplayHeaderHandler) {
        targetSection.willDisplayHeaderHandler = fromSection.willDisplayHeaderHandler;
    }
    if (fromSection.willDisplayFooterHandler) {
        targetSection.willDisplayFooterHandler = fromSection.willDisplayFooterHandler;
    }
    if (fromSection.didEndDisplayingHeaderHandler) {
        targetSection.didEndDisplayingHeaderHandler = fromSection.didEndDisplayingHeaderHandler;
    }
    if (fromSection.didEndDisplayingFooterHandler) {
        targetSection.didEndDisplayingFooterHandler = fromSection.didEndDisplayingFooterHandler;
    }
}

- (void)holo_removeSection:(HoloSection *)section {
    if (!section) return;
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holo_sections];
    [array removeObject:section];
    self.holo_sections = array;
}

- (void)holo_removeAllSection {
    self.holo_sections = [NSArray new];
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
