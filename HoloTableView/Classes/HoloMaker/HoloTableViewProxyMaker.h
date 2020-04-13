//
//  HoloTableViewProxyMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2020/4/14.
//

#import <Foundation/Foundation.h>
#import "HoloTableViewProxy.h"

NS_ASSUME_NONNULL_BEGIN

////////////////////////////////////////////////////////////
@interface HoloTableViewProxyModel : NSObject

@property (nonatomic, strong) id<UIScrollViewDelegate> scrollDelegate;

@property (nonatomic, strong) id<HoloTableViewDataSource> dataSource;

@property (nonatomic, strong) id<HoloTableViewDelegate> delegate;

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewProxyMaker : NSObject

@property (nonatomic, copy, readonly) HoloTableViewProxyMaker *(^delegate)(id<HoloTableViewDelegate> delegate);

@property (nonatomic, copy, readonly) HoloTableViewProxyMaker *(^dataSource)(id<HoloTableViewDataSource> dataSource);

@property (nonatomic, copy, readonly) HoloTableViewProxyMaker *(^scrollDelegate)(id<UIScrollViewDelegate> scrollDelegate);

- (HoloTableViewProxyModel *)install;

@end

NS_ASSUME_NONNULL_END
