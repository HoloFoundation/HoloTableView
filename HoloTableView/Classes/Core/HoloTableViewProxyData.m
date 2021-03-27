//
//  HoloTableViewProxyData.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/29.
//

#import "HoloTableViewProxyData.h"

@implementation HoloTableViewProxyData

#pragma mark - getter
- (NSArray<id<HoloTableSectionProtocol>> *)sections {
    if (!_sections) {
        _sections = [NSArray<id<HoloTableSectionProtocol>> new];
    }
    return _sections;
}

- (NSDictionary<NSString *,Class> *)rowsMap {
    if (!_rowsMap) {
        _rowsMap = [NSDictionary new];
    }
    return _rowsMap;
}

- (NSDictionary<NSString *,Class> *)headersMap {
    if (!_headersMap) {
        _headersMap = [NSDictionary new];
    }
    return _headersMap;
}

- (NSDictionary<NSString *,Class> *)footersMap {
    if (!_footersMap) {
        _footersMap = [NSDictionary new];
    }
    return _footersMap;
}

@end
