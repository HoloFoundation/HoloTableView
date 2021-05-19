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
        HoloTableSection *makerSection = [sectionMaker fetchTableSection];
        makerSection.tag = tag;
        
        __block NSNumber *operateIndex = nil;
        if (self.makerType == HoloTableViewSectionMakerTypeUpdate || self.makerType == HoloTableViewSectionMakerTypeRemake) {
            [self.dataSections enumerateObjectsUsingBlock:^(HoloTableSection * _Nonnull section, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([section.tag isEqualToString:tag] || (!section.tag && !tag)) {
                    operateIndex = @(idx);
                    
                    if (self.makerType == HoloTableViewSectionMakerTypeUpdate) {
                        // update: set the row object to maker from datasource
                        [sectionMaker giveTableSection:section];
                    }
                    
                    *stop = YES;
                }
            }];
        }
        
        HoloTableViewSectionMakerModel *makerModel = [HoloTableViewSectionMakerModel new];
        makerModel.operateSection = [sectionMaker fetchTableSection];
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
