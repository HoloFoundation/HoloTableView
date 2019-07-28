//
//  HoloTableViewRowMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import <Foundation/Foundation.h>
@class HoloRow, HoloTableViewRowMaker;

NS_ASSUME_NONNULL_BEGIN

@interface HoloTableViewRowMaker : NSObject

@property (nonatomic, strong, readonly) HoloRow *row;

@property (nonatomic, copy, readonly) HoloTableViewRowMaker *(^model)(id model);

@property (nonatomic, copy, readonly) HoloTableViewRowMaker *(^height)(CGFloat height);

@property (nonatomic, copy, readonly) HoloTableViewRowMaker *(^tag)(NSString *tag);

@property (nonatomic, copy, readonly) HoloTableViewRowMaker *(^didSelectHandler)(void(^)(id model));

@property (nonatomic, copy, readonly) HoloTableViewRowMaker *(^willDisplayHandler)(void(^)(UITableViewCell *cell));

@property (nonatomic, copy, readonly) HoloTableViewRowMaker *(^didEndDisplayHandler)(void(^)(UITableViewCell *cell));

@end

NS_ASSUME_NONNULL_END
