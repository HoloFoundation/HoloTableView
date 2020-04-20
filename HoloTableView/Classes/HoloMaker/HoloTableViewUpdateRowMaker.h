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

typedef NS_ENUM(NSInteger, HoloTableViewUpdateRowMakerType) {
    HoloTableViewUpdateRowMakerTypeMake,
    HoloTableViewUpdateRowMakerTypeInsert,
    HoloTableViewUpdateRowMakerTypeUpdate,
    HoloTableViewUpdateRowMakerTypeRemake
};

////////////////////////////////////////////////////////////
@interface HoloTableUpdateRowMaker : HoloTableRowMaker

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^row)(Class row);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^rowS)(NSString *rowString);

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewUpdateRowMakerModel : NSObject

@property (nonatomic, strong) HoloTableRow *operateRow;

@property (nonatomic, strong) NSIndexPath *operateIndexPath;

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewUpdateRowMaker : NSObject

@property (nonatomic, copy, readonly) HoloTableUpdateRowMaker *(^tag)(NSString *tag);

- (instancetype)initWithProxyDataSections:(NSArray<HoloTableSection *> *)sections makerType:(HoloTableViewUpdateRowMakerType)makerType;

- (NSArray<HoloTableViewUpdateRowMakerModel *> *)install;

@end

NS_ASSUME_NONNULL_END
