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

@property (nonatomic, strong) NSMutableDictionary *cellDict;

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
        self.cellDict[configer.cellName] = configer.clsName;
    }
    return [self.cellDict copy];
}

#pragma mark - getter
- (NSMutableArray *)configerArray {
    if (!_configerArray) {
        _configerArray = [NSMutableArray new];
    }
    return _configerArray;
}

- (NSMutableDictionary *)cellDict {
    if (!_cellDict) {
        _cellDict = [NSMutableDictionary new];
    }
    return _cellDict;
}

@end
