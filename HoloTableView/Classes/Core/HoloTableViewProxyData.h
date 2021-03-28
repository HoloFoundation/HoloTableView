//
//  HoloTableViewProxyData.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/29.
//

#import <Foundation/Foundation.h>
@class HoloTableSection;

NS_ASSUME_NONNULL_BEGIN

@interface HoloTableViewProxyData : NSObject

/**
 *  Datasource of current UITableView.
 */
@property (nonatomic, copy) NSArray<HoloTableSection *> *sections;

/**
 *  Return list of section titles to display in section index view (e.g. "ABCD...Z#").
 */
@property (nonatomic, copy, nullable) NSArray<NSString *> *sectionIndexTitles;

/**
 *  Tell table which section corresponds to section title/index (e.g. "B",1)).
 */
@property (nonatomic, copy, nullable) NSInteger (^sectionForSectionIndexTitleHandler)(NSString *title, NSInteger index);


@property (nonatomic, copy) NSDictionary<NSString *, Class> *rowsMap;

@property (nonatomic, copy) NSDictionary<NSString *, Class> *headersMap;

@property (nonatomic, copy) NSDictionary<NSString *, Class> *footersMap;

@end

NS_ASSUME_NONNULL_END
