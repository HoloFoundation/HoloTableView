//
//  HoloTableSection.m
//  HoloTableView
//
//  Created by 与佳期 on 2020/6/2.
//

#import "HoloTableSection.h"

@interface HoloTableSection ()

@property (nonatomic, strong) NSMutableArray<HoloTableRowProtocol> *mutableRows;

@end

@implementation HoloTableSection

- (instancetype)init {
    self = [super init];
    if (self) {
        _headerHeight = CGFLOAT_MIN;
        _footerHeight = CGFLOAT_MIN;
        _headerEstimatedHeight = CGFLOAT_MIN;
        _footerEstimatedHeight = CGFLOAT_MIN;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        _headerConfigSEL                = @selector(holo_configureHeaderWithModel:);
        _footerConfigSEL                = @selector(holo_configureFooterWithModel:);
        _headerHeightSEL                = @selector(holo_heightForHeaderWithModel:);
        _footerHeightSEL                = @selector(holo_heightForFooterWithModel:);
        _headerEstimatedHeightSEL       = @selector(holo_estimatedHeightForHeaderWithModel:);
        _footerEstimatedHeightSEL       = @selector(holo_estimatedHeightForFooterWithModel:);
        
        _willDisplayHeaderSEL           = @selector(holo_willDisplayHeaderWithModel:);
        _willDisplayFooterSEL           = @selector(holo_willDisplayFooterWithModel:);
        _didEndDisplayingHeaderSEL      = @selector(holo_didEndDisplayingHeaderWithModel:);
        _didEndDisplayingFooterSEL      = @selector(holo_didEndDisplayingFooterWithModel:);
#pragma clang diagnostic pop
    }
    return self;
}


- (void)addRow:(id<HoloTableRowProtocol>)row {
    if (!row) return;
    [self.mutableRows addObject:row];
}

- (void)removeRow:(id<HoloTableRowProtocol>)row {
    if (!row) return;
    [self.mutableRows removeObject:row];
}

- (void)removeAllRows {
    [self.mutableRows removeAllObjects];
}

- (void)insertRow:(id<HoloTableRowProtocol>)row atIndex:(NSInteger)index {
    if (!row) return;
    if (index < 0) index = 0;
    if (index > self.rows.count) index = self.rows.count;
    [self.mutableRows insertObject:row atIndex:index];
}

#pragma mark - getter

- (NSArray<HoloTableRowProtocol> *)rows {
    return self.mutableRows;
}

- (NSMutableArray<HoloTableRowProtocol> *)mutableRows {
    if (!_mutableRows) {
        _mutableRows = [NSMutableArray<HoloTableRowProtocol> new];
    }
    return _mutableRows;
}

@end
