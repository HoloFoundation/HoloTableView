//
//  HoloTableViewDataSource.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/29.
//

#import "HoloTableViewDataSource.h"
#import "HoloTableViewSectionMaker.h"
#import "HoloTableViewRowMaker.h"

@interface HoloTableViewDataSource ()

@property (nonatomic, copy) NSArray<HoloSection *> *holoSections;

@property (nonatomic, copy) NSDictionary *cellClsDict;

@end

@implementation HoloTableViewDataSource

- (NSArray<HoloSection *> *)fetchHoloSections {
    return self.holoSections;
}

- (NSDictionary *)fetchCellClsDict {
    return self.cellClsDict;
}


- (void)configCellClsDict:(NSDictionary *)cellClsDict {
    self.cellClsDict = cellClsDict;
}

- (HoloSection *)holo_sectionWithTag:(NSString *)tag {
    for (HoloSection *section in self.holoSections) {
        if ([section.tag isEqualToString:tag] || (!section.tag && !tag)) {
            return section;
        }
    }
    return nil;
}

- (void)holo_appendSection:(HoloSection *)section {
    if (!section) return;
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holoSections];
    [array addObject:section];
    self.holoSections = array;
}

- (void)holo_appendSections:(NSArray<HoloSection *> *)sections {
    if (sections.count <= 0) return;
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holoSections];
    [array addObjectsFromArray:sections];
    self.holoSections = array;
}

- (void)holo_updateSection:(HoloSection *)targetSection fromSection:(HoloSection *)fromSection {
    if (!targetSection || !fromSection) return;
    
    if (fromSection.headerView) {
        targetSection.headerView = fromSection.headerView;
    }
    if (fromSection.footerView) {
        targetSection.footerView = fromSection.footerView;
    }
    if (fromSection.headerViewHeight) {
        targetSection.headerViewHeight = fromSection.headerViewHeight;
    }
    if (fromSection.footerViewHeight) {
        targetSection.footerViewHeight = fromSection.footerViewHeight;
    }
    if (fromSection.willDisplayHeaderViewHandler) {
        targetSection.willDisplayHeaderViewHandler = fromSection.willDisplayHeaderViewHandler;
    }
    if (fromSection.willDisplayFooterViewHandler) {
        targetSection.willDisplayFooterViewHandler = fromSection.willDisplayFooterViewHandler;
    }
    if (fromSection.didEndDisplayingHeaderViewHandler) {
        targetSection.didEndDisplayingHeaderViewHandler = fromSection.didEndDisplayingHeaderViewHandler;
    }
    if (fromSection.didEndDisplayingFooterViewHandler) {
        targetSection.didEndDisplayingFooterViewHandler = fromSection.didEndDisplayingFooterViewHandler;
    }
}

- (void)holo_removeSection:(HoloSection *)section {
    if (!section) return;
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holoSections];
    [array removeObject:section];
    self.holoSections = array;
}

- (void)holo_removeAllSection {
    self.holoSections = [NSArray new];
}

- (HoloSection *)holo_sectionWithRowTag:(NSString *)tag {
    for (HoloSection *section in self.holoSections) {
        for (HoloRow *row in section.rows) {
            if ([row.tag isEqualToString:tag] || (!row.tag && !tag)) {
                return section;
            }
        }
    }
    return nil;
}

#pragma mark - getter
- (NSArray<HoloSection *> *)holoSections {
    if (!_holoSections) {
        _holoSections = [NSArray new];
    }
    return _holoSections;
}

- (NSDictionary *)cellClsDict {
    if (!_cellClsDict) {
        _cellClsDict = [NSDictionary new];
    }
    return _cellClsDict;
}

@end
