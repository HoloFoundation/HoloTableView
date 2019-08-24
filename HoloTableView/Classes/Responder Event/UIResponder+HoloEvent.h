//
//  UIResponder+HoloEvent.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/8/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (HoloEvent)

- (void)holo_event:(NSString *)event params:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
