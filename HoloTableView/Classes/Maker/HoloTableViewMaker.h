//
//  HoloTableViewMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import <Foundation/Foundation.h>
@class HoloSection, HoloTableViewRowMaker, HoloTableViewSectionMaker;

NS_ASSUME_NONNULL_BEGIN

@interface HoloTableViewMaker : NSObject

@property (nonatomic, copy, readonly) HoloTableViewSectionMaker *(^section)(NSString *tag);

@property (nonatomic, copy, readonly) HoloTableViewRowMaker *(^row)(NSString *rowName);

- (HoloSection *)install;

@end

NS_ASSUME_NONNULL_END
