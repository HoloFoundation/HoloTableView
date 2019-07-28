//
//  HoloSection.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import "HoloSection.h"

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

- (void)holo_deleteAllRows {
    self.holoRows = nil;
}

@end
