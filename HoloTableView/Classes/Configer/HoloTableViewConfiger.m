//
//  HoloTableViewConfiger.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import "HoloTableViewConfiger.h"
#import "HoloTableViewCellConfiger.h"

@interface HoloTableViewConfiger ()

@property (nonatomic, strong) NSMutableArray *cellArray;

@property (nonatomic, strong) NSMutableDictionary *cellDict;

@end

@implementation HoloTableViewConfiger

- (HoloTableViewCellConfiger *(^)(NSString *))cell {
    return ^id(NSString *cell) {
        HoloTableViewCellConfiger *configer = [HoloTableViewCellConfiger new];
        configer.cellName = cell;
        [self.cellArray addObject:configer];
        return configer;
    };
}

- (NSDictionary *)install {
    for (HoloTableViewCellConfiger *configer in self.cellArray) {
        self.cellDict[configer.cellName] = configer.clsName;
    }
    return [self.cellDict copy];
}

#pragma mark - getter
- (NSMutableArray *)cellArray {
    if (!_cellArray) {
        _cellArray = [NSMutableArray new];
    }
    return _cellArray;
}

- (NSMutableDictionary *)cellDict {
    if (!_cellDict) {
        _cellDict = [NSMutableDictionary new];
    }
    return _cellDict;
}

@end
