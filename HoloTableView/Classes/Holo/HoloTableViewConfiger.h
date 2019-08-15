//
//  HoloTableViewConfiger.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString * const kHoloCellClsMap = @"holo_cell_cls_map";
static NSString * const kHoloSectionIndexTitles = @"holo_section_index_titles";
static NSString * const kHoloSectionForSectionIndexTitleHandler = @"holo_section_for_section_index_title_handler";


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
