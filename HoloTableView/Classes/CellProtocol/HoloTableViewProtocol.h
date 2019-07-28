//
//  HoloTableViewProtocol.h
//  Pods
//
//  Created by 与佳期 on 2019/7/28.
//

#ifndef HoloTableViewProtocol_h
#define HoloTableViewProtocol_h

@protocol HoloTableViewProtocol <NSObject>

- (void)cellForRow:(id)model;

+ (CGFloat)heightForRow:(id)model;

@end

#endif /* HoloTableViewProtocol_h */
