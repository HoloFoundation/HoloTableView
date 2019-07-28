//
//  HoloTableViewConfiger.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import <Foundation/Foundation.h>
@class HoloTableViewCellConfiger;

NS_ASSUME_NONNULL_BEGIN

@interface HoloTableViewConfiger : NSObject

@property (nonatomic, copy, readonly) HoloTableViewCellConfiger *(^cell)(NSString *cell);

- (NSDictionary *)install;

@end

NS_ASSUME_NONNULL_END
