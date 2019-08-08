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
#import "HoloTableViewUpdateRowMaker.h"

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
        _headerFooterConfigSEL = @selector(configHeaderFooterWithModel:);
        _headerFooterHeightSEL = @selector(heightForHeaderFooterWithModel:);
        _headerFooterEstimatedHeightSEL = @selector(estimatedHeightForHeaderFooterWithModel:);
#pragma clang diagnostic pop
    }
    return self;
}

- (NSIndexSet *)holo_appendRows:(NSArray<HoloRow *> *)rows {
    if (rows.count <= 0) return nil;
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.rows.count, rows.count)];
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.rows];
    [array addObjectsFromArray:rows];
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
    return ^id(NSString *header) {
        self.section.header = header;
        return self;
    };
}

- (HoloSectionMaker *(^)(NSString *))footer {
    return ^id(NSString *footer) {
        self.section.footer = footer;
        return self;
    };
}

- (HoloSectionMaker * (^)(id))headerModel {
    return ^id(id headerModel) {
        self.section.headerModel = headerModel;
        return self;
    };
}

- (HoloSectionMaker * (^)(id))footerModel {
    return ^id(id footerModel) {
        self.section.footerModel = footerModel;
        return self;
    };
}

- (HoloSectionMaker *(^)(CGFloat))headerHeight {
    return ^id(CGFloat headerHeight) {
        self.section.headerHeight = headerHeight;
        return self;
    };
}

- (HoloSectionMaker *(^)(CGFloat))footerHeight {
    return ^id(CGFloat footerHeight) {
        self.section.footerHeight = footerHeight;
        return self;
    };
}

- (HoloSectionMaker *(^)(CGFloat))headerEstimatedHeight {
    return ^id(CGFloat headerEstimatedHeight) {
        self.section.headerEstimatedHeight = headerEstimatedHeight;
        return self;
    };
}

- (HoloSectionMaker *(^)(CGFloat))footerEstimatedHeight {
    return ^id(CGFloat footerEstimatedHeight) {
        self.section.footerEstimatedHeight = footerEstimatedHeight;
        return self;
    };
}

- (HoloSectionMaker *(^)(SEL))headerFooterConfigSEL {
    return ^id(SEL headerFooterConfigSEL) {
        self.section.headerFooterConfigSEL = headerFooterConfigSEL;
        return self;
    };
}

- (HoloSectionMaker *(^)(SEL))headerFooterHeightSEL {
    return ^id(SEL headerFooterHeightSEL) {
        self.section.headerFooterHeightSEL = headerFooterHeightSEL;
        return self;
    };
}

- (HoloSectionMaker *(^)(SEL))headerFooterEstimatedHeightSEL {
    return ^id(SEL headerFooterEstimatedHeightSEL) {
        self.section.headerFooterEstimatedHeightSEL = headerFooterEstimatedHeightSEL;
        return self;
    };
}

- (HoloSectionMaker *(^)(void (^)(UIView *)))willDisplayHeaderHandler {
    return ^id(void (^willDisplayHeaderHandler)(id)) {
        self.section.willDisplayHeaderHandler = willDisplayHeaderHandler;
        return self;
    };
}

- (HoloSectionMaker *(^)(void (^)(UIView *)))willDisplayFooterHandler {
    return ^id(void (^willDisplayFooterHandler)(id)) {
        self.section.willDisplayFooterHandler = willDisplayFooterHandler;
        return self;
    };
}

- (HoloSectionMaker *(^)(void (^)(UIView *)))didEndDisplayingHeaderHandler {
    return ^id(void (^didEndDisplayingHeaderHandler)(id)) {
        self.section.didEndDisplayingHeaderHandler = didEndDisplayingHeaderHandler;
        return self;
    };
}

- (HoloSectionMaker *(^)(void (^)(UIView *)))didEndDisplayingFooterHandler {
    return ^id(void (^didEndDisplayingFooterHandler)(id)) {
        self.section.didEndDisplayingFooterHandler = didEndDisplayingFooterHandler;
        return self;
    };
}

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewSectionMaker ()

@property (nonatomic, copy) NSArray<HoloSection *> *targetSections;

@property (nonatomic, strong) NSMutableArray<NSDictionary *> *holoUpdateSections;

@end

@implementation HoloTableViewSectionMaker

- (instancetype)initWithProxyDataSections:(NSArray<HoloSection *> *)sections {
    self = [super init];
    if (self) {
        _targetSections = sections;
    }
    return self;
}

- (HoloSectionMaker *(^)(NSString *))section {
    return ^id(NSString *tag) {
        HoloSectionMaker *sectionMaker = [HoloSectionMaker new];
        HoloSection *updateSection = sectionMaker.section;
        updateSection.tag = tag;
        
        HoloSection *targetSection;
        NSNumber *targetIndex;
        for (HoloSection *section in self.targetSections) {
            if ([section.tag isEqualToString:tag] || (!section.tag && !tag)) {
                
                // set value of CGFloat and BOOL
                unsigned int outCount;
                objc_property_t * properties = class_copyPropertyList([section class], &outCount);
                for (int i = 0; i < outCount; i++) {
                    objc_property_t property = properties[i];
                    const char * propertyAttr = property_getAttributes(property);
                    char t = propertyAttr[1];
                    if (t == 'd' || t == 'B') { // CGFloat or BOOL
                        const char *propertyName = property_getName(property);
                        NSString *propertyNameStr = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
                        id value = [section valueForKey:propertyNameStr];
                        if (value) [updateSection setValue:value forKey:propertyNameStr];
                    }
                }
                
                // set value of SEL
                updateSection.headerFooterConfigSEL = section.headerFooterConfigSEL;
                updateSection.headerFooterHeightSEL = section.headerFooterHeightSEL;
                updateSection.headerFooterEstimatedHeightSEL = section.headerFooterEstimatedHeightSEL;
                
                targetSection = section;
                targetIndex = [NSNumber numberWithInteger:[self.targetSections indexOfObject:section]];
                break;
            }
        }
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if (targetSection) {
            dict[@"targetSection"] = targetSection;
            dict[@"targetIndex"] = targetIndex;
        }
        dict[@"updateSection"] = updateSection;
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


@end
