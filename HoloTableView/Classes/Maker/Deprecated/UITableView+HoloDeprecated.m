//
//  UITableView+HoloDeprecated.m
//  HoloTableView
//
//  Created by 与佳期 on 2021/5/22.
//

#import "UITableView+HoloDeprecated.h"
#import "HoloTableViewUpdateRowMaker.h"
#import "UITableView+HoloTableView.h"

@implementation UITableView (HoloDeprecated)

- (void)holo_updateRows:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block
              inSection:(NSString *)tag {
    [self holo_updateRowsInSection:tag block:block];
}

- (void)holo_updateRows:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block
              inSection:(NSString *)tag
    withReloadAnimation:(UITableViewRowAnimation)animation {
    [self holo_updateRowsInSection:tag block:block withReloadAnimation:animation];
}

- (void)holo_remakeRows:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block
              inSection:(NSString *)tag {
    [self holo_remakeRowsInSection:tag block:block];
}

- (void)holo_remakeRows:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block
              inSection:(NSString *)tag
    withReloadAnimation:(UITableViewRowAnimation)animation {
    [self holo_remakeRowsInSection:tag block:block withReloadAnimation:animation];
}

@end
