//
//  UITableView+HoloTableViewProxy.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import <UIKit/UIKit.h>
#import "HoloTableSectionProtocol.h"
@class HoloTableViewProxy;

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (HoloTableViewProxy)

@property (nonatomic, strong) HoloTableViewProxy *holo_proxy;

@property (nonatomic, copy) NSArray<HoloTableSectionProtocol> *holo_sections;

- (void)holo_addSection:(id<HoloTableSectionProtocol>)section;

- (void)holo_removeSection:(id<HoloTableSectionProtocol>)section;

- (void)holo_insertSection:(id<HoloTableSectionProtocol>)section atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
