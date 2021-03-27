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

/**
 *  Proxy data.
 */
@property (nonatomic, strong) HoloTableViewProxyData *proxyData;

/**
 *  The delegate of the scroll-view object.
 */
@property (nonatomic, weak, nullable) id<UIScrollViewDelegate> scrollDelegate;

@property (nonatomic, weak, nullable) id<HoloTableViewDataSource> dataSource;

@property (nonatomic, weak, nullable) id<HoloTableViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
