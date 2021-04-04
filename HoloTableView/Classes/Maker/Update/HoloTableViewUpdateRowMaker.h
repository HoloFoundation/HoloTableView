//
//  HoloTableViewUpdateRowMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/29.
//

#import <Foundation/Foundation.h>
@class HoloTableRow, HoloTableRowMaker, HoloTableSection;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HoloTableViewUpdateRowMakerType) {
    HoloTableViewUpdateRowMakerTypeUpdate,
    HoloTableViewUpdateRowMakerTypeRemake
};


@interface HoloTableViewUpdateRowMakerModel : NSObject

@property (nonatomic, strong, nullable) HoloTableRow *operateRow;

@property (nonatomic, strong, nullable) NSIndexPath *operateIndexPath;

@end


@interface HoloTableViewUpdateRowMaker : NSObject

/**
 *  Fetch a HoloTableRow object with the tag.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^tag)(NSString *tag);

- (instancetype)initWithProxyDataSections:(NSArray<HoloTableSection *> *)sections
                                makerType:(HoloTableViewUpdateRowMakerType)makerType;

- (NSArray<HoloTableViewUpdateRowMakerModel *> *)install;

@end

NS_ASSUME_NONNULL_END
