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

@property (nonatomic, copy) NSArray<HoloTableSection *> *sections;

@property (nonatomic, copy) NSDictionary<NSString *, Class> *cellClsMap;

@property (nonatomic, copy) NSDictionary<NSString *, Class> *headerFooterMap;

@property (nonatomic, copy) NSArray<NSString *> *sectionIndexTitles;

@property (nonatomic, copy) NSInteger (^sectionForSectionIndexTitleHandler)(NSString *title, NSInteger index);

- (NSIndexSet *)insertSections:(NSArray<HoloTableSection *> *)sections anIndex:(NSInteger)index;

- (NSIndexSet *)removeAllSection;

- (NSIndexSet *)removeSections:(NSArray<NSString *> *)tags;

- (HoloTableSection *)sectionWithTag:(NSString * _Nullable)tag;

- (NSArray<NSIndexPath *> *)removeAllRowsInSections:(NSArray<NSString *> *)tags;

- (NSArray<NSIndexPath *> *)removeRows:(NSArray<NSString *> *)tags;

@end

NS_ASSUME_NONNULL_END
