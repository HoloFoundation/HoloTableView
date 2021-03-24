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

- (void)holo_configureHeaderWithModel:(id _Nullable)model;


@optional

+ (CGFloat)holo_heightForHeaderWithModel:(id _Nullable)model;

+ (CGFloat)holo_estimatedHeightForHeaderWithModel:(id _Nullable)model;

- (void)holo_willDisplayHeaderWithModel:(id _Nullable)model;

- (void)holo_didEndDisplayingHeaderWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
