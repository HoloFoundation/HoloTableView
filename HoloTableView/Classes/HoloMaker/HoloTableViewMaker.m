//
//  HoloTableViewMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2020/1/30.
//

#import "HoloTableViewMaker.h"

////////////////////////////////////////////////////////////
@implementation HoloTableViewModel

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewMaker ()

@property (nonatomic, strong) HoloTableViewModel *tableViewModel;

@end

@implementation HoloTableViewMaker

- (instancetype)init {
    self = [super init];
    if (self) {
        _tableViewModel = [HoloTableViewModel new];
    }
    return self;
}

- (HoloTableViewMaker * (^)(NSArray<NSString *> *))sectionIndexTitles {
    return ^id(id obj) {
        self.tableViewModel = obj;
        return self;
    };
}

- (HoloTableViewMaker * (^)(NSInteger (^)(NSString *, NSInteger)))sectionForSectionIndexTitleHandler {
    return ^id(id obj) {
        self.tableViewModel = obj;
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

- (HoloTableViewModel *)install {
    return self.tableViewModel;
}

@end
