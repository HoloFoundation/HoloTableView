//
//  HoloTableViewConfiger.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import "HoloTableViewConfiger.h"

@interface HoloTableViewConfiger ()

@property (nonatomic, copy) NSArray *sectionIndexTitlesArray;

@property (nonatomic, copy) NSInteger (^sectionForSectionIndexTitleBlock)(NSString *title, NSInteger index);

@end

@implementation HoloTableViewConfiger

- (HoloTableViewConfiger * (^)(NSArray<NSString *> *))sectionIndexTitles {
    return ^id(id obj) {
        self.sectionIndexTitlesArray = obj;
        return self;
    };
}

- (HoloTableViewConfiger * (^)(NSInteger (^)(NSString *, NSInteger)))sectionForSectionIndexTitleHandler {
    return ^id(id obj) {
        self.sectionForSectionIndexTitleBlock = obj;
        return self;
    };
}

- (NSDictionary *)install {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    dict[kHoloSectionIndexTitles] = self.sectionIndexTitlesArray;
    dict[kHoloSectionForSectionIndexTitleHandler] = self.sectionForSectionIndexTitleBlock;
    return [dict copy];
}

@end
