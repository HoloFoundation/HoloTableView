//
//  HoloTableViewSectionMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import "HoloTableViewSectionMaker.h"
#import "HoloTableViewRowMaker.h"
#import "HoloTableViewRowUpdateMaker.h"

//============================================================:HoloSection
@implementation HoloSection

- (instancetype)init {
    self = [super init];
    if (self) {
        _holoRows = [NSArray new];
    }
    return self;
}

- (void)holo_appendRows:(NSArray<HoloRow *> *)holoRows {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holoRows];
    [array addObjectsFromArray:holoRows];
    self.holoRows = array;
}

- (void)holo_updateRow:(HoloUpdateRow *)holoUpdateRow {
    HoloRow *replaceRow;
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holoRows];
    for (HoloRow *row in array) {
        if ([row.tag isEqualToString:holoUpdateRow.tag] || (!row.tag && !holoUpdateRow.tag)) {
            replaceRow = row;
            break;
        }
    }
    if (replaceRow) {
        if (holoUpdateRow.cell) {
            replaceRow.cell = holoUpdateRow.cell;
        }
        if (holoUpdateRow.model) {
            replaceRow.model = holoUpdateRow.model;
        }
        if (holoUpdateRow.height) {
            replaceRow.height = holoUpdateRow.height;
        }
    }
}

- (void)holo_removeRow:(NSString *)tag {
    HoloRow *removeRow;
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holoRows];
    for (HoloRow *row in array) {
        if ([row.tag isEqualToString:tag] || (!row.tag && !tag)) {
            removeRow = row;
            break;
        }
    }
    if (removeRow) {
        [array removeObject:removeRow];
        self.holoRows = array;
    }
}

- (void)holo_replaceRowWithTag:(NSString *)tag withRow:(HoloRow *)holoRow {
    HoloRow *replaceRow;
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holoRows];
    for (HoloRow *row in array) {
        if ([row.tag isEqualToString:tag] || (!row.tag && !tag)) {
            replaceRow = row;
            break;
        }
    }
    if (replaceRow) {
        NSInteger index = [array indexOfObject:replaceRow];
        [array replaceObjectAtIndex:index withObject:holoRow];
        self.holoRows = array;
    }
    
}
- (void)holo_replaceRow:(HoloRow *)replaceRow withRow:(HoloRow *)holoRow {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holoRows];
    NSInteger index = [array indexOfObject:replaceRow];
    [array replaceObjectAtIndex:index withObject:holoRow];
    self.holoRows = array;
    
}

- (void)holo_removeAllRows {
    self.holoRows = nil;
}

@end

//============================================================:HoloSectionMaker
@implementation HoloSectionMaker

- (instancetype)init {
    self = [super init];
    if (self) {
        _section = [HoloSection new];
    }
    return self;
}

- (HoloSectionMaker *(^)(UIView *))headerView {
    return ^id(UIView *headerView) {
        self.section.headerView = headerView;
        return self;
    };
}

- (HoloSectionMaker *(^)(UIView *))footerView {
    return ^id(UIView *footerView) {
        self.section.footerView = footerView;
        return self;
    };
}

- (HoloSectionMaker *(^)(CGFloat))headerViewHeight {
    return ^id(CGFloat headerViewHeight) {
        self.section.headerViewHeight = headerViewHeight;
        return self;
    };
}

- (HoloSectionMaker *(^)(CGFloat))footerViewHeight {
    return ^id(CGFloat footerViewHeight) {
        self.section.footerViewHeight = footerViewHeight;
        return self;
    };
}

@end

//============================================================:HoloTableViewSectionMaker
@interface HoloTableViewSectionMaker ()

@property (nonatomic, strong) NSMutableArray<HoloSection *> *holoSections;

@end

@implementation HoloTableViewSectionMaker

- (HoloSectionMaker *(^)(NSString *))section {
    __weak typeof(self) weakSelf = self;
    return ^id(NSString *tag) {
        __weak typeof(weakSelf) strongSelf = weakSelf;
        HoloSectionMaker *sectionMaker = [HoloSectionMaker new];
        sectionMaker.section.tag = tag;
        [strongSelf.holoSections addObject:sectionMaker.section];
        return sectionMaker;
    };
}

- (NSArray<HoloSection *> *)install {
    return self.holoSections;
}

#pragma mark - getter
- (NSMutableArray<HoloSection *> *)holoSections {
    if (!_holoSections) {
        _holoSections = [NSMutableArray new];
    }
    return _holoSections;
}


@end
