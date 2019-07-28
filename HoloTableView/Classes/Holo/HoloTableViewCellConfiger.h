//
//  HoloTableViewCellConfiger.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HoloTableViewCellConfiger : NSObject

@property (nonatomic, copy) NSString *cellName;

@property (nonatomic, copy) NSString *clsName;

@property (nonatomic, copy, readonly) HoloTableViewCellConfiger *(^cls)(NSString *cls);

@end

NS_ASSUME_NONNULL_END
