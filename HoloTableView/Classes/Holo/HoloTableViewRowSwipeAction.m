//
//  HoloTableViewRowSwipeAction.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/8/5.
//

#import "HoloTableViewRowSwipeAction.h"

@implementation HoloTableViewRowSwipeAction

+ (instancetype)rowSwipeActionWithStyle:(HoloTableViewRowSwipeActionStyle)style title:(nullable NSString *)title {
    HoloTableViewRowSwipeAction *action = [HoloTableViewRowSwipeAction new];
    action.style = style;
    action.title = title;
    return action;
}

@end
