//
//  UIResponder+HoloEvent.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/8/24.
//

#import "UIResponder+HoloEvent.h"

@implementation UIResponder (HoloEvent)

- (void)holo_event:(NSString *)event params:(NSDictionary *)params {
    [self.nextResponder holo_event:event params:params];
}

@end
