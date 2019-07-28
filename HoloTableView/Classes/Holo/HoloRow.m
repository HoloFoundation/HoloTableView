//
//  HoloRow.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import "HoloRow.h"

@implementation HoloRow

- (instancetype)init {
    self = [super init];
    if (self) {
        _height = CGFLOAT_MIN;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        _configSEL = @selector(cellForRow:);
        _heightSEL = @selector(heightForRow:);
#pragma clang diagnostic pop
    }
    
    return self;
}

@end
