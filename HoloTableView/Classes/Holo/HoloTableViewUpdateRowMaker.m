//
//  HoloTableViewUpdateRowMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/29.
//

#import "HoloTableViewUpdateRowMaker.h"
#import "HoloTableViewRowMaker.h"
#import "HoloTableViewSectionMaker.h"

//============================================================:HoloUpdateRow
@implementation HoloUpdateRow

@end

//============================================================:HoloUpdateRowMaker
@implementation HoloUpdateRowMaker

- (instancetype)init {
    self = [super init];
    if (self) {
        _updateRow = [HoloUpdateRow new];
    }
    return self;
}

- (HoloUpdateRowMaker * (^)(NSString *))cell {
    return ^id(NSString *cell){
        self.updateRow.cell = cell;
        return self;
    };
}

- (HoloUpdateRowMaker *(^)(id))model {
    return ^id(id model){
        self.updateRow.model = model;
        return self;
    };
}

- (HoloUpdateRowMaker *(^)(CGFloat))height {
    return ^id(CGFloat height){
        self.updateRow.height = height;
        return self;
    };
}

- (HoloUpdateRowMaker *(^)(CGFloat))estimatedHeight {
    return ^id(CGFloat estimatedHeight){
        self.updateRow.estimatedHeight = estimatedHeight;
        return self;
    };
}

- (HoloUpdateRowMaker * (^)(SEL))configSEL {
    return ^id(SEL configSEL){
        self.updateRow.configSEL = configSEL;
        return self;
    };
}

- (HoloUpdateRowMaker * (^)(SEL))heightSEL {
    return ^id(SEL heightSEL){
        self.updateRow.heightSEL = heightSEL;
        return self;
    };
}

- (HoloUpdateRowMaker * (^)(SEL))estimatedHeightSEL {
    return ^id(SEL estimatedHeightSEL){
        self.updateRow.estimatedHeightSEL = estimatedHeightSEL;
        return self;
    };
}

- (HoloUpdateRowMaker * (^)(BOOL))shouldHighlight {
    return ^id(BOOL shouldHighlight){
        self.updateRow.shouldHighlight = shouldHighlight;
        return self;
    };
}

@end

//============================================================:HoloTableViewUpdateRowMaker
@interface HoloTableViewUpdateRowMaker ()

@property (nonatomic, copy) NSArray *holoSections;

@property (nonatomic, strong) HoloRow *targetRow;

@property (nonatomic, strong) NSMutableArray<NSDictionary *> *holoUpdateRows;

@end

@implementation HoloTableViewUpdateRowMaker

- (instancetype)initWithProxyDataSections:(NSArray *)sections {
    self = [super init];
    if (self) {
        self.holoSections = sections;
    }
    return self;
}

- (HoloUpdateRowMaker *(^)(NSString *))tag {
    __weak typeof(self) weakSelf = self;
    return ^id(NSString *tag) {
        __weak typeof(weakSelf) strongSelf = weakSelf;
        HoloUpdateRowMaker *rowMaker = [HoloUpdateRowMaker new];
        HoloUpdateRow *updateRow = rowMaker.updateRow;
        updateRow.tag = tag;
        
        HoloRow *targetRow;
        for (HoloSection *section in self.holoSections) {
            for (HoloRow *row in section.rows) {
                if ([row.tag isEqualToString:tag] || (!row.tag && !tag)) {
                    
                    updateRow.cell = row.cell;
                    updateRow.model = row.model;
                    updateRow.height = row.height;
                    updateRow.estimatedHeight = row.estimatedHeight;
                    updateRow.configSEL = row.configSEL;
                    updateRow.heightSEL = row.heightSEL;
                    updateRow.estimatedHeightSEL = row.estimatedHeightSEL;
                    updateRow.shouldHighlight = row.shouldHighlight;
                    
                    targetRow = row;
                }
            }
        }
        
        if (targetRow) {
            [strongSelf.holoUpdateRows addObject:@{@"targetRow" : targetRow,
                                                   @"updateRow" : updateRow
                                                   }];
        }
        return rowMaker;
    };
}

- (NSArray<NSDictionary *> *)install {
    return [self.holoUpdateRows copy];
}

#pragma mark - getter
- (NSMutableArray<NSDictionary *> *)holoUpdateRows {
    if (!_holoUpdateRows) {
        _holoUpdateRows = [NSMutableArray new];
    }
    return _holoUpdateRows;
}

@end
