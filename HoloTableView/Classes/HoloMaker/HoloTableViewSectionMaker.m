//
//  HoloTableViewSectionMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import "HoloTableViewSectionMaker.h"
#import <objc/runtime.h>
#import "HoloTableViewMacro.h"
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

- (instancetype)init {
    self = [super init];
    if (self) {
        _section = [HoloTableSection new];
    }
    return self;
}

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

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewSectionMaker ()

@property (nonatomic, copy) NSArray<HoloTableSection *> *targetSections;

@property (nonatomic, assign) BOOL isRemark;

@property (nonatomic, strong) NSMutableArray<NSDictionary *> *holoUpdateSections;

@property (nonatomic, strong) NSMutableDictionary *sectionIndexsDict;

@end

@implementation HoloTableViewSectionMaker

- (instancetype)initWithProxyDataSections:(NSArray<HoloTableSection *> *)sections isRemark:(BOOL)isRemark {
    self = [super init];
    if (self) {
        _targetSections = sections;
        _isRemark = isRemark;
        
        for (HoloTableSection *section in self.targetSections) {
            NSString *dictKey = section.tag ?: kHoloSectionTagNil;
            if (self.sectionIndexsDict[dictKey]) continue;
            
            NSMutableDictionary *dict = @{kHoloTargetSection : section}.mutableCopy;
            dict[kHoloTargetIndex] = @([self.targetSections indexOfObject:section]);
            self.sectionIndexsDict[dictKey] = [dict copy];
        }
    }
    return self;
}

- (HoloTableSectionMaker *(^)(NSString *))section {
    return ^id(NSString *tag) {
        HoloTableSectionMaker *sectionMaker = [HoloTableSectionMaker new];
        HoloTableSection *updateSection = sectionMaker.section;
        updateSection.tag = tag;
        
        NSString *dictKey = tag ?: kHoloSectionTagNil;
        NSDictionary *sectionIndexDict = self.sectionIndexsDict[dictKey];

        HoloTableSection *targetSection = sectionIndexDict[kHoloTargetSection];
        NSNumber *targetIndex = sectionIndexDict[kHoloTargetIndex];
        
        if (!self.isRemark && targetSection) {
            // set value of CGFloat and BOOL
            unsigned int outCount;
            objc_property_t * properties = class_copyPropertyList([targetSection class], &outCount);
            for (int i = 0; i < outCount; i++) {
                objc_property_t property = properties[i];
                const char * propertyAttr = property_getAttributes(property);
                char t = propertyAttr[1];
                const char *propertyName = property_getName(property);
                NSString *propertyNameStr = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
                // CGFloat or BOOL or rows
                if (t == 'd' || t == 'B' || [propertyNameStr isEqualToString:@"rows"]) {
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
