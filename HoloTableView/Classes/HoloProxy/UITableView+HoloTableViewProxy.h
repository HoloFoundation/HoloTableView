//
//  UITableView+HoloTableViewProxy.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import <UIKit/UIKit.h>
@class HoloTableViewProxy, HoloTableSection;

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (HoloTableViewProxy)

@property (nonatomic, strong) HoloTableViewProxy *holo_proxy;

@property (nonatomic, copy) NSArray<HoloTableSection *> *holo_sections;

- (void)holo_addSection:(HoloTableSection *)section;

- (void)holo_removeSection:(HoloTableSection *)section;

- (void)holo_insertSection:(HoloTableSection *)section atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
