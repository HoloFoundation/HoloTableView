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

/**
 *  Make a headerwith  class.
 */
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^header)(Class header);

/**
 *  Make a footer with class.
 */
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footer)(Class footer);

/**
 *  Set the reuse identifier for the header using the `headerReuseId` property.
 *
 *  If the `headerReuseIdHandler` property is nil, then use the `headerReuseId` property.
 */
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerReuseId)(NSString *headerReuseId);
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerReuseIdHandler)(NSString *(^)(id _Nullable model));

/**
 *  Set the reuse identifier for the footer using the `footerReuseId` property.
 *
 *  If the `footerReuseIdHandler` property is nil, then use the `footerReuseId` property.
 */
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerReuseId)(NSString *footerReuseId);
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerReuseIdHandler)(NSString *(^)(id _Nullable model));

/**
 *  Set the header title for the section using the `headerTitle` property.
 *
 *  If you set 'header', the `headerTitleHandler` property and  `headerTitle` property will be invalid.
 *
 *  If the `headerTitleHandler` property is nil, then use the `headerTitle` property.
 */
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerTitle)(NSString *headerTitle);
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerTitleHandler)(NSString *(^)(void));

/**
 *  Set the footer title for the section using the `footerTitle` property.
 *
 *  If you set 'footer', the `footerTitleHandler` property and  `footerTitle` property will be invalid.
 *
 *  If the `footerTitleHandler` property is nil, then use the `footerTitle` property.
 */
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerTitle)(NSString *footerTitle);
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerTitleHandler)(NSString *(^)(void));

/**
 *  Set the data for the header using the `headerModel` property.
 *
 *  If the `headerModelHandler` property is nil, then use the `headerModel` property.
 */
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerModel)(id headerModel);
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerModelHandler)(id (^)(void));

/**
 *  Set the data for the footer using the `footerModel` property.
 *
 *  If the `footerModelHandler` property is nil, then use the `footerModel` property.
 */
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerModel)(id footerModel);
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerModelHandler)(id (^)(void));

/**
 * The header must implement the `headerConfigSEL` property setting method in order for the HoloTableView to pass the model for the header.
 */
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerConfigSEL)(SEL headerConfigSEL);

/**
 * The footer must implement the `footerConfigSEL` property setting method in order for the HoloTableView to pass the model for the footer.
 */
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerConfigSEL)(SEL footerConfigSEL);

/**
 *  Set the height for the header using the `headerHeight` property.
 *
 *  If the `headerHeightSEL` property is nil or the header don't implement the `headerHeightSEL` property setting method, then use the `headerHeightHandler` property.
 *  If the `headerHeightHandler` property is nil, then use the `headerHeight` property.
 */
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerHeight)(CGFloat headerHeight);
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerHeightHandler)(CGFloat (^)(id _Nullable model));
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerHeightSEL)(SEL headerHeightSEL);

/**
 *  Set the height for the footer using the `footerHeight` property.
 *
 *  If the `footerHeightSEL` property is nil or the footer don't implement the `footerHeightSEL` property setting method, then use the `footerHeightHandler` property.
 *  If the `footerHeightHandler` property is nil, then use the `footerHeight` property.
 */
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerHeight)(CGFloat footerHeight);
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerHeightHandler)(CGFloat (^)(id _Nullable model));
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerHeightSEL)(SEL footerHeightSEL);

/**
 *  Set the estimated height for the header using the `headerEstimatedHeight` property.
 *
 *  If the `headerEstimatedHeightSEL` property is nil or the header don't implement the `headerEstimatedHeightSEL` property setting method, then use the `headerEstimatedHeightHandler` property.
 *  If the `headerEstimatedHeightHandler` property is nil, then use the `headerEstimatedHeight` property.
 */
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerEstimatedHeight)(CGFloat headerEstimatedHeight);
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerEstimatedHeightHandler)(CGFloat (^)(id _Nullable model));
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerEstimatedHeightSEL)(SEL headerEstimatedHeightSEL);

/**
 *  Set the estimated height for the footer using the `footerEstimatedHeight` property.
 *
 *  If the `footerEstimatedHeightSEL` property is nil or the footer don't implement the `footerEstimatedHeightSEL` property setting method, then use the `footerEstimatedHeightHandler` property.
 *  If the `footerEstimatedHeightHandler` property is nil, then use the `footerEstimatedHeight` property.
 */
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerEstimatedHeight)(CGFloat footerEstimatedHeight);
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerEstimatedHeightHandler)(CGFloat (^)(id _Nullable model));
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerEstimatedHeightSEL)(SEL footerEstimatedHeightSEL);

/**
 *  If the header will display, the `willDisplayHeaderHandler` will be called.
 *
 *  If the `willDisplayHeaderSEL` property is nil or the header don't implement the `willDisplayHeaderSEL` property setting method, then use the `willDisplayHeaderHandler` property.
 */
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^willDisplayHeaderHandler)(void(^)(UIView *header, id _Nullable model));
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^willDisplayHeaderSEL)(SEL willDisplayHeaderSEL);

/**
 *  If the footer will display, the `willDisplayFooterSEL` will be called.
 *
 *  If the `willDisplayFooterSEL` property is nil or the footer don't implement the `willDisplayFooterSEL` property setting method, then use the `willDisplayFooterHandler` property.
 */
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^willDisplayFooterHandler)(void(^)(UIView *footer, id _Nullable model));
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^willDisplayFooterSEL)(SEL willDisplayFooterSEL);

/**
 *  If the header did end displaying, the `didEndDisplayingHeaderHandler` will be called.
 *
 *  If the `didEndDisplayingHeaderSEL` property is nil or the header don't implement the `didEndDisplayingHeaderSEL` property setting method, then use the `didEndDisplayingHeaderHandler` property.
 */
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^didEndDisplayingHeaderHandler)(void(^)(UIView *header, id _Nullable model));
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^didEndDisplayingHeaderSEL)(SEL didEndDisplayingHeaderSEL);

/**
 *  If the footer did end displaying, the `didEndDisplayingFooterHandler` will be called.
 *
 *  If the `didEndDisplayingFooterSEL` property is nil or the footer don't implement the `didEndDisplayingFooterSEL` property setting method, then use the `didEndDisplayingFooterHandler` property.
 */
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^didEndDisplayingFooterHandler)(void(^)(UIView *footer, id _Nullable model));
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^didEndDisplayingFooterSEL)(SEL didEndDisplayingFooterSEL);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^makeRows)(void(NS_NOESCAPE ^)(HoloTableViewRowMaker *make));


- (HoloTableSection *)fetchTableSection;

- (void)giveTableSection:(HoloTableSection *)section;

@end

NS_ASSUME_NONNULL_END
