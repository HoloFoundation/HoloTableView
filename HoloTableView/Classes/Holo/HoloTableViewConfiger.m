//
//  HoloTableViewConfiger.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import "HoloTableViewConfiger.h"

////////////////////////////////////////////////////////////
@implementation HoloTableViewCellConfiger

- (HoloTableViewCellConfiger *(^)(NSString *))cls {
    return ^id(id obj) {
        self.clsName = obj;
        return self;
    };
}

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewConfiger ()

@property (nonatomic, strong) NSMutableArray *cellClsConfigers;

@property (nonatomic, copy) NSArray *sectionIndexTitlesArray;

@property (nonatomic, copy) NSInteger (^sectionForSectionIndexTitleBlock)(NSString *title, NSInteger index);

@end

@implementation HoloTableViewConfiger

- (HoloTableViewCellConfiger *(^)(NSString *))cell {
    return ^id(id obj) {
        HoloTableViewCellConfiger *configer = [HoloTableViewCellConfiger new];
        configer.cellName = obj;
        [self.cellClsConfigers addObject:configer];
        return configer;
    };
}

- (HoloTableViewConfiger * (^)(NSArray<NSString *> *))sectionIndexTitles {
    return ^id(id obj) {
        self.sectionIndexTitlesArray = obj;
        return self;
    };
}

- (HoloTableViewConfiger * (^)(NSInteger (^)(NSString *, NSInteger)))sectionForSectionIndexTitleHandler {
    return ^id(id obj) {
        self.sectionForSectionIndexTitleBlock = obj;
        return self;
    };
}

- (NSDictionary *)install {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    NSMutableDictionary *cellClsMap = [NSMutableDictionary new];
    for (HoloTableViewCellConfiger *configer in self.cellClsConfigers) {
        cellClsMap[configer.cellName] = configer.clsName;
    }
    dict[kHoloCellClsMap] = [cellClsMap copy];
    dict[kHoloSectionIndexTitles] = self.sectionIndexTitlesArray;
    dict[kHoloSectionForSectionIndexTitleHandler] = self.sectionForSectionIndexTitleBlock;
    return [dict copy];
}

#pragma mark - getter
- (NSMutableArray *)cellClsConfigers {
    if (!_cellClsConfigers) {
        _cellClsConfigers = [NSMutableArray new];
    }
    return _cellClsConfigers;
}

@end
