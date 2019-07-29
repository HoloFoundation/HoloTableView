//
//  HoloTableViewSectionMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import <Foundation/Foundation.h>
@class HoloRow, HoloUpdateRow;

NS_ASSUME_NONNULL_BEGIN

//============================================================:HoloSection
@interface HoloSection : NSObject

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy, nullable) NSArray<HoloRow *> *rows;

#pragma mark - header and footer
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, assign) CGFloat headerViewHeight;

@property (nonatomic, assign) CGFloat footerViewHeight;

@property (nonatomic, copy) void (^willDisplayHeaderViewHandler)(UIView *view);

@property (nonatomic, copy) void (^willDisplayFooterViewHandler)(UIView *view);

@property (nonatomic, copy) void (^didEndDisplayingHeaderViewHandler)(UIView *view);

@property (nonatomic, copy) void (^didEndDisplayingFooterViewHandler)(UIView *view);


- (void)holo_appendRows:(NSArray<HoloRow *> *)rows;

- (void)holo_updateRow:(HoloUpdateRow *)updateRow;

- (void)holo_removeRow:(NSString *)tag;

- (void)holo_removeAllRows;

@end

//============================================================:HoloSectionMaker
@interface HoloSectionMaker : NSObject

@property (nonatomic, strong, readonly) HoloSection *section;

@property (nonatomic, copy, readonly) HoloSectionMaker *(^headerView)(UIView *headerView);

@property (nonatomic, copy, readonly) HoloSectionMaker *(^footerView)(UIView *footerView);

@property (nonatomic, copy, readonly) HoloSectionMaker *(^headerViewHeight)(CGFloat headerViewHeight);

@property (nonatomic, copy, readonly) HoloSectionMaker *(^footerViewHeight)(CGFloat footerViewHeight);

@property (nonatomic, copy, readonly) HoloSectionMaker *(^willDisplayHeaderViewHandler)(void(^)(UIView *view));

@property (nonatomic, copy, readonly) HoloSectionMaker *(^willDisplayFooterViewHandler)(void(^)(UIView *view));

@property (nonatomic, copy, readonly) HoloSectionMaker *(^didEndDisplayingHeaderViewHandler)(void(^)(UIView *view));

@property (nonatomic, copy, readonly) HoloSectionMaker *(^didEndDisplayingFooterViewHandler)(void(^)(UIView *view));

@end

//============================================================:HoloTableViewSectionMaker
@interface HoloTableViewSectionMaker : NSObject

@property (nonatomic, copy, readonly) HoloSectionMaker *(^section)(NSString *tag);

- (NSArray<HoloSection *> *)install;

@end

NS_ASSUME_NONNULL_END
