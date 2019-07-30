//
//  UITableView+HoloTableViewProxy.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import <UIKit/UIKit.h>
@class HoloTableViewProxy, HoloTableViewDataSource;

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (HoloTableViewProxy)

@property (nonatomic, strong, readonly) HoloTableViewProxy *holo_tableViewProxy;

@property (nonatomic, strong, readonly) HoloTableViewDataSource *holo_tableDataSource;

@property (nonatomic, weak) id<UIScrollViewDelegate> holo_tableScrollDelegate;

@end

NS_ASSUME_NONNULL_END
