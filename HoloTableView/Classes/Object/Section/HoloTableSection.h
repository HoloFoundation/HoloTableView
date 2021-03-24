//
//  HoloTableSection.h
//  HoloTableView
//
//  Created by 与佳期 on 2020/6/2.
//

#import <Foundation/Foundation.h>
#import "HoloTableRowProtocol.h"
#import "HoloTableSectionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface HoloTableSection : NSObject <HoloTableSectionProtocol>

/**
 *  Set the rows for the section using the `rows` property.
 */
@property (nonatomic, copy) NSArray<HoloTableRowProtocol> *rows;

/**
 *  Set the tag for the section using the `tag` property.
 */
@property (nonatomic, copy, nullable) NSString *tag;

/**
 *  header class.
 */
@property (nonatomic, assign, nullable) Class header;

/**
 *  footer class.
 */
@property (nonatomic, assign, nullable) Class footer;

/**
 *  Set the header title for the section using the `headerTitle` property.
 *
 *  If you set 'header', the `headerTitleHandler` property and  `headerTitle` property will be invalid.
 *
 *  If the `headerTitleHandler` property is nil, then use the `headerTitle` property.
 */
@property (nonatomic, copy, nullable) NSString *headerTitle;
@property (nonatomic, copy, nullable) NSString *(^headerTitleHandler)(void);

/**
 *  Set the footer title for the section using the `footerTitle` property.
 *
 *  If you set 'footer', the `footerTitleHandler` property and  `footerTitle` property will be invalid.
 *
 *  If the `footerTitleHandler` property is nil, then use the `footerTitle` property.
 */
@property (nonatomic, copy, nullable) NSString *footerTitle;
@property (nonatomic, copy, nullable) NSString *(^footerTitleHandler)(void);

/**
 *  Set the data for the header using the `headerModel` property.
 *
 *  If the `headerModelHandler` property is nil, then use the `headerModel` property.
 */
@property (nonatomic, strong, nullable) id headerModel;
@property (nonatomic, copy, nullable) id (^headerModelHandler)(void);

/**
 *  Set the data for the footer using the `footerModel` property.
 *
 *  If the `footerModelHandler` property is nil, then use the `footerModel` property.
 */
@property (nonatomic, strong, nullable) id footerModel;
@property (nonatomic, copy, nullable) id (^footerModelHandler)(void);

/**
 * The header must implement the `headerConfigSEL` property setting method, set data for the header by `headerConfigSEL`.
 */
@property (nonatomic, assign) SEL headerConfigSEL;

/**
 * The footer must implement the `footerConfigSEL` property setting method, set data for the footer by `footerConfigSEL`.
 */
@property (nonatomic, assign) SEL footerConfigSEL;

/**
 *  Set the reuse identifier for the header using the `headerReuseId` property.
 *
 *  If the `headerReuseIdHandler` property is nil, then use the `headerReuseId` property.
 */
@property (nonatomic, copy, nullable) NSString *headerReuseId;
@property (nonatomic, copy, nullable) NSString *(^headerReuseIdHandler)(id _Nullable model);

/**
 *  Set the reuse identifier for the footer using the `footerReuseId` property.
 *
 *  If the `footerReuseIdHandler` property is nil, then use the `footerReuseId` property.
 */
@property (nonatomic, copy, nullable) NSString *footerReuseId;
@property (nonatomic, copy, nullable) NSString *(^footerReuseIdHandler)(id _Nullable model);

/**
 *  Set the height for the header using the `headerHeight` property.
 *
 *  If the `headerHeightSEL` property is nil or the header don't implement the `headerHeightSEL` property setting method, then use the `headerHeightHandler` property.
 *  If the `headerHeightHandler` property is nil, then use the `headerHeight` property.
 */
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, copy, nullable) CGFloat (^headerHeightHandler)(id _Nullable model);
@property (nonatomic, assign) SEL headerHeightSEL;

/**
 *  Set the height for the footer using the `footerHeight` property.
 *
 *  If the `footerHeightSEL` property is nil or the footer don't implement the `footerHeightSEL` property setting method, then use the `footerHeightHandler` property.
 *  If the `footerHeightHandler` property is nil, then use the `footerHeight` property.
 */
@property (nonatomic, assign) CGFloat footerHeight;
@property (nonatomic, copy, nullable) CGFloat (^footerHeightHandler)(id _Nullable model);
@property (nonatomic, assign) SEL footerHeightSEL;

/**
 *  Set the estimated height for the header using the `headerEstimatedHeight` property.
 *
 *  If the `headerEstimatedHeightSEL` property is nil or the header don't implement the `headerEstimatedHeightSEL` property setting method, then use the `headerEstimatedHeightHandler` property.
 *  If the `headerEstimatedHeightHandler` property is nil, then use the `headerEstimatedHeight` property.
 */
@property (nonatomic, assign) CGFloat headerEstimatedHeight;
@property (nonatomic, copy, nullable) CGFloat (^headerEstimatedHeightHandler)(id _Nullable model);
@property (nonatomic, assign) SEL headerEstimatedHeightSEL;

/**
 *  Set the estimated height for the footer using the `footerEstimatedHeight` property.
 *
 *  If the `footerEstimatedHeightSEL` property is nil or the footer don't implement the `footerEstimatedHeightSEL` property setting method, then use the `footerEstimatedHeightHandler` property.
 *  If the `footerEstimatedHeightHandler` property is nil, then use the `footerEstimatedHeight` property.
 */
@property (nonatomic, assign) CGFloat footerEstimatedHeight;
@property (nonatomic, copy, nullable) CGFloat (^footerEstimatedHeightHandler)(id _Nullable model);
@property (nonatomic, assign) SEL footerEstimatedHeightSEL;

/**
 *  If the header will display, the `willDisplayHeaderHandler` will be called.
 *
 *  If the `willDisplayHeaderSEL` property is nil or the header don't implement the `willDisplayHeaderSEL` property setting method, then use the `willDisplayHeaderHandler` property.
 */
@property (nonatomic, copy, nullable) void (^willDisplayHeaderHandler)(UIView *header, id _Nullable model);
@property (nonatomic, assign) SEL willDisplayHeaderSEL;

/**
 *  If the footer will display, the `willDisplayFooterSEL` will be called.
 *
 *  If the `willDisplayFooterSEL` property is nil or the footer don't implement the `willDisplayFooterSEL` property setting method, then use the `willDisplayFooterHandler` property.
 */
@property (nonatomic, copy, nullable) void (^willDisplayFooterHandler)(UIView *footer, id _Nullable model);
@property (nonatomic, assign) SEL willDisplayFooterSEL;

/**
 *  If the header did end displaying, the `didEndDisplayingHeaderHandler` will be called.
 *
 *  If the `didEndDisplayingHeaderSEL` property is nil or the header don't implement the `didEndDisplayingHeaderSEL` property setting method, then use the `didEndDisplayingHeaderHandler` property.
 */
@property (nonatomic, copy, nullable) void (^didEndDisplayingHeaderHandler)(UIView *header, id _Nullable model);
@property (nonatomic, assign) SEL didEndDisplayingHeaderSEL;

/**
 *  If the footer did end displaying, the `didEndDisplayingFooterHandler` will be called.
 *
 *  If the `didEndDisplayingFooterSEL` property is nil or the footer don't implement the `didEndDisplayingFooterSEL` property setting method, then use the `didEndDisplayingFooterHandler` property.
 */
@property (nonatomic, copy, nullable) void (^didEndDisplayingFooterHandler)(UIView *footer, id _Nullable model);
@property (nonatomic, assign) SEL didEndDisplayingFooterSEL;


/**
 *  DEPRECATED_MSG_ATTRIBUTE("Please use `headerConfigSEL` or `footerConfigSEL` api instead.")
 */
@property (nonatomic, assign) SEL headerFooterConfigSEL;

/**
 *  DEPRECATED_MSG_ATTRIBUTE("Please use `headerHeightSEL` or `footerHeightSEL` api instead.")
 */
@property (nonatomic, assign) SEL headerFooterHeightSEL;

/**
 *  DEPRECATED_MSG_ATTRIBUTE("Please use `headerEstimatedHeightSEL` or `footerEstimatedHeightSEL` api instead.")
 */
@property (nonatomic, assign) SEL headerFooterEstimatedHeightSEL;


- (void)addRow:(id<HoloTableRowProtocol>)row;

- (void)removeRow:(id<HoloTableRowProtocol>)row;

- (void)removeAllRows;

- (void)insertRow:(id<HoloTableRowProtocol>)row atIndex:(NSInteger)index;

@end


NS_ASSUME_NONNULL_END
