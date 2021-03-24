//
//  HoloTableViewProxyData.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/29.
//

#import <Foundation/Foundation.h>
#import "HoloTableSectionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface HoloTableViewProxyData : NSObject

@property (nonatomic, copy) NSArray<HoloTableSectionProtocol> *sections;

@property (nonatomic, copy, nullable) NSArray<NSString *> *sectionIndexTitles;

@property (nonatomic, copy, nullable) NSInteger (^sectionForSectionIndexTitleHandler)(NSString *title, NSInteger index);


@property (nonatomic, copy) NSDictionary<NSString *, Class> *rowsMap;

@property (nonatomic, copy) NSDictionary<NSString *, Class> *headersMap;

@property (nonatomic, copy) NSDictionary<NSString *, Class> *footersMap;

@end

NS_ASSUME_NONNULL_END
