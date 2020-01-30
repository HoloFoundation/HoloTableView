//
//  HoloTableViewMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2020/1/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString * const kHoloSectionIndexTitles = @"holo_section_index_titles";
static NSString * const kHoloSectionForSectionIndexTitleHandler = @"holo_section_for_section_index_title_handler";


@interface HoloTableViewMaker : NSObject

@property (nonatomic, copy, readonly) HoloTableViewMaker *(^sectionIndexTitles)(NSArray<NSString *> *sectionIndexTitles);

@property (nonatomic, copy, readonly) HoloTableViewMaker *(^sectionForSectionIndexTitleHandler)(NSInteger (^handler)(NSString *title, NSInteger index));

- (NSDictionary *)install;

@end

NS_ASSUME_NONNULL_END
