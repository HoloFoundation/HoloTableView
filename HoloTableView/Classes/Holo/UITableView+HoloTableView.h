//
//  UITableView+HoloTableView.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import <UIKit/UIKit.h>
@class HoloTableViewMaker, HoloTableViewConfiger;

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (HoloTableView)

- (void)holo_configTableView:(void(^)(HoloTableViewConfiger *configer))block;

- (void)holo_makeSection:(void(^)(HoloTableViewMaker *make))block;

- (void)holo_updateSection:(void(^)(HoloTableViewMaker *make))block;

- (void)holo_deleteAllSection;

- (void)holo_deleteSection:(NSString *)tag;

@end

NS_ASSUME_NONNULL_END
