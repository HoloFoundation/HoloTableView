//
//  HoloTableViewUpdateRowMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/29.
//

#import <Foundation/Foundation.h>
#import "HoloTableViewRowMaker.h"
@class HoloSection;

#define HOLO_TARGET_ROW         @"holo_target_row"
#define HOLO_TARGET_INDEXPATH   @"holo_targetIndexPath"
#define HOLO_UPDATE_ROW         @"holo_updateRow"
#define HOLO_ROW_TAG_NIL        @"holo_row_tag_nil"

NS_ASSUME_NONNULL_BEGIN

////////////////////////////////////////////////////////////
@interface HoloUpdateRowMaker : HoloRowMaker

@property (nonatomic, copy, readonly) HoloUpdateRowMaker *(^cell)(NSString *cell);

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewUpdateRowMaker : NSObject

@property (nonatomic, copy, readonly) HoloUpdateRowMaker *(^tag)(NSString * _Nullable tag);

- (instancetype)initWithProxyDataSections:(NSArray<HoloSection *> *)sections isRemark:(BOOL)isRemark;

- (NSArray<NSDictionary *> *)install;

@end

NS_ASSUME_NONNULL_END
