//
//  HoloTableViewConfiger.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import "HoloTableViewConfiger.h"

//============================================================:HoloTableViewCellConfiger
@implementation HoloTableViewCellConfiger

- (HoloTableViewCellConfiger *(^)(NSString *))cls {
    return ^id(NSString *cls) {
        self.clsName = cls;
        return self;
    };
}

@end

//============================================================:HoloTableViewConfiger
@interface HoloTableViewConfiger ()

@property (nonatomic, strong) NSMutableArray *configerArray;

@property (nonatomic, strong) NSMutableDictionary *cellClsMap;

@end

@implementation HoloTableViewConfiger

- (HoloTableViewCellConfiger *(^)(NSString *))cell {
    return ^id(NSString *cell) {
        HoloTableViewCellConfiger *configer = [HoloTableViewCellConfiger new];
        configer.cellName = cell;
        [self.configerArray addObject:configer];
        return configer;
    };
}

- (NSDictionary *)install {
    for (HoloTableViewCellConfiger *configer in self.configerArray) {
        self.cellClsMap[configer.cellName] = configer.clsName;
    }
    return [self.cellClsMap copy];
}

#pragma mark - getter
- (NSMutableArray *)configerArray {
    if (!_configerArray) {
        _configerArray = [NSMutableArray new];
    }
    return _configerArray;
}

- (NSMutableDictionary *)cellClsMap {
    if (!_cellClsMap) {
        _cellClsMap = [NSMutableDictionary new];
    }
    return _cellClsMap;
}

@end
