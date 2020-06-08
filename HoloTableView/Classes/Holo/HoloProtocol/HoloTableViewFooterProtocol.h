//
//  HoloTableViewFooterProtocol.h
//  HoloTableView
//
//  Created by 与佳期 on 2020/6/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HoloTableViewFooterProtocol <NSObject>

@required;

- (void)holo_configureFooterWithModel:(id)model;


@optional

+ (CGFloat)holo_heightForFooterWithModel:(id)model;

+ (CGFloat)holo_estimatedHeightForFooterWithModel:(id)model;

- (void)holo_willDisplayFooterWithModel:(id)model;

- (void)holo_didEndDisplayingFooterWithModel:(id)model;

@end

NS_ASSUME_NONNULL_END
