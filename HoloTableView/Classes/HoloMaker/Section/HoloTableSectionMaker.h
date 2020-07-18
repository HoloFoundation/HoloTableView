//
//  HoloTableSectionMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2020/6/2.
//

#import <Foundation/Foundation.h>
@class HoloTableSection, HoloTableViewRowMaker;

NS_ASSUME_NONNULL_BEGIN

@interface HoloTableSectionMaker : NSObject

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerTitle)(NSString *headerTitle);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerTitle)(NSString *footerTitle);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^header)(Class header);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footer)(Class footer);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerS)(NSString *headerS);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerS)(NSString *footerS);

#pragma mark - priority low
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerModel)(id headerModel);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerModel)(id footerModel);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerReuseId)(NSString *headerReuseId);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerReuseId)(NSString *footerReuseId);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerHeight)(CGFloat headerHeight);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerHeight)(CGFloat footerHeight);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerEstimatedHeight)(CGFloat headerEstimatedHeight);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerEstimatedHeight)(CGFloat footerEstimatedHeight);

#pragma mark - priority middle
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerModelHandler)(id (^)(void));

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerModelHandler)(id (^)(void));

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerReuseIdHandler)(NSString *(^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerReuseIdHandler)(NSString *(^)(id _Nullable model));

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


- (HoloTableSection *)fetchTableSection;

- (void)giveTableSection:(HoloTableSection *)section;

@end

NS_ASSUME_NONNULL_END
