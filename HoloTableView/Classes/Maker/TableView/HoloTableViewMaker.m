//
//  HoloTableViewMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2020/1/30.
//

#import "HoloTableViewMaker.h"

@implementation HoloTableViewModel

@end


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

- (HoloTableViewMaker * (^)(id<UIScrollViewDelegate>))scrollDelegate {
    return ^id(id obj) {
        self.tableViewModel.scrollDelegate = obj;
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
