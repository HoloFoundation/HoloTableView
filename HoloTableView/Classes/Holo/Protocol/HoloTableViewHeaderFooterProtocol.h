//
//  HoloTableViewHeaderFooterProtocol.h
//  HoloTableView
//
//  Created by 与佳期 on 2020/6/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HoloTableViewHeaderFooterProtocol <NSObject>

@required

- (void)holo_configureHeaderFooterWithModel:(id _Nullable)model DEPRECATED_MSG_ATTRIBUTE("Please use `headerConfigSEL` or `footerConfigSEL` api instead.");


@optional

+ (CGFloat)holo_heightForHeaderFooterWithModel:(id _Nullable)model DEPRECATED_MSG_ATTRIBUTE("Please use `headerHeightSEL` or `footerHeightSEL` api instead.");

+ (CGFloat)holo_estimatedHeightForHeaderFooterWithModel:(id _Nullable)model DEPRECATED_MSG_ATTRIBUTE("Please use `headerEstimatedHeightSEL` or `footerEstimatedHeightSEL` api instead.");

@end

NS_ASSUME_NONNULL_END
