//
//  HoloTableViewSectionMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import "HoloTableViewSectionMaker.h"
#import "HoloTableSection.h"
#import "HoloTableSectionMaker.h"

@implementation HoloTableViewSectionMakerModel

@end


@interface HoloTableViewSectionMaker ()

@property (nonatomic, copy) NSArray<HoloTableSection *> *dataSections;

@property (nonatomic, assign) HoloTableViewSectionMakerType makerType;

@property (nonatomic, strong) NSMutableArray<HoloTableViewSectionMakerModel *> *makerModels;

@end

@implementation HoloTableViewSectionMaker

- (instancetype)initWithProxyDataSections:(NSArray<HoloTableSection *> *)sections
                                makerType:(HoloTableViewSectionMakerType)makerType {
    self = [super init];
    if (self) {
        _dataSections = sections;
        _makerType = makerType;
    }
    return self;
}

- (HoloTableSectionMaker *(^)(NSString *))section {
    return ^id(NSString *tag) {
        HoloTableSectionMaker *sectionMaker = [HoloTableSectionMaker new];
        HoloTableSection *section = [sectionMaker fetchTableSection];
        section.tag = tag;
        
        __block HoloTableSection *targetSection;
        __block NSNumber *operateIndex;
        if (self.makerType == HoloTableViewSectionMakerTypeUpdate || self.makerType == HoloTableViewSectionMakerTypeRemake) {
            [self.dataSections enumerateObjectsUsingBlock:^(HoloTableSection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.tag isEqualToString:tag] || (!obj.tag && !tag)) {
                    targetSection = obj;
                    operateIndex = @(idx);
                    *stop = YES;
                }
            }];
        }
        
        if (targetSection && self.makerType == HoloTableViewSectionMakerTypeUpdate) {
            section = targetSection;
        }
        
        HoloTableViewSectionMakerModel *makerModel = [HoloTableViewSectionMakerModel new];
        makerModel.operateSection = section;
        makerModel.operateIndex = operateIndex;
        [self.makerModels addObject:makerModel];
        
        return sectionMaker;
    };
}

- (NSArray<HoloTableViewSectionMakerModel *> *)install {
    return self.makerModels.copy;
}

#pragma mark - getter
- (NSMutableArray<HoloTableViewSectionMakerModel *> *)makerModels {
    if (!_makerModels) {
        _makerModels = [NSMutableArray new];
    }
    return _makerModels;
}

@end
