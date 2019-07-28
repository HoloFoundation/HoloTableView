//
//  HoloTableViewSectionMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import <Foundation/Foundation.h>
@class HoloSection, HoloTableViewSectionMaker;

NS_ASSUME_NONNULL_BEGIN

@interface HoloTableViewSectionMaker : NSObject

@property (nonatomic, strong, readonly) HoloSection *section;

@property (nonatomic, copy, readonly) HoloTableViewSectionMaker *(^headerView)(UIView *headerView);

@property (nonatomic, copy, readonly) HoloTableViewSectionMaker *(^footerView)(UIView *footerView);

@property (nonatomic, copy, readonly) HoloTableViewSectionMaker *(^headerViewHeight)(CGFloat headerViewHeight);

@property (nonatomic, copy, readonly) HoloTableViewSectionMaker *(^footerViewHeight)(CGFloat footerViewHeight);

@end

NS_ASSUME_NONNULL_END
