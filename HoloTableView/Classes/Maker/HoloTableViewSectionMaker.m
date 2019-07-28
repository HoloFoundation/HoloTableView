//
//  HoloTableViewSectionMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import "HoloTableViewSectionMaker.h"
#import "HoloSection.h"

@implementation HoloTableViewSectionMaker

- (instancetype)init {
    self = [super init];
    if (self) {
        _section = [HoloSection new];
    }
    return self;
}

- (HoloTableViewSectionMaker *(^)(UIView *))headerView {
    return ^id(UIView *headerView) {
        self.section.headerView = headerView;        
        return self;
    };
}

- (HoloTableViewSectionMaker *(^)(UIView *))footerView {
    return ^id(UIView *footerView) {
        self.section.footerView = footerView;
        return self;
    };
}

- (HoloTableViewSectionMaker *(^)(CGFloat))headerViewHeight {
    return ^id(CGFloat headerViewHeight) {
        self.section.headerViewHeight = headerViewHeight;
        return self;
    };
}

- (HoloTableViewSectionMaker *(^)(CGFloat))footerViewHeight {
    return ^id(CGFloat footerViewHeight) {
        self.section.footerViewHeight = footerViewHeight;
        return self;
    };
}

@end
