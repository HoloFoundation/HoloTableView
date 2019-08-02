//
//  HoloTableViewConfiger.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

////////////////////////////////////////////////////////////
@interface HoloTableViewCellConfiger : NSObject

@property (nonatomic, copy) NSString *cellName;

@property (nonatomic, copy) NSString *clsName;

@property (nonatomic, copy, readonly) HoloTableViewCellConfiger *(^cls)(NSString *cls);

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewConfiger : NSObject

@property (nonatomic, copy, readonly) HoloTableViewCellConfiger *(^cell)(NSString *cell);

@property (nonatomic, copy, readonly) HoloTableViewConfiger *(^sectionIndexTitles)(NSArray<NSString *> *sectionIndexTitles);

@property (nonatomic, copy, readonly) HoloTableViewConfiger *(^sectionForSectionIndexTitleHandler)(NSInteger(^)(NSArray<NSString *> *sectionIndexTitles, NSString *title, NSInteger index));

- (NSDictionary *)install;

- (NSArray<NSString *> *)fetchSectionIndexTitles;

- (NSInteger(^)(NSArray<NSString *> *, NSString *, NSInteger))fetchSectionForSectionIndexTitleHandler;

@end

NS_ASSUME_NONNULL_END
