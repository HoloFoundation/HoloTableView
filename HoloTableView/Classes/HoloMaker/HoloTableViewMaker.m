//
//  HoloTableViewMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2020/1/30.
//

#import "HoloTableViewMaker.h"

////////////////////////////////////////////////////////////
@interface HoloTableViewRHFMap ()

@property (nonatomic, copy) NSString *key;

@property (nonatomic, strong) Class cls;

@end

@implementation HoloTableViewRHFMap

- (void (^)(Class))map {
    return ^(Class cls) {
        self.cls = cls;
    };
}

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewRHFMapMaker ()

@property (nonatomic, strong) NSMutableArray<HoloTableViewRHFMap *> *mapArray;

@end

@implementation HoloTableViewRHFMapMaker

- (NSDictionary<NSString *, Class> *)install {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [self.mapArray enumerateObjectsUsingBlock:^(HoloTableViewRHFMap * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.key) dict[obj.key] = obj.cls;
    }];
    return dict.copy;
}

#pragma mark - getter
- (NSMutableArray<HoloTableViewRHFMap *> *)mapArray {
    if (!_mapArray) {
        _mapArray = [NSMutableArray new];
    }
    return _mapArray;
}

@end

////////////////////////////////////////////////////////////
@implementation HoloTableViewRowMapMaker

- (HoloTableViewRHFMap * (^)(NSString *))row {
    return ^id(id obj) {
        HoloTableViewRHFMap *map = [HoloTableViewRHFMap new];
        map.key = obj;
        [self.mapArray addObject:map];
        return map;
    };
}

@end

////////////////////////////////////////////////////////////
@implementation HoloTableViewHeaderMapMaker

- (HoloTableViewRHFMap * (^)(NSString *))header {
    return ^id(id obj) {
        HoloTableViewRHFMap *map = [HoloTableViewRHFMap new];
        map.key = obj;
        [self.mapArray addObject:map];
        return map;
    };
}

@end

////////////////////////////////////////////////////////////
@implementation HoloTableViewFooterMapMaker

- (HoloTableViewRHFMap * (^)(NSString *))footer {
    return ^id(id obj) {
        HoloTableViewRHFMap *map = [HoloTableViewRHFMap new];
        map.key = obj;
        [self.mapArray addObject:map];
        return map;
    };
}

@end

////////////////////////////////////////////////////////////
@implementation HoloTableViewModel

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewMaker ()

@property (nonatomic, strong) HoloTableViewModel *tableViewModel;

@end

@implementation HoloTableViewMaker

- (HoloTableViewMaker * (^)(NSArray<NSString *> *))sectionIndexTitles {
    return ^id(id obj) {
        self.tableViewModel.indexTitles = obj;
        return self;
    };
}

- (HoloTableViewMaker * (^)(NSInteger (^)(NSString *, NSInteger)))sectionForSectionIndexTitleHandler {
    return ^id(id obj) {
        self.tableViewModel.indexTitlesHandler = obj;
        return self;
    };
}

- (HoloTableViewMaker * (^)(id<HoloTableViewDelegate>))delegate {
    return ^id(id obj) {
        self.tableViewModel.delegate = obj;
        return self;
    };
}

- (HoloTableViewMaker * (^)(id<HoloTableViewDataSource>))dataSource {
    return ^id(id obj) {
        self.tableViewModel.dataSource = obj;
        return self;
    };
}

- (HoloTableViewMaker * (^)(id<UIScrollViewDelegate>))scrollDelegate {
    return ^id(id obj) {
        self.tableViewModel.scrollDelegate = obj;
        return self;
    };
}

- (HoloTableViewMaker * (^)(void (NS_NOESCAPE ^)(HoloTableViewRowMapMaker *)))makeRowsMap {
    return ^id(void(^block)(HoloTableViewRowMapMaker *make)) {
        HoloTableViewRowMapMaker *maker = [HoloTableViewRowMapMaker new];
        if (block) block(maker);
        
        self.tableViewModel.rowsMap = [maker install];
        return self;
    };
}

- (HoloTableViewMaker * (^)(void (NS_NOESCAPE ^)(HoloTableViewHeaderMapMaker *)))makeHeadersMap {
    return ^id(void(^block)(HoloTableViewHeaderMapMaker *make)) {
        HoloTableViewHeaderMapMaker *maker = [HoloTableViewHeaderMapMaker new];
        if (block) block(maker);
        
        self.tableViewModel.headersMap = [maker install];
        return self;
    };
}

- (HoloTableViewMaker * (^)(void (NS_NOESCAPE ^)(HoloTableViewFooterMapMaker *)))makeFootersMap {
    return ^id(void(^block)(HoloTableViewFooterMapMaker *make)) {
        HoloTableViewFooterMapMaker *maker = [HoloTableViewFooterMapMaker new];
        if (block) block(maker);
        
        self.tableViewModel.footersMap = [maker install];
        return self;
    };
}

- (HoloTableViewModel *)install {
    return self.tableViewModel;
}

#pragma mark - getter
- (HoloTableViewModel *)tableViewModel {
    if (!_tableViewModel) {
        _tableViewModel = [HoloTableViewModel new];
    }
    return _tableViewModel;
}

@end
