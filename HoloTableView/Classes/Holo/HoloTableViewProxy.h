//
//  HoloTableViewProxy.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import <Foundation/Foundation.h>
#import "HoloTableViewProtocol.h"
@class HoloTableViewDataSource, HoloSection;

NS_ASSUME_NONNULL_BEGIN

@interface HoloTableViewProxy : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) HoloTableViewDataSource *holo_tableDataSource;

@property (nonatomic, weak) id<UIScrollViewDelegate> holo_tableScrollDelegate;

@property (nonatomic, weak) id<HoloTableViewDataSource> holo_overrideDataSource;

@property (nonatomic, weak) id<HoloTableViewDelegate> holo_overrideDelegate;

- (instancetype)initWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
