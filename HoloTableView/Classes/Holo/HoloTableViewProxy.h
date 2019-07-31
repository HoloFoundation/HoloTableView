//
//  HoloTableViewProxy.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import <Foundation/Foundation.h>
@class HoloTableViewDataSource, HoloSection;

NS_ASSUME_NONNULL_BEGIN

@interface HoloTableViewProxy : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) HoloTableViewDataSource *holo_tableDataSource;

@property (nonatomic, weak) id<UIScrollViewDelegate> holo_overrideScrollDelegate;

- (instancetype)initWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
