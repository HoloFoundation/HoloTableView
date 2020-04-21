//
//  HoloTableViewSectionMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import "HoloTableViewSectionMaker.h"
#import "HoloTableViewRowMaker.h"

////////////////////////////////////////////////////////////
@implementation HoloTableSection

- (instancetype)init {
    self = [super init];
    if (self) {
        _rows = [NSArray new];
        _headerHeight = CGFLOAT_MIN;
        _footerHeight = CGFLOAT_MIN;
        _headerEstimatedHeight = CGFLOAT_MIN;
        _footerEstimatedHeight = CGFLOAT_MIN;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        _headerConfigSEL = @selector(holo_configureHeaderWithModel:);
        _footerConfigSEL = @selector(holo_configureFooterWithModel:);
        _headerHeightSEL = @selector(holo_heightForHeaderWithModel:);
        _footerHeightSEL = @selector(holo_heightForFooterWithModel:);
        _headerEstimatedHeightSEL = @selector(holo_estimatedHeightForHeaderWithModel:);
        _footerEstimatedHeightSEL = @selector(holo_estimatedHeightForFooterWithModel:);
        
        _headerFooterConfigSEL = @selector(holo_configureHeaderFooterWithModel:);
        _headerFooterHeightSEL = @selector(holo_heightForHeaderFooterWithModel:);
        _headerFooterEstimatedHeightSEL = @selector(holo_estimatedHeightForHeaderFooterWithModel:);
#pragma clang diagnostic pop
    }
    return self;
}

- (NSIndexSet *)insertRows:(NSArray<HoloTableRow *> *)rows atIndex:(NSInteger)index {
    if (rows.count <= 0) return nil;
    
    if (index < 0) index = 0;
    if (index > self.rows.count) index = self.rows.count;
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, rows.count)];
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.rows];
    [array insertObjects:rows atIndexes:indexSet];
    self.rows = array;
    return indexSet;
}

- (void)removeRow:(HoloTableRow *)row {
    if (!row) return;
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.rows];
    [array removeObject:row];
    self.rows = array;
}

- (void)removeAllRows {
    self.rows = [NSArray new];
}

@end

////////////////////////////////////////////////////////////
@interface HoloTableSectionMaker ()

@property (nonatomic, strong) HoloTableSection *section;

@end

@implementation HoloTableSectionMaker

- (HoloTableSectionMaker * (^)(Class))header {
    return ^id(Class cls) {
        self.section.header = NSStringFromClass(cls);
        return self;
    };
}

- (HoloTableSectionMaker * (^)(Class))footer {
    return ^id(Class cls) {
        self.section.footer = NSStringFromClass(cls);
        return self;
    };
}

- (HoloTableSectionMaker *(^)(NSString *))headerS {
    return ^id(id obj) {
        self.section.header = obj;
        return self;
    };
}

- (HoloTableSectionMaker *(^)(NSString *))footerS {
    return ^id(id obj) {
        self.section.footer = obj;
        return self;
    };
}

- (HoloTableSectionMaker * (^)(id))headerModel {
    return ^id(id obj) {
        self.section.headerModel = obj;
        return self;
    };
}

- (HoloTableSectionMaker * (^)(id))footerModel {
    return ^id(id obj) {
        self.section.footerModel = obj;
        return self;
    };
}

- (HoloTableSectionMaker *(^)(CGFloat))headerHeight {
    return ^id(CGFloat f) {
        self.section.headerHeight = f;
        return self;
    };
}

- (HoloTableSectionMaker *(^)(CGFloat))footerHeight {
    return ^id(CGFloat f) {
        self.section.footerHeight = f;
        return self;
    };
}

- (HoloTableSectionMaker *(^)(CGFloat))headerEstimatedHeight {
    return ^id(CGFloat f) {
        self.section.headerEstimatedHeight = f;
        return self;
    };
}

- (HoloTableSectionMaker *(^)(CGFloat))footerEstimatedHeight {
    return ^id(CGFloat f) {
        self.section.footerEstimatedHeight = f;
        return self;
    };
}

- (HoloTableSectionMaker *(^)(SEL))headerFooterConfigSEL {
    return ^id(SEL s) {
        self.section.headerFooterConfigSEL = s;
        return self;
    };
}

- (HoloTableSectionMaker *(^)(SEL))headerConfigSEL {
    return ^id(SEL s) {
        self.section.headerConfigSEL = s;
        return self;
    };
}

- (HoloTableSectionMaker *(^)(SEL))footerConfigSEL {
    return ^id(SEL s) {
        self.section.footerConfigSEL = s;
        return self;
    };
}

- (HoloTableSectionMaker *(^)(SEL))headerHeightSEL {
    return ^id(SEL s) {
        self.section.headerHeightSEL = s;
        return self;
    };
}

- (HoloTableSectionMaker *(^)(SEL))footerHeightSEL {
    return ^id(SEL s) {
        self.section.footerHeightSEL = s;
        return self;
    };
}

- (HoloTableSectionMaker *(^)(SEL))headerEstimatedHeightSEL {
    return ^id(SEL s) {
        self.section.headerEstimatedHeightSEL = s;
        return self;
    };
}

- (HoloTableSectionMaker *(^)(SEL))footerEstimatedHeightSEL {
    return ^id(SEL s) {
        self.section.footerEstimatedHeightSEL = s;
        return self;
    };
}
- (HoloTableSectionMaker *(^)(SEL))headerFooterHeightSEL {
    return ^id(SEL s) {
        self.section.headerFooterHeightSEL = s;
        return self;
    };
}
- (HoloTableSectionMaker *(^)(SEL))headerFooterEstimatedHeightSEL {
    return ^id(SEL s) {
        self.section.headerFooterEstimatedHeightSEL = s;
        return self;
    };
}

- (HoloTableSectionMaker *(^)(void (^)(UIView *, id)))willDisplayHeaderHandler {
    return ^id(id obj) {
        self.section.willDisplayHeaderHandler = obj;
        return self;
    };
}

- (HoloTableSectionMaker *(^)(void (^)(UIView *, id)))willDisplayFooterHandler {
    return ^id(id obj) {
        self.section.willDisplayFooterHandler = obj;
        return self;
    };
}

- (HoloTableSectionMaker *(^)(void (^)(UIView *, id)))didEndDisplayingHeaderHandler {
    return ^id(id obj) {
        self.section.didEndDisplayingHeaderHandler = obj;
        return self;
    };
}

- (HoloTableSectionMaker *(^)(void (^)(UIView *, id)))didEndDisplayingFooterHandler {
    return ^id(id obj) {
        self.section.didEndDisplayingFooterHandler = obj;
        return self;
    };
}

- (HoloTableSectionMaker * (^)(void (NS_NOESCAPE ^)(HoloTableViewRowMaker *)))makeRows {
    return ^id(void(^block)(HoloTableViewRowMaker *make)) {
        HoloTableViewRowMaker *maker = [HoloTableViewRowMaker new];
        if (block) block(maker);
        
        [self.section insertRows:[maker install] atIndex:NSIntegerMax];
        return self;
    };
}

#pragma mark - getter
- (HoloTableSection *)section {
    if (!_section) {
        _section = [HoloTableSection new];
    }
    return _section;
}

@end

////////////////////////////////////////////////////////////
@implementation HoloTableViewSectionMakerModel

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewSectionMaker ()

@property (nonatomic, copy) NSArray<HoloTableSection *> *dataSections;

@property (nonatomic, assign) HoloTableViewSectionMakerType makerType;

@property (nonatomic, strong) NSMutableArray<HoloTableViewSectionMakerModel *> *makerModels;

@end

@implementation HoloTableViewSectionMaker

- (instancetype)initWithProxyDataSections:(NSArray<HoloTableSection *> *)sections makerType:(HoloTableViewSectionMakerType)makerType {
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
        sectionMaker.section.tag = tag;
        
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
            sectionMaker.section = targetSection;
        }
        
        HoloTableViewSectionMakerModel *makerModel = [HoloTableViewSectionMakerModel new];
        makerModel.operateSection = sectionMaker.section;
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
