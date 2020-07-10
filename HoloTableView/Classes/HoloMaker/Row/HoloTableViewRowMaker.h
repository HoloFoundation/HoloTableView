//
//  HoloTableViewRowMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import <Foundation/Foundation.h>
@class HoloTableRow, HoloTableRowMaker;

NS_ASSUME_NONNULL_BEGIN

@interface HoloTableViewRowMaker : NSObject

/// will change 'reuseId' value immediately
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^row)(Class row);

/// will change 'reuseId' value immediately
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^rowS)(NSString *rowString);

- (NSArray<HoloTableRow *> *)install;

@end

NS_ASSUME_NONNULL_END
