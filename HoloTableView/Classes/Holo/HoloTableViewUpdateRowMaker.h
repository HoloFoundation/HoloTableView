//
//  HoloTableViewUpdateRowMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/29.
//

#import <Foundation/Foundation.h>
#import "HoloTableViewRowMaker.h"
@class HoloTableSection;

NS_ASSUME_NONNULL_BEGIN

static NSString * const kHoloTargetRow = @"holo_target_row";
static NSString * const kHoloTargetIndexPath = @"holo_target_indexPath";
static NSString * const kHoloUpdateRow = @"holo_update_row";
static NSString * const kHoloRowTagNil = @"holo_row_tag_nil";


////////////////////////////////////////////////////////////
@interface HoloUpdateTableRowMaker : HoloTableRowMaker

@property (nonatomic, copy, readonly) HoloUpdateTableRowMaker *(^cell)(NSString *cell);

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewUpdateRowMaker : NSObject

@property (nonatomic, copy, readonly) HoloUpdateTableRowMaker *(^tag)(NSString * _Nullable tag);

- (instancetype)initWithProxyDataSections:(NSArray<HoloTableSection *> *)sections isRemark:(BOOL)isRemark;

- (NSArray<NSDictionary *> *)install;

@end

NS_ASSUME_NONNULL_END
