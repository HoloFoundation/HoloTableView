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

/**
 * Make a HoloTableRow object and set the cell class.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^row)(Class row);

- (NSArray<HoloTableRow *> *)install;

@end

NS_ASSUME_NONNULL_END
