//
//  HoloTableViewMacro.h
//  Pods
//
//  Created by 与佳期 on 2019/8/1.
//

#ifndef HoloTableViewMacro_h
#define HoloTableViewMacro_h

#define TAG @"HOLO_DEFAULT_TAG"

#ifdef DEBUG
#define HoloLog(...) NSLog(__VA_ARGS__)
#else
#define HoloLog(...)
#endif

#endif /* HoloTableViewMacro_h */
