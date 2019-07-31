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
@property (nonatomic, strong) UIView *header;

@property (nonatomic, strong) UIView *footer;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) CGFloat footerHeight;

@property (nonatomic, copy) void (^willDisplayHeaderHandler)(UIView *header) NS_AVAILABLE_IOS(6_0);

@property (nonatomic, copy) void (^willDisplayFooterHandler)(UIView *footer) NS_AVAILABLE_IOS(6_0);

@property (nonatomic, copy) void (^didEndDisplayingHeaderHandler)(UIView *header) NS_AVAILABLE_IOS(6_0);

@property (nonatomic, copy) void (^didEndDisplayingFooterHandler)(UIView *footer) NS_AVAILABLE_IOS(6_0);


- (void)holo_appendRows:(NSArray<HoloRow *> *)rows;

- (void)holo_updateRow:(HoloUpdateRow *)updateRow;

- (void)holo_removeRow:(NSString *)tag;

- (void)holo_removeAllRows;

@end

//============================================================:HoloSectionMaker
@interface HoloSectionMaker : NSObject

@property (nonatomic, strong, readonly) HoloSection *section;

@property (nonatomic, copy, readonly) HoloSectionMaker *(^header)(UIView *header);

@property (nonatomic, copy, readonly) HoloSectionMaker *(^footer)(UIView *footer);

@property (nonatomic, copy, readonly) HoloSectionMaker *(^headerHeight)(CGFloat headerHeight);

@property (nonatomic, copy, readonly) HoloSectionMaker *(^footerHeight)(CGFloat footerHeight);

@property (nonatomic, copy, readonly) HoloSectionMaker *(^willDisplayHeaderHandler)(void(^)(UIView *header)) NS_AVAILABLE_IOS(6_0);

@property (nonatomic, copy, readonly) HoloSectionMaker *(^willDisplayFooterHandler)(void(^)(UIView *footer)) NS_AVAILABLE_IOS(6_0);

@property (nonatomic, copy, readonly) HoloSectionMaker *(^didEndDisplayingHeaderHandler)(void(^)(UIView *header)) NS_AVAILABLE_IOS(6_0);

@property (nonatomic, copy, readonly) HoloSectionMaker *(^didEndDisplayingFooterHandler)(void(^)(UIView *footer)) NS_AVAILABLE_IOS(6_0);

@end

//============================================================:HoloTableViewSectionMaker
@interface HoloTableViewSectionMaker : NSObject

@property (nonatomic, copy, readonly) HoloSectionMaker *(^section)(NSString *tag);

- (NSArray<HoloSection *> *)install;

@end

NS_ASSUME_NONNULL_END
