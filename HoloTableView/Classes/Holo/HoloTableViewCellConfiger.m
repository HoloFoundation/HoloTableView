//
//  HoloTableViewCellConfiger.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import "HoloTableViewCellConfiger.h"

@implementation HoloTableViewCellConfiger

- (HoloTableViewCellConfiger *(^)(NSString *))cls {
    return ^id(NSString *cls) {
        self.clsName = cls;
        return self;
    };
}

@end