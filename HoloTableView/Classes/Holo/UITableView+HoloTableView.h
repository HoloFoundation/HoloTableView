//
//  UITableView+HoloTableView.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import <UIKit/UIKit.h>
@class HoloTableViewConfiger, HoloTableViewRowMaker, HoloTableViewSectionMaker, HoloTableViewUpdateRowMaker;

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (HoloTableView)

// 配置 cell 与 cls 的对应关系
- (void)holo_configTableView:(void(^)(HoloTableViewConfiger *configer))block;

// 操作 section
- (void)holo_makeSection:(void(^)(HoloTableViewSectionMaker *make))block;

- (void)holo_updateSection:(void(^)(HoloTableViewSectionMaker *make))block;

- (void)holo_removeAllSection;

- (void)holo_removeSection:(NSString *)tag;

// 操作 row
- (void)holo_makeRows:(void(^)(HoloTableViewRowMaker *make))block;

- (void)holo_updateRows:(void(^)(HoloTableViewUpdateRowMaker *make))block;

- (void)holo_makeRowsInSection:(NSString *)tag block:(void(^)(HoloTableViewRowMaker *make))block;

- (void)holo_removeAllRowsInSection:(NSString *)tag;

- (void)holo_removeRow:(NSString *)tag;

@end

NS_ASSUME_NONNULL_END
