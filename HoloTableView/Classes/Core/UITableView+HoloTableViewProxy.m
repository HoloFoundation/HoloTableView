//
//  UITableView+HoloTableViewProxy.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import "UITableView+HoloTableViewProxy.h"
#import <objc/runtime.h>
#import "HoloTableViewProxy.h"
#import "HoloTableViewProxyData.h"

static char kHoloTableViewProxyKey;

@implementation UITableView (HoloTableViewProxy)

- (NSArray<HoloTableSection *> *)holo_sections {
    return self.holo_proxy.proxyData.sections;
}

- (void)setHolo_sections:(NSArray<HoloTableSection *> *)holo_sections {
    self.holo_proxy.proxyData.sections = holo_sections;
}

- (NSArray<NSString *> *)holo_sectionIndexTitles {
    return self.holo_proxy.proxyData.sectionIndexTitles;
}

- (void)setHolo_sectionIndexTitles:(NSArray<NSString *> *)holo_sectionIndexTitles {
    self.holo_proxy.proxyData.sectionIndexTitles = holo_sectionIndexTitles;
}

- (NSInteger (^)(NSString * _Nonnull, NSInteger))holo_sectionForSectionIndexTitleHandler {
    return self.holo_proxy.proxyData.sectionForSectionIndexTitleHandler;
}

- (void)setHolo_sectionForSectionIndexTitleHandler:(NSInteger (^)(NSString * _Nonnull, NSInteger))holo_sectionForSectionIndexTitleHandler {
    self.holo_proxy.proxyData.sectionForSectionIndexTitleHandler = holo_sectionForSectionIndexTitleHandler;
}

- (id<UIScrollViewDelegate>)holo_scrollDelegate {
    return self.holo_proxy.scrollDelegate;
}

- (void)setHolo_scrollDelegate:(id<UIScrollViewDelegate>)holo_scrollDelegate {
    self.holo_proxy.scrollDelegate = holo_scrollDelegate;
}

- (HoloTableViewProxy *)holo_proxy {
    HoloTableViewProxy *tableViewProxy = objc_getAssociatedObject(self, &kHoloTableViewProxyKey);
    if (!tableViewProxy) {
        tableViewProxy = [HoloTableViewProxy new];
        objc_setAssociatedObject(self, &kHoloTableViewProxyKey, tableViewProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.dataSource = tableViewProxy;
        self.delegate = tableViewProxy;
    }
    return tableViewProxy;
}

@end
