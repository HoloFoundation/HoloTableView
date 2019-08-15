//
//  HoloTableViewSectionMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import "HoloTableViewSectionMaker.h"
#import <objc/runtime.h>
#import "HoloTableViewMacro.h"

////////////////////////////////////////////////////////////
@implementation HoloSection

- (instancetype)init {
    self = [super init];
    if (self) {
        _rows = [NSArray new];
        _headerHeight = CGFLOAT_MIN;
        _footerHeight = CGFLOAT_MIN;
        _headerEstimatedHeight = HOLO_SCREEN_HEIGHT;
        _footerEstimatedHeight = HOLO_SCREEN_HEIGHT;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        _headerFooterConfigSEL = @selector(configureHeaderFooterWithModel:);
        _headerFooterHeightSEL = @selector(heightForHeaderFooterWithModel:);
        _headerFooterEstimatedHeightSEL = @selector(estimatedHeightForHeaderFooterWithModel:);
#pragma clang diagnostic pop
    }
    return self;
}

- (NSIndexSet *)holo_insertRows:(NSArray<HoloRow *> *)rows atIndex:(NSInteger)index {
    if (rows.count <= 0) return nil;
    
    if (index < 0) index = 0;
    if (index > self.rows.count) index = self.rows.count;
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, rows.count)];
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.rows];
    [array insertObjects:rows atIndexes:indexSet];
    self.rows = array;
    return indexSet;
}

- (void)holo_removeRow:(HoloRow *)row {
    if (!row) return;
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.rows];
    [array removeObject:row];
    self.rows = array;
}

- (void)holo_removeAllRows {
    self.rows = [NSArray new];
}

@end

////////////////////////////////////////////////////////////
@implementation HoloSectionMaker

- (instancetype)init {
    self = [super init];
    if (self) {
        _section = [HoloSection new];
    }
    return self;
}

- (HoloSectionMaker *(^)(NSString *))header {
    return ^id(id obj) {
        self.section.header = obj;
        return self;
    };
}

- (HoloSectionMaker *(^)(NSString *))footer {
    return ^id(id obj) {
        self.section.footer = obj;
        return self;
    };
}

- (HoloSectionMaker * (^)(id))headerModel {
    return ^id(id obj) {
        self.section.headerModel = obj;
        return self;
    };
}

- (HoloSectionMaker * (^)(id))footerModel {
    return ^id(id obj) {
        self.section.footerModel = obj;
        return self;
    };
}

- (HoloSectionMaker *(^)(CGFloat))headerHeight {
    return ^id(CGFloat f) {
        self.section.headerHeight = f;
        return self;
    };
}

- (HoloSectionMaker *(^)(CGFloat))footerHeight {
    return ^id(CGFloat f) {
        self.section.footerHeight = f;
        return self;
    };
}

- (HoloSectionMaker *(^)(CGFloat))headerEstimatedHeight {
    return ^id(CGFloat f) {
        self.section.headerEstimatedHeight = f;
        return self;
    };
}

- (HoloSectionMaker *(^)(CGFloat))footerEstimatedHeight {
    return ^id(CGFloat f) {
        self.section.footerEstimatedHeight = f;
        return self;
    };
}

- (HoloSectionMaker *(^)(SEL))headerFooterConfigSEL {
    return ^id(SEL s) {
        self.section.headerFooterConfigSEL = s;
        return self;
    };
}

- (HoloSectionMaker *(^)(SEL))headerFooterHeightSEL {
    return ^id(SEL s) {
        self.section.headerFooterHeightSEL = s;
        return self;
    };
}

- (HoloSectionMaker *(^)(SEL))headerFooterEstimatedHeightSEL {
    return ^id(SEL s) {
        self.section.headerFooterEstimatedHeightSEL = s;
        return self;
    };
}

- (HoloSectionMaker *(^)(void (^)(UIView *)))willDisplayHeaderHandler {
    return ^id(id obj) {
        self.section.willDisplayHeaderHandler = obj;
        return self;
    };
}

- (HoloSectionMaker *(^)(void (^)(UIView *)))willDisplayFooterHandler {
    return ^id(id obj) {
        self.section.willDisplayFooterHandler = obj;
        return self;
    };
}

- (HoloSectionMaker *(^)(void (^)(UIView *)))didEndDisplayingHeaderHandler {
    return ^id(id obj) {
        self.section.didEndDisplayingHeaderHandler = obj;
        return self;
    };
}

- (HoloSectionMaker *(^)(void (^)(UIView *)))didEndDisplayingFooterHandler {
    return ^id(id obj) {
        self.section.didEndDisplayingFooterHandler = obj;
        return self;
    };
}

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewSectionMaker ()

@property (nonatomic, copy) NSArray<HoloSection *> *targetSections;

@property (nonatomic, assign) BOOL isRemark;

@property (nonatomic, strong) NSMutableArray<NSDictionary *> *holoUpdateSections;

@property (nonatomic, strong) NSMutableDictionary *sectionIndexsDict;

@end

@implementation HoloTableViewSectionMaker

- (instancetype)initWithProxyDataSections:(NSArray<HoloSection *> *)sections isRemark:(BOOL)isRemark {
    self = [super init];
    if (self) {
        _targetSections = sections;
        _isRemark = isRemark;
        
        for (HoloSection *section in self.targetSections) {
            
            NSString *dictKey = section.tag ?: kHoloSectionTagNil;
            if (self.sectionIndexsDict[dictKey]) continue;
            
            NSMutableDictionary *dict = @{kHoloTargetSection : section}.mutableCopy;
            dict[kHoloTargetIndex] = [NSNumber numberWithInteger:[self.targetSections indexOfObject:section]];
            self.sectionIndexsDict[dictKey] = [dict copy];
        }
    }
    return self;
}

- (HoloSectionMaker *(^)(NSString *))section {
    return ^id(NSString *tag) {
        HoloSectionMaker *sectionMaker = [HoloSectionMaker new];
        HoloSection *updateSection = sectionMaker.section;
        updateSection.tag = tag;
        
        NSString *dictKey = tag ?: kHoloSectionTagNil;
        NSDictionary *sectionIndexDict = self.sectionIndexsDict[dictKey];

        HoloSection *targetSection = sectionIndexDict[kHoloTargetSection];
        NSNumber *targetIndex = sectionIndexDict[kHoloTargetIndex];
        
        if (!self.isRemark && targetSection) {
            // set value of CGFloat and BOOL
            unsigned int outCount;
            objc_property_t * properties = class_copyPropertyList([targetSection class], &outCount);
            for (int i = 0; i < outCount; i++) {
                objc_property_t property = properties[i];
                const char * propertyAttr = property_getAttributes(property);
                char t = propertyAttr[1];
                if (t == 'd' || t == 'B') { // CGFloat or BOOL
                    const char *propertyName = property_getName(property);
                    NSString *propertyNameStr = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
                    id value = [targetSection valueForKey:propertyNameStr];
                    if (value) [updateSection setValue:value forKey:propertyNameStr];
                }
            }
            
            // set value of SEL
            updateSection.headerFooterConfigSEL = targetSection.headerFooterConfigSEL;
            updateSection.headerFooterHeightSEL = targetSection.headerFooterHeightSEL;
            updateSection.headerFooterEstimatedHeightSEL = targetSection.headerFooterEstimatedHeightSEL;
        }
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if (targetSection) {
            dict[kHoloTargetSection] = targetSection;
            dict[kHoloTargetIndex] = targetIndex;
        }
        dict[kHoloUpdateSection] = updateSection;
        [self.holoUpdateSections addObject:dict];
        
        return sectionMaker;
    };
}

- (NSArray<NSDictionary *> *)install {
    return [self.holoUpdateSections copy];
}

#pragma mark - getter
- (NSMutableArray<NSDictionary *> *)holoUpdateSections {
    if (!_holoUpdateSections) {
        _holoUpdateSections = [NSMutableArray new];
    }
    return _holoUpdateSections;
}

- (NSMutableDictionary *)sectionIndexsDict {
    if (!_sectionIndexsDict) {
        _sectionIndexsDict = [NSMutableDictionary new];
    }
    return _sectionIndexsDict;
}


@end
