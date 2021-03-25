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

- (void)setHolo_proxy:(HoloTableViewProxy * _Nonnull)tableViewProxy {
    objc_setAssociatedObject(self, &kHoloTableViewProxyKey, tableViewProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.dataSource = tableViewProxy;
    self.delegate = tableViewProxy;
}

- (id<UIScrollViewDelegate>)holo_scrollDelegate {
    return self.holo_proxy.scrollDelegate;
}

- (void)setHolo_scrollDelegate:(id<UIScrollViewDelegate>)holo_scrollDelegate {
    self.holo_proxy.scrollDelegate = holo_scrollDelegate;
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

- (NSArray<HoloTableSectionProtocol> *)holo_sections {
    return self.holo_proxy.proxyData.sections;
}

- (void)setHolo_sections:(NSArray<HoloTableSectionProtocol> *)holo_sections {
    self.holo_proxy.proxyData.sections = holo_sections;
}

- (void)holo_addSection:(id<HoloTableSectionProtocol>)section {
    if (!section) return;
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holo_sections];
    [array addObject:section];
    self.holo_sections = array.copy;
}

- (void)holo_removeSection:(id<HoloTableSectionProtocol>)section {
    if (!section) return;
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holo_sections];
    [array removeObject:section];
    self.holo_sections = array.copy;
}

- (void)holo_insertSection:(id<HoloTableSectionProtocol>)section atIndex:(NSInteger)index {
    if (!section) return;
    
    if (index < 0) index = 0;
    if (index > self.holo_sections.count) index = self.holo_sections.count;
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holo_sections];
    [array insertObject:section atIndex:index];
    self.holo_sections = array.copy;
}

@end
