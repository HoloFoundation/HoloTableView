//
//  HoloTableViewUpdateRowMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/29.
//

#import "HoloTableViewUpdateRowMaker.h"
#import "HoloTableRow.h"
#import "HoloTableRowMaker.h"
#import "HoloTableSection.h"

@implementation HoloTableViewUpdateRowMakerModel

@end


@interface HoloTableViewUpdateRowMaker ()

@property (nonatomic, copy) NSArray<HoloTableSection *> *dataSections;

@property (nonatomic, assign) HoloTableViewUpdateRowMakerType makerType;

@property (nonatomic, strong) NSMutableArray<HoloTableViewUpdateRowMakerModel *> *makerModels;

@end

@implementation HoloTableViewUpdateRowMaker

- (instancetype)initWithProxyDataSections:(NSArray<HoloTableSection *> *)sections
                                makerType:(HoloTableViewUpdateRowMakerType)makerType {
    self = [super init];
    if (self) {
        _dataSections = sections;
        _makerType = makerType;
    }
    return self;
}

- (HoloTableRowMaker *(^)(NSString *))tag {
    return ^id(NSString *tag) {
        HoloTableRowMaker *rowMaker = [HoloTableRowMaker new];
        HoloTableRow *updateRow = [rowMaker fetchTableRow];
        updateRow.tag = tag;
        
        __block HoloTableRow *targetRow;
        __block NSIndexPath *operateIndexPath;
        [self.dataSections enumerateObjectsUsingBlock:^(HoloTableSection * _Nonnull section, NSUInteger sectionIdx, BOOL * _Nonnull sectionStop) {
            [section.rows enumerateObjectsUsingBlock:^(HoloTableRow * _Nonnull row, NSUInteger rowIdx, BOOL * _Nonnull rowStop) {
                if ([row.tag isEqualToString:tag] || (!row.tag && !tag)) {
                    targetRow = row;
                    operateIndexPath = [NSIndexPath indexPathForRow:rowIdx inSection:sectionIdx];
                    *rowStop = YES;
                    *sectionStop = YES;
                }
            }];
        }];
        
        if (targetRow && self.makerType == HoloTableViewUpdateRowMakerTypeUpdate) {
            [rowMaker giveTableRow:targetRow];
        }
        
        HoloTableViewUpdateRowMakerModel *makerModel = [HoloTableViewUpdateRowMakerModel new];
        makerModel.operateRow = [rowMaker fetchTableRow];
        makerModel.operateIndexPath = operateIndexPath;
        [self.makerModels addObject:makerModel];
        
        return rowMaker;
    };
}

- (NSArray<HoloTableViewUpdateRowMakerModel *> *)install {
    return self.makerModels.copy;
}

#pragma mark - getter
- (NSMutableArray<HoloTableViewUpdateRowMakerModel *> *)makerModels {
    if (!_makerModels) {
        _makerModels = [NSMutableArray new];
    }
    return _makerModels;
}

@end