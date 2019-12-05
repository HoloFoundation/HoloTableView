//
//  UIResponder+HoloEvent.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/8/24.
//

#import <UIKit/UIKit.h>

@interface UIResponder (HoloEvent)

- (void)holo_event:(NSString *)event params:(NSDictionary *)params;

@end
