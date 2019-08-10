//
//  HoloTableViewConfiger.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import <Foundation/Foundation.h>

#define HOLO_CELL_CLS_MAP                               @"holo_cell_cls_map"
#define HOLO_SECTION_INDEX_TITLES                       @"holo_section_index_titles"
#define HOLO_SECTION_FOR_SECTION_INDEX_TITLES_HANDLER   @"section_for_section_index_title_handler"

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

@property (nonatomic, copy, readonly) HoloTableViewConfiger *(^sectionForSectionIndexTitleHandler)(NSInteger (^handler)(NSString *title, NSInteger index));

- (NSDictionary *)install;

@end

NS_ASSUME_NONNULL_END
