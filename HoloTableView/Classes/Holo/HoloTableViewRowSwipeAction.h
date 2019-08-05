//
//  HoloTableViewRowSwipeAction.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/8/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HoloTableViewRowSwipeActionStyle) {
    HoloTableViewRowSwipeActionStyleNormal,
    HoloTableViewRowSwipeActionStyleDestructive
};

@interface HoloTableViewRowSwipeAction : NSObject

+ (instancetype)rowSwipeActionWithStyle:(HoloTableViewRowSwipeActionStyle)style title:(nullable NSString *)title;

@property (nonatomic, copy, nullable) NSString *title;;

@property (nonatomic, assign) HoloTableViewRowSwipeActionStyle style;

@property (nonatomic, copy, nullable) UIColor *backgroundColor;

@property (nonatomic, copy, nullable) UIVisualEffect* backgroundEffect NS_DEPRECATED_IOS(8_0, 10_0);

@property (nonatomic, copy, nullable) UIImage *image API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

@end

NS_ASSUME_NONNULL_END
