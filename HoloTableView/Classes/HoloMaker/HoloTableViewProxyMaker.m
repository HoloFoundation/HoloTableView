//
//  HoloTableViewProxyMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2020/4/14.
//

#import "HoloTableViewProxyMaker.h"

@implementation HoloTableViewProxyModel

@end


@interface HoloTableViewProxyMaker ()

@property (nonatomic, strong) HoloTableViewProxyModel *proxyModel;

@end

@implementation HoloTableViewProxyMaker

- (instancetype)init {
    self = [super init];
    if (self) {
        _proxyModel = [HoloTableViewProxyModel new];
    }
    return self;
}

- (HoloTableViewProxyMaker * (^)(id<HoloTableViewDelegate>))delegate {
    return ^id(id obj) {
        self.proxyModel.delegate = obj;
        return self;
    };
}

- (HoloTableViewProxyMaker * (^)(id<HoloTableViewDataSource>))dataSource {
    return ^id(id obj) {
        self.proxyModel.dataSource = obj;
        return self;
    };
}

- (HoloTableViewProxyMaker * (^)(id<UIScrollViewDelegate>))scrollDelegate {
    return ^id(id obj) {
        self.proxyModel.scrollDelegate = obj;
        return self;
    };
}

- (HoloTableViewProxyModel *)install {
    return self.proxyModel;
}

@end
