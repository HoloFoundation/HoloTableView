//
//  HoloTableViewSectionMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import <Foundation/Foundation.h>
@class HoloRow, HoloUpdateRow;

NS_ASSUME_NONNULL_BEGIN

////////////////////////////////////////////////////////////
@interface HoloSection : NSObject

@property (nonatomic, copy, nullable) NSArray<HoloRow *> *rows;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, strong) NSString *header;

@property (nonatomic, strong) NSString *footer;

@property (nonatomic, strong) id headerModel;

@property (nonatomic, strong) id footerModel;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) CGFloat footerHeight;

@property (nonatomic, assign) CGFloat headerEstimatedHeight;

@property (nonatomic, assign) CGFloat footerEstimatedHeight;

@property (nonatomic, assign) SEL headerFooterConfigSEL;

@property (nonatomic, assign) SEL headerFooterHeightSEL;

@property (nonatomic, assign) SEL headerFooterEstimatedHeightSEL;

@property (nonatomic, copy) void (^willDisplayHeaderHandler)(UIView *header);

@property (nonatomic, copy) void (^willDisplayFooterHandler)(UIView *footer);

@property (nonatomic, copy) void (^didEndDisplayingHeaderHandler)(UIView *header);

@property (nonatomic, copy) void (^didEndDisplayingFooterHandler)(UIView *footer);

- (NSIndexSet *)holo_appendRows:(NSArray<HoloRow *> *)rows;

- (void)holo_removeRow:(HoloRow *)row;

- (void)holo_removeAllRows;

@end

////////////////////////////////////////////////////////////
@interface HoloSectionMaker : NSObject

@property (nonatomic, strong, readonly) HoloSection *section;

@property (nonatomic, copy, readonly) HoloSectionMaker *(^header)(NSString *header);

@property (nonatomic, copy, readonly) HoloSectionMaker *(^footer)(NSString *footer);

@property (nonatomic, copy, readonly) HoloSectionMaker *(^headerModel)(id headerModel);

@property (nonatomic, copy, readonly) HoloSectionMaker *(^footerModel)(id footerModel);

@property (nonatomic, copy, readonly) HoloSectionMaker *(^headerHeight)(CGFloat headerHeight);

@property (nonatomic, copy, readonly) HoloSectionMaker *(^footerHeight)(CGFloat footerHeight);

@property (nonatomic, copy, readonly) HoloSectionMaker *(^headerEstimatedHeight)(CGFloat headerEstimatedHeight);

@property (nonatomic, copy, readonly) HoloSectionMaker *(^footerEstimatedHeight)(CGFloat footerEstimatedHeight);

@property (nonatomic, copy, readonly) HoloSectionMaker *(^headerFooterConfigSEL)(SEL headerConfigSEL);

@property (nonatomic, copy, readonly) HoloSectionMaker *(^headerFooterHeightSEL)(SEL headerHeightSEL);

@property (nonatomic, copy, readonly) HoloSectionMaker *(^headerFooterEstimatedHeightSEL)(SEL headerEstimatedHeightSEL);

@property (nonatomic, copy, readonly) HoloSectionMaker *(^willDisplayHeaderHandler)(void(^)(UIView *header));

@property (nonatomic, copy, readonly) HoloSectionMaker *(^willDisplayFooterHandler)(void(^)(UIView *footer));

@property (nonatomic, copy, readonly) HoloSectionMaker *(^didEndDisplayingHeaderHandler)(void(^)(UIView *header));

@property (nonatomic, copy, readonly) HoloSectionMaker *(^didEndDisplayingFooterHandler)(void(^)(UIView *footer));

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewSectionMaker : NSObject

@property (nonatomic, copy, readonly) HoloSectionMaker *(^section)(NSString *  _Nullable tag);

- (instancetype)initWithProxyDataSections:(NSArray<HoloSection *> *)sections;

- (NSArray<NSDictionary *> *)install;

@end

NS_ASSUME_NONNULL_END
