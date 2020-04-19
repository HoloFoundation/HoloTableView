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
        
        if (!self.dataSource || !self.delegate) {
            self.dataSource = tableViewProxy;
            self.delegate = tableViewProxy;
            
            // register UITableViewHeaderFooterView
            Class headerFooterCls = UITableViewHeaderFooterView.class;
            NSString *headerFooter = NSStringFromClass(headerFooterCls);
            [self registerClass:headerFooterCls forHeaderFooterViewReuseIdentifier:headerFooter];
            NSMutableDictionary *headerFootersMap = tableViewProxy.proxyData.headerFootersMap.mutableCopy;
            headerFootersMap[headerFooter] = headerFooterCls;
            tableViewProxy.proxyData.headerFootersMap = headerFootersMap;
        }
    }
    return tableViewProxy;
}

@end
