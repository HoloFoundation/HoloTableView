//
//  HoloTableViewSectionMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import <Foundation/Foundation.h>
@class HoloTableRow, HoloTableViewRowMaker;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HoloTableViewSectionMakerType) {
    HoloTableViewSectionMakerTypeMake,
    HoloTableViewSectionMakerTypeInsert,
    HoloTableViewSectionMakerTypeUpdate,
    HoloTableViewSectionMakerTypeRemake
};

////////////////////////////////////////////////////////////
@interface HoloTableSection : NSObject

@property (nonatomic, copy, nullable) NSArray<HoloTableRow *> *rows;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *header;

@property (nonatomic, copy) NSString *footer;

#pragma mark - priority low
@property (nonatomic, strong) id headerModel;

@property (nonatomic, strong) id footerModel;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) CGFloat footerHeight;

@property (nonatomic, assign) CGFloat headerEstimatedHeight;

@property (nonatomic, assign) CGFloat footerEstimatedHeight;

#pragma mark - priority middle
@property (nonatomic, copy) id (^headerModelHandler)(id _Nullable model);

@property (nonatomic, copy) id (^footerModelHandler)(id _Nullable model);

@property (nonatomic, copy) CGFloat (^headerHeightHandler)(id _Nullable model);

@property (nonatomic, copy) CGFloat (^footerHeightHandler)(id _Nullable model);

@property (nonatomic, copy) CGFloat (^headerEstimatedHeightHandler)(id _Nullable model);

@property (nonatomic, copy) CGFloat (^footerEstimatedHeightHandler)(id _Nullable model);

@property (nonatomic, copy) void (^willDisplayHeaderHandler)(UIView *header, id _Nullable model);

@property (nonatomic, copy) void (^willDisplayFooterHandler)(UIView *footer, id _Nullable model);

@property (nonatomic, copy) void (^didEndDisplayingHeaderHandler)(UIView *header, id _Nullable model);

@property (nonatomic, copy) void (^didEndDisplayingFooterHandler)(UIView *footer, id _Nullable model);

#pragma mark - priority high
@property (nonatomic, assign) SEL headerConfigSEL;

@property (nonatomic, assign) SEL footerConfigSEL;

@property (nonatomic, assign) SEL headerHeightSEL;

@property (nonatomic, assign) SEL footerHeightSEL;

@property (nonatomic, assign) SEL headerEstimatedHeightSEL;

@property (nonatomic, assign) SEL footerEstimatedHeightSEL;

@property (nonatomic, assign) SEL headerFooterConfigSEL;
@property (nonatomic, assign) SEL headerFooterHeightSEL;
@property (nonatomic, assign) SEL headerFooterEstimatedHeightSEL;

@property (nonatomic, assign) SEL willDisplayHeaderSEL;

@property (nonatomic, assign) SEL willDisplayFooterSEL;

@property (nonatomic, assign) SEL didEndDisplayingHeaderSEL;

@property (nonatomic, assign) SEL didEndDisplayingFooterSEL;


- (NSIndexSet *)insertRows:(NSArray<HoloTableRow *> *)rows atIndex:(NSInteger)index;

- (void)removeRow:(HoloTableRow *)row;

- (void)removeAllRows;

@end

////////////////////////////////////////////////////////////
@interface HoloTableSectionMaker : NSObject

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^header)(Class header);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footer)(Class footer);
// header string
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerS)(NSString *headerS);
// footer string
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerS)(NSString *footerS);

#pragma mark - priority low
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerModel)(id headerModel);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerModel)(id footerModel);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerHeight)(CGFloat headerHeight);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerHeight)(CGFloat footerHeight);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerEstimatedHeight)(CGFloat headerEstimatedHeight);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerEstimatedHeight)(CGFloat footerEstimatedHeight);

#pragma mark - priority middle
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerModelHandler)(id (^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerModelHandler)(id (^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerHeightHandler)(CGFloat (^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerHeightHandler)(CGFloat (^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerEstimatedHeightHandler)(CGFloat (^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerEstimatedHeightHandler)(CGFloat (^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^willDisplayHeaderHandler)(void(^)(UIView *header, id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^willDisplayFooterHandler)(void(^)(UIView *footer, id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^didEndDisplayingHeaderHandler)(void(^)(UIView *header, id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^didEndDisplayingFooterHandler)(void(^)(UIView *footer, id _Nullable model));

#pragma mark - priority high
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerConfigSEL)(SEL headerConfigSEL);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerConfigSEL)(SEL footerConfigSEL);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerHeightSEL)(SEL headerHeightSEL);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerHeightSEL)(SEL footerHeightSEL);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerEstimatedHeightSEL)(SEL headerEstimatedHeightSEL);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerEstimatedHeightSEL)(SEL footerEstimatedHeightSEL);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerFooterConfigSEL)(SEL headerFooterConfigSEL) DEPRECATED_MSG_ATTRIBUTE("Please use `headerConfigSEL` or `footerConfigSEL` api instead.");
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerFooterHeightSEL)(SEL headerFooterHeightSEL) DEPRECATED_MSG_ATTRIBUTE("Please use `headerHeightSEL` or `footerHeightSEL` api instead.");
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerFooterEstimatedHeightSEL)(SEL headerFooterEstimatedHeightSEL) DEPRECATED_MSG_ATTRIBUTE("Please use `headerEstimatedHeightSEL` or `footerEstimatedHeightSEL` api instead.");

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^willDisplayHeaderSEL)(SEL willDisplayHeaderSEL);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^willDisplayFooterSEL)(SEL willDisplayFooterSEL);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^didEndDisplayingHeaderSEL)(SEL didEndDisplayingHeaderSEL);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^didEndDisplayingFooterSEL)(SEL didEndDisplayingFooterSEL);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^makeRows)(void(NS_NOESCAPE ^)(HoloTableViewRowMaker *make));

@end


////////////////////////////////////////////////////////////
@interface HoloTableViewSectionMakerModel : NSObject

@property (nonatomic, strong) HoloTableSection *operateSection;

@property (nonatomic, strong) NSNumber *operateIndex;

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewSectionMaker : NSObject

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^section)(NSString *tag);

- (instancetype)initWithProxyDataSections:(NSArray<HoloTableSection *> *)sections
                                makerType:(HoloTableViewSectionMakerType)makerType;

- (NSArray<HoloTableViewSectionMakerModel *> *)install;

@end

NS_ASSUME_NONNULL_END
