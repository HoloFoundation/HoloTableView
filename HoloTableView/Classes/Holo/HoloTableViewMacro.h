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

#endif /* HoloTableViewMacro_h */
