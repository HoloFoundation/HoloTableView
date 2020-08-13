//
//  HoloTableViewFooterProtocol.h
//  HoloTableView
//
//  Created by 与佳期 on 2020/6/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HoloTableViewFooterProtocol <NSObject>

@required

- (void)holo_configureFooterWithModel:(id _Nullable)model;


@optional

+ (CGFloat)holo_heightForFooterWithModel:(id _Nullable)model;

+ (CGFloat)holo_estimatedHeightForFooterWithModel:(id _Nullable)model;

- (void)holo_willDisplayFooterWithModel:(id _Nullable)model;

- (void)holo_didEndDisplayingFooterWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
