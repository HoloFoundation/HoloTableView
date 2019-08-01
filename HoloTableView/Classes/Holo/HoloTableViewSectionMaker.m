//
//  HoloTableViewSectionMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import "HoloTableViewSectionMaker.h"
#import "HoloTableViewRowMaker.h"
#import "HoloTableViewUpdateRowMaker.h"

//============================================================:HoloSection
@implementation HoloSection

- (instancetype)init {
    self = [super init];
    if (self) {
        _rows = [NSArray new];
        _headerHeight = CGFLOAT_MIN;
        _footerHeight = CGFLOAT_MIN;
    }
    return self;
}

- (void)holo_appendRows:(NSArray<HoloRow *> *)rows {
    if (rows.count <= 0) return;
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.rows];
    [array addObjectsFromArray:rows];
    self.rows = array;
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

//============================================================:HoloSectionMaker
@implementation HoloSectionMaker

- (instancetype)init {
    self = [super init];
    if (self) {
        _section = [HoloSection new];
    }
    return self;
}

- (HoloSectionMaker *(^)(UIView *))header {
    return ^id(UIView *header) {
        self.section.header = header;
        return self;
    };
}

- (HoloSectionMaker *(^)(UIView *))footer {
    return ^id(UIView *footer) {
        self.section.footer = footer;
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

- (HoloSectionMaker *(^)(void (^)(UIView *)))willDisplayHeaderHandler {
    return ^id( void (^willDisplayHeaderHandler)(id) ){
        self.section.willDisplayHeaderHandler = willDisplayHeaderHandler;
        return self;
    };
}

- (HoloSectionMaker *(^)(void (^)(UIView *)))willDisplayFooterHandler {
    return ^id( void (^willDisplayFooterHandler)(id) ){
        self.section.willDisplayFooterHandler = willDisplayFooterHandler;
        return self;
    };
}

- (HoloSectionMaker *(^)(void (^)(UIView *)))didEndDisplayingHeaderHandler {
    return ^id( void (^didEndDisplayingHeaderHandler)(id) ){
        self.section.didEndDisplayingHeaderHandler = didEndDisplayingHeaderHandler;
        return self;
    };
}

- (HoloSectionMaker *(^)(void (^)(UIView *)))didEndDisplayingFooterHandler {
    return ^id( void (^didEndDisplayingFooterHandler)(id) ){
        self.section.didEndDisplayingFooterHandler = didEndDisplayingFooterHandler;
        return self;
    };
}

@end

//============================================================:HoloTableViewSectionMaker
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
        for (HoloSection *section in self.targetSections) {
            if ([section.tag isEqualToString:tag] || (!section.tag && !tag)) {
                
                updateSection.headerHeight = section.headerHeight;
                updateSection.footerHeight = section.footerHeight;
                
                targetSection = section;
                break;
            }
        }
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if (targetSection) {
            dict[@"targetSection"] = targetSection;
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
