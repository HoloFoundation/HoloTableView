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
    return ^id(NSString *cls) {
        self.clsName = cls;
        return self;
    };
}

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewConfiger ()

@property (nonatomic, strong) NSMutableArray *cellClsConfigers;

@property (nonatomic, copy) NSArray *sectionIndexTitlesArray;

@property (nonatomic, copy) NSInteger (^ sectionForSectionIndexTitleBlock)(NSArray<NSString *> *, NSString *, NSInteger);

@end

@implementation HoloTableViewConfiger

- (HoloTableViewCellConfiger *(^)(NSString *))cell {
    return ^id(NSString *cell) {
        HoloTableViewCellConfiger *configer = [HoloTableViewCellConfiger new];
        configer.cellName = cell;
        [self.cellClsConfigers addObject:configer];
        return configer;
    };
}

- (HoloTableViewConfiger * (^)(NSArray<NSString *> *))sectionIndexTitles {
    return ^id(NSArray<NSString *> *sectionIndexTitles) {
        self.sectionIndexTitlesArray = sectionIndexTitles;
        return self;
    };
}

- (HoloTableViewConfiger *(^)(NSInteger (^)(NSArray<NSString *> *, NSString *, NSInteger)))sectionForSectionIndexTitleHandler {
    return ^id(NSInteger (^ sectionForSectionIndexTitleHandler)(NSArray<NSString *> *, NSString *, NSInteger)) {
        self.sectionForSectionIndexTitleBlock = sectionForSectionIndexTitleHandler;
        return self;
    };
}

- (NSDictionary *)install {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    NSMutableDictionary *cellClsMap = [NSMutableDictionary new];
    for (HoloTableViewCellConfiger *configer in self.cellClsConfigers) {
        cellClsMap[configer.cellName] = configer.clsName;
    }
    dict[@"cellClsMap"] = [cellClsMap copy];
    dict[@"sectionIndexTitles"] = self.sectionIndexTitlesArray;
    dict[@"sectionForSectionIndexTitleHandler"] = self.sectionForSectionIndexTitleBlock;
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
