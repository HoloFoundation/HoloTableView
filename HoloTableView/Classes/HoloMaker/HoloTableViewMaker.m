//
//  HoloTableViewMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2020/1/30.
//

#import "HoloTableViewMaker.h"

////////////////////////////////////////////////////////////
@implementation HoloTableViewRowMapMaker

@end

////////////////////////////////////////////////////////////
@implementation HoloTableViewHeaderMapMaker

@end

////////////////////////////////////////////////////////////
@implementation HoloTableViewFooterMapMaker

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
        
//        [self.section insertRows:[maker install] atIndex:NSIntegerMax];
        return self;
    };
}

- (HoloTableViewMaker * (^)(void (NS_NOESCAPE ^)(HoloTableViewHeaderMapMaker *)))makeHeadersMap {
    return ^id(void(^block)(HoloTableViewHeaderMapMaker *make)) {
        HoloTableViewHeaderMapMaker *maker = [HoloTableViewHeaderMapMaker new];
        if (block) block(maker);
        
//        [self.section insertRows:[maker install] atIndex:NSIntegerMax];
        return self;
    };
}

- (HoloTableViewMaker * (^)(void (NS_NOESCAPE ^)(HoloTableViewFooterMapMaker *)))makeFootersMap {
    return ^id(void(^block)(HoloTableViewFooterMapMaker *make)) {
        HoloTableViewFooterMapMaker *maker = [HoloTableViewFooterMapMaker new];
        if (block) block(maker);
        
//        [self.section insertRows:[maker install] atIndex:NSIntegerMax];
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
