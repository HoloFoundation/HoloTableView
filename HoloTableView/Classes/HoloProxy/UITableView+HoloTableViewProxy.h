//
//  UITableView+HoloTableViewProxy.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import <UIKit/UIKit.h>
@class HoloTableViewProxy;

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (HoloTableViewProxy)

@property (nonatomic, strong, readonly) HoloTableViewProxy *holo_proxy;

@end

NS_ASSUME_NONNULL_END
