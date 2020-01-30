//
//  HoloTableViewMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2020/1/30.
//

#import "HoloTableViewMaker.h"

@interface HoloTableViewMaker ()

@property (nonatomic, copy) NSArray *sectionIndexTitlesArray;

@property (nonatomic, copy) NSInteger (^sectionForSectionIndexTitleBlock)(NSString *title, NSInteger index);

@end

@implementation HoloTableViewMaker

- (HoloTableViewMaker * (^)(NSArray<NSString *> *))sectionIndexTitles {
    return ^id(id obj) {
        self.sectionIndexTitlesArray = obj;
        return self;
    };
}

- (HoloTableViewMaker * (^)(NSInteger (^)(NSString *, NSInteger)))sectionForSectionIndexTitleHandler {
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
