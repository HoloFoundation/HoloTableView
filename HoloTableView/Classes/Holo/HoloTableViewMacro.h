//
//  HoloTableViewMacro.h
//  Pods
//
//  Created by 与佳期 on 2019/8/1.
//

#ifndef HoloTableViewMacro_h
#define HoloTableViewMacro_h

#ifdef DEBUG
#define HoloLog(...) NSLog(__VA_ARGS__)
#else
#define HoloLog(...)
#endif

#define HOLO_SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define HOLO_SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height

#endif /* HoloTableViewMacro_h */
