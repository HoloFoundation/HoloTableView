//
//  HoloTableViewRowSwipeAction.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/8/5.
//

#import <Foundation/Foundation.h>
@class HoloTableViewRowSwipeAction;

#define HOLO_SWIPE_ACTION_TITLE             @"title"
#define HOLO_SWIPE_ACTION_STYLE             @"style"
#define HOLO_SWIPE_ACTION_BACKGROUND_COLOR  @"backgroundColor"
#define HOLO_SWIPE_ACTION_BACKGROUND_EFFECT @"backgroundEffect"
#define HOLO_SWIPE_ACTION_IMAGE             @"image"
#define HOLO_SWIPE_ACTION_HANDLER           @"handler"

NS_ASSUME_NONNULL_BEGIN

typedef void (^HoloTableViewRowSwipeActionHandler)(id action, NSInteger index, void(^completionHandler)(BOOL actionPerformed));

typedef NS_ENUM(NSInteger, HoloTableViewRowSwipeActionStyle) {
    HoloTableViewRowSwipeActionStyleNormal,
    HoloTableViewRowSwipeActionStyleDestructive
};

@interface HoloTableViewRowSwipeAction : NSObject

+ (instancetype)rowSwipeActionWithStyle:(HoloTableViewRowSwipeActionStyle)style title:(nullable NSString *)title;

+ (instancetype)rowSwipeActionWithStyle:(HoloTableViewRowSwipeActionStyle)style title:(nullable NSString *)title handler:(HoloTableViewRowSwipeActionHandler)handler;

@property (nonatomic, copy, nullable) NSString *title;;

@property (nonatomic, assign) HoloTableViewRowSwipeActionStyle style;

@property (nonatomic, copy, nullable) UIColor *backgroundColor;

@property (nonatomic, copy, nullable) UIVisualEffect *backgroundEffect NS_DEPRECATED_IOS(8_0, 10_0);

@property (nonatomic, copy, nullable) UIImage *image API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

@property (nonatomic, copy) HoloTableViewRowSwipeActionHandler handler;

@end

NS_ASSUME_NONNULL_END
