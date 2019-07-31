//
//  HoloTableViewProtocol.h
//  Pods
//
//  Created by 与佳期 on 2019/7/28.
//

#ifndef HoloTableViewProtocol_h
#define HoloTableViewProtocol_h

@protocol HoloTableViewProtocol <NSObject>

@optional
- (void)cellForRow:(id)model;

+ (CGFloat)heightForRow:(id)model;

+ (CGFloat)estimatedHeightForRow:(id)model;

@end

#endif /* HoloTableViewProtocol_h */
