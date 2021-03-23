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

- (NSArray *)holo_sections {
    return self.holo_proxy.proxyData.sections;
}

- (void)setHolo_sections:(NSArray *)sections {
    self.holo_proxy.proxyData.sections = sections;
}

- (void)holo_addSection:(HoloTableSection *)section {
    if (!section) return;
    
    NSMutableArray *sections = [NSMutableArray arrayWithArray:self.holo_sections];
    [sections addObject:section];
    self.holo_sections = sections;
}

- (void)holo_removeSection:(HoloTableSection *)section {
    if (!section) return;
    
    NSMutableArray *sections = [NSMutableArray arrayWithArray:self.holo_sections];
    [sections removeObject:section];
    self.holo_sections = sections;
}

- (void)holo_insertSection:(HoloTableSection *)section atIndex:(NSInteger)index {
    if (!section) return;
    
    if (index < 0) index = 0;
    if (index > self.holo_sections.count) index = self.holo_sections.count;
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holo_sections];
    [array insertObject:section atIndex:index];
    self.holo_sections = array;
}

@end
