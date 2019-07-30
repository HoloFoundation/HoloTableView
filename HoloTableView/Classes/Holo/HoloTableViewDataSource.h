//
//  HoloTableViewDataSource.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/29.
//

#import <Foundation/Foundation.h>
@class HoloSection;

NS_ASSUME_NONNULL_BEGIN

@interface HoloTableViewDataSource : NSObject

@property (nonatomic, copy) NSArray<HoloSection *> *holo_sections;

@property (nonatomic, copy) NSDictionary *holo_cellClsMap;


- (void)configCellClsMap:(NSDictionary *)dict;

- (HoloSection *)holo_sectionWithTag:(NSString * _Nullable)tag;

- (void)holo_appendSection:(HoloSection *)section;

- (void)holo_appendSections:(NSArray<HoloSection *> *)sections;

- (void)holo_updateSection:(HoloSection *)targetSection fromSection:(HoloSection *)fromSection;

- (void)holo_removeSection:(HoloSection *)section;

- (void)holo_removeAllSection;

- (HoloSection *)holo_sectionWithRowTag:(NSString * _Nullable)tag;

@end

NS_ASSUME_NONNULL_END
