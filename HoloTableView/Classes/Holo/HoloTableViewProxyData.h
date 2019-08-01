//
//  HoloTableViewProxyData.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/29.
//

#import <Foundation/Foundation.h>
@class HoloRow, HoloSection;

NS_ASSUME_NONNULL_BEGIN

@interface HoloTableViewProxyData : NSObject

@property (nonatomic, copy) NSArray<HoloSection *> *holo_sections;

@property (nonatomic, copy) NSDictionary *holo_cellClsMap;

@property (nonatomic, copy) NSArray<NSString *> *holo_sectionIndexTitles;

@property (nonatomic, copy) NSInteger (^holo_sectionForSectionIndexTitleHandler)(NSArray<NSString *> *, NSString *, NSInteger index);

- (void)configCellClsMap:(NSDictionary *)dict;

- (void)holo_appendSections:(NSArray<HoloSection *> *)sections;

- (void)holo_removeAllSection;

- (void)holo_removeSection:(NSString *)tag;

- (void)holo_appendRows:(NSArray<HoloRow *> *)rows toSection:(NSString * _Nullable)tag;

- (void)holo_removeAllRowsInSection:(NSString *)tag;

- (void)holo_removeRow:(NSString * _Nullable)tag;

@end

NS_ASSUME_NONNULL_END
