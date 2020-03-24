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
            NSString *headerFooter = @"UITableViewHeaderFooterView";
            Class headerFooterCls = NSClassFromString(headerFooter);
            [self registerClass:headerFooterCls forHeaderFooterViewReuseIdentifier:headerFooter];
            NSMutableDictionary *headerFooterMap = tableViewProxy.proxyData.holo_headerFooterMap.mutableCopy;
            headerFooterMap[headerFooter] = headerFooterCls;
            tableViewProxy.proxyData.holo_headerFooterMap = headerFooterMap;
        }
    }
    return tableViewProxy;
}

@end
