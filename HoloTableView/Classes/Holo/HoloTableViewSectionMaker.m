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

@property (nonatomic, strong) NSMutableArray<HoloSection *> *holoSections;

@end

@implementation HoloTableViewSectionMaker

- (HoloSectionMaker *(^)(NSString *))section {
    __weak typeof(self) weakSelf = self;
    return ^id(NSString *tag) {
        __weak typeof(weakSelf) strongSelf = weakSelf;
        HoloSectionMaker *sectionMaker = [HoloSectionMaker new];
        sectionMaker.section.tag = tag;
        [strongSelf.holoSections addObject:sectionMaker.section];
        return sectionMaker;
    };
}

- (NSArray<HoloSection *> *)install {
    return self.holoSections;
}

#pragma mark - getter
- (NSMutableArray<HoloSection *> *)holoSections {
    if (!_holoSections) {
        _holoSections = [NSMutableArray new];
    }
    return _holoSections;
}


@end
