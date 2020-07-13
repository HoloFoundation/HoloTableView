//
//  HoloTableViewHeaderProtocol.h
//  HoloTableView
//
//  Created by 与佳期 on 2020/6/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HoloTableViewHeaderProtocol <NSObject>

@required

- (void)holo_configureHeaderWithModel:(id)model;


@optional

+ (CGFloat)holo_heightForHeaderWithModel:(id)model;

+ (CGFloat)holo_estimatedHeightForHeaderWithModel:(id)model;

- (void)holo_willDisplayHeaderWithModel:(id)model;

- (void)holo_didEndDisplayingHeaderWithModel:(id)model;

@end

NS_ASSUME_NONNULL_END
