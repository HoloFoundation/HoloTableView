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

@property (nonatomic, strong) HoloTableViewProxyData *proxyData;

@property (nonatomic, weak) id<UIScrollViewDelegate> scrollDelegate;

@property (nonatomic, weak) id<HoloTableViewDataSource> dataSource;

@property (nonatomic, weak) id<HoloTableViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
