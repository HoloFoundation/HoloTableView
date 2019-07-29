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
        _rows = [NSArray new];
    }
    return self;
}

- (void)holo_appendRows:(NSArray<HoloRow *> *)rows {
    if (rows.count <= 0) return;
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.rows];
    [array addObjectsFromArray:rows];
    self.rows = array;
}

- (void)holo_updateRow:(HoloUpdateRow *)updateRow {
    if (!updateRow) return;
    
    HoloRow *replaceRow;
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.rows];
    for (HoloRow *row in array) {
        if ([row.tag isEqualToString:updateRow.tag] || (!row.tag && !updateRow.tag)) {
            replaceRow = row;
            break;
        }
    }
    if (replaceRow) {
        if (updateRow.cell) {
            replaceRow.cell = updateRow.cell;
        }
        if (updateRow.model) {
            replaceRow.model = updateRow.model;
        }
        if (updateRow.height) {
            replaceRow.height = updateRow.height;
        }
    }
}

- (void)holo_removeRow:(NSString *)tag {
    HoloRow *removeRow;
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.rows];
    for (HoloRow *row in array) {
        if ([row.tag isEqualToString:tag] || (!row.tag && !tag)) {
            removeRow = row;
            break;
        }
    }
    if (removeRow) {
        [array removeObject:removeRow];
        self.rows = array;
    }
}

- (void)holo_removeAllRows {
    self.rows = [NSArray new];
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

- (HoloSectionMaker *(^)(void (^)(UIView *)))willDisplayHeaderViewHandler {
    return ^id( void (^willDisplayHeaderViewHandler)(id) ){
        self.section.willDisplayHeaderViewHandler = willDisplayHeaderViewHandler;
        return self;
    };
}

- (HoloSectionMaker *(^)(void (^)(UIView *)))willDisplayFooterViewHandler {
    return ^id( void (^willDisplayFooterViewHandler)(id) ){
        self.section.willDisplayFooterViewHandler = willDisplayFooterViewHandler;
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
