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
            NSString *reuseIdentifier = @"UITableViewHeaderFooterView";
            Class headerFooterCls = NSClassFromString(@"UITableViewHeaderFooterView");
            [self registerClass:headerFooterCls forHeaderFooterViewReuseIdentifier:reuseIdentifier];
            NSMutableDictionary *headerFooterMap = tableViewProxy.holo_proxyData.holo_headerFooterMap.mutableCopy;
            headerFooterMap[reuseIdentifier] = headerFooterCls;
            tableViewProxy.holo_proxyData.holo_headerFooterMap = headerFooterMap;
        }
    }
    return tableViewProxy;
}

@end
