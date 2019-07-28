//
//  HoloTableViewMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import "HoloTableViewMaker.h"
#import "HoloTableViewSectionMaker.h"
#import "HoloTableViewRowMaker.h"
#import "HoloSection.h"
#import "HoloRow.h"


@interface HoloTableViewMaker ()

@property (nonatomic, strong) HoloTableViewSectionMaker *sectionMaker;

@property (nonatomic, strong) NSMutableArray *holoRows;

@end

@implementation HoloTableViewMaker

- (HoloTableViewSectionMaker *(^)(NSString *))section {
    __weak typeof(self) weakSelf = self;
    return ^id(NSString *tag) {
        __weak typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.sectionMaker.section.tag = tag;
        return strongSelf.sectionMaker;
    };
}

- (HoloTableViewRowMaker *(^)(NSString *))row {
    __weak typeof(self) weakSelf = self;
    return ^id(NSString *cell) {
        __weak typeof(weakSelf) strongSelf = weakSelf;
        HoloTableViewRowMaker *rowMaker = [HoloTableViewRowMaker new];
        rowMaker.row.cell = cell;
        [strongSelf.holoRows addObject:rowMaker.row];
        return rowMaker;
    };
}

- (HoloSection *)install {
    [self.sectionMaker.section holo_appendRows:[self.holoRows copy]];
    return self.sectionMaker.section;
}

#pragma mark - getter
- (HoloTableViewSectionMaker *)sectionMaker {
    if (!_sectionMaker) {
        _sectionMaker = [HoloTableViewSectionMaker new];
    }
    return _sectionMaker;
}

- (NSMutableArray *)holoRows {
    if (!_holoRows) {
        _holoRows = [NSMutableArray new];
    }
    return _holoRows;
}

@end
