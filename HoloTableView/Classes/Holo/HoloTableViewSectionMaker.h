//
//  HoloTableViewSectionMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import <Foundation/Foundation.h>
@class HoloTableRow;

NS_ASSUME_NONNULL_BEGIN

static NSString * const kHoloTargetSection = @"holo_target_section";
static NSString * const kHoloTargetIndex = @"holo_target_index";
static NSString * const kHoloUpdateSection = @"holo_update_section";
static NSString * const kHoloSectionTagNil = @"holo_section_tag_nil";


////////////////////////////////////////////////////////////
@interface HoloTableSection : NSObject

@property (nonatomic, copy, nullable) NSArray<HoloTableRow *> *rows;

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

- (NSIndexSet *)holo_insertRows:(NSArray<HoloTableRow *> *)rows atIndex:(NSInteger)index;

- (void)holo_removeRow:(HoloTableRow *)row;

- (void)holo_removeAllRows;

@end

////////////////////////////////////////////////////////////
@interface HoloTableSectionMaker : NSObject

@property (nonatomic, strong, readonly) HoloTableSection *section;

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^header)(NSString *header);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footer)(NSString *footer);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerModel)(id headerModel);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerModel)(id footerModel);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerHeight)(CGFloat headerHeight);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerHeight)(CGFloat footerHeight);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerEstimatedHeight)(CGFloat headerEstimatedHeight);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerEstimatedHeight)(CGFloat footerEstimatedHeight);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerFooterConfigSEL)(SEL headerConfigSEL);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerFooterHeightSEL)(SEL headerHeightSEL);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerFooterEstimatedHeightSEL)(SEL headerEstimatedHeightSEL);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^willDisplayHeaderHandler)(void(^)(UIView *header));

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^willDisplayFooterHandler)(void(^)(UIView *footer));

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^didEndDisplayingHeaderHandler)(void(^)(UIView *header));

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^didEndDisplayingFooterHandler)(void(^)(UIView *footer));

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewSectionMaker : NSObject

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^section)(NSString *  _Nullable tag);

- (instancetype)initWithProxyDataSections:(NSArray<HoloTableSection *> *)sections isRemark:(BOOL)isRemark;

- (NSArray<NSDictionary *> *)install;

@end

NS_ASSUME_NONNULL_END
