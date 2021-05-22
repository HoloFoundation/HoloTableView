//
//  UITableView+HoloDeprecated.h
//  HoloTableView
//
//  Created by 与佳期 on 2021/5/22.
//

#import <UIKit/UIKit.h>
@class HoloTableViewUpdateRowMaker;

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (HoloDeprecated)

- (void)holo_updateRows:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block
              inSection:(NSString *)tag DEPRECATED_MSG_ATTRIBUTE("Please use `holo_updateRowsInSection:block:` api instead.");

- (void)holo_updateRows:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block
              inSection:(NSString *)tag
    withReloadAnimation:(UITableViewRowAnimation)animation DEPRECATED_MSG_ATTRIBUTE("Please use `holo_updateRowsInSection:block:withReloadAnimation:` api instead.");

- (void)holo_remakeRows:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block
              inSection:(NSString *)tag DEPRECATED_MSG_ATTRIBUTE("Please use `holo_remakeRows:block:` api instead.");

- (void)holo_remakeRows:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block
              inSection:(NSString *)tag
    withReloadAnimation:(UITableViewRowAnimation)animation DEPRECATED_MSG_ATTRIBUTE("Please use `holo_remakeRows:block:withReloadAnimation:` api instead.");

@end

NS_ASSUME_NONNULL_END
