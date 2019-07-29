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

- (HoloSection *)holo_defultSection {
    return self.holoSections.firstObject;
}

- (HoloSection *)holo_sectionWithTag:(NSString *)tag {
    for (HoloSection *holoSection in self.holoSections) {
        if ([holoSection.tag isEqualToString:tag] || (!holoSection.tag && !tag)) {
            return holoSection;
        }
    }
    return nil;
}

- (void)holo_appendSection:(HoloSection *)section {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holoSections];
    [array addObject:section];
    self.holoSections = array;
}

- (void)holo_replaceSection:(HoloSection *)replaceSection withSection:(HoloSection *)section {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holoSections];
    NSInteger index = [array indexOfObject:replaceSection];
    [array replaceObjectAtIndex:index withObject:section];
    self.holoSections = array;
}

- (void)holo_removeSection:(HoloSection *)section {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holoSections];
    [array removeObject:section];
    self.holoSections = array;
}

- (void)holo_removeAllSection {
    self.holoSections = nil;
}

- (HoloSection *)holo_sectionWithRowTag:(NSString *)tag {
    for (HoloSection *holoSection in self.holoSections) {
        for (HoloRow *holoRow in holoSection.holoRows) {
            if ([holoRow.tag isEqualToString:tag] || (!holoRow.tag && !tag)) {
                return holoSection;
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
