//
//  HoloTableViewProxyData.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/29.
//

#import <Foundation/Foundation.h>
@class HoloRow, HoloSection;

NS_ASSUME_NONNULL_BEGIN

typedef NSInteger (^HoloSectionForSectionIndexTitleHandler)(NSString *title, NSInteger index);

@interface HoloTableViewProxyData : NSObject

@property (nonatomic, copy) NSArray<HoloSection *> *holo_sections;

@property (nonatomic, copy) NSDictionary<NSString *, Class> *holo_cellClsMap;

@property (nonatomic, copy) NSDictionary<NSString *, Class> *holo_headerFooterMap;

@property (nonatomic, copy) NSArray<NSString *> *holo_sectionIndexTitles;

@property (nonatomic, copy) HoloSectionForSectionIndexTitleHandler holo_sectionForSectionIndexTitleHandler;

- (NSIndexSet *)holo_appendSections:(NSArray<HoloSection *> *)sections;

- (NSIndexSet *)holo_removeAllSection;

- (NSIndexSet *)holo_removeSection:(NSString *)tag;

- (HoloSection *)holo_sectionWithTag:(NSString * _Nullable)tag;

- (NSArray<NSIndexPath *> *)holo_removeAllRowsInSection:(NSString *)tag;

- (NSArray<NSIndexPath *> *)holo_removeRow:(NSString * _Nullable)tag;

@end

NS_ASSUME_NONNULL_END
