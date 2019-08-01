//
//  HoloTableViewProxy.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import <Foundation/Foundation.h>
#import "HoloTableViewProtocol.h"
@class HoloTableViewProxyData;

NS_ASSUME_NONNULL_BEGIN

@interface HoloTableViewProxy : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) HoloTableViewProxyData *holo_proxyData;

@property (nonatomic, weak) id<UIScrollViewDelegate> holo_scrollDelegate;

@property (nonatomic, weak) id<HoloTableViewDataSource> holo_dataSource;

@property (nonatomic, weak) id<HoloTableViewDelegate> holo_delegate;

- (instancetype)initWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
