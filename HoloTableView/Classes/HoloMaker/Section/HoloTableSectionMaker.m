//
//  HoloTableSectionMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2020/6/2.
//

#import "HoloTableSectionMaker.h"
#import "HoloTableSection.h"
#import "HoloTableViewRowMaker.h"

@interface HoloTableSectionMaker ()

@property (nonatomic, strong) HoloTableSection *section;

@end

@implementation HoloTableSectionMaker

- (HoloTableSectionMaker *(^)(NSString *))headerTitle {
    return ^id(id obj) {
        self.section.headerTitle = obj;
        return self;
    };
}

- (HoloTableSectionMaker *(^)(NSString *))footerTitle {
    return ^id(id obj) {
        self.section.footerTitle = obj;
        return self;
    };
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

#pragma mark - priority low
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

- (HoloTableSectionMaker *(^)(NSString *))headerReuseId {
    return ^id(id obj) {
        self.section.headerReuseId = obj;
        return self;
    };
}

- (HoloTableSectionMaker *(^)(NSString *))footerReuseId {
    return ^id(id obj) {
        self.section.footerReuseId = obj;
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

#pragma mark - priority middle
- (HoloTableSectionMaker * (^)(id (^)(void)))headerModelHandler {
    return ^id(id obj) {
        self.section.headerModelHandler = obj;
        return self;
    };
}

- (HoloTableSectionMaker * (^)(id (^)(void)))footerModelHandler {
    return ^id(id obj) {
        self.section.footerModelHandler = obj;
        return self;
    };
}

- (HoloTableSectionMaker * (^)(NSString * (^)(id)))headerReuseIdHandler {
    return ^id(id obj) {
        self.section.headerReuseIdHandler = obj;
        return self;
    };
}

- (HoloTableSectionMaker * (^)(NSString * (^)(id)))footerReuseIdHandler {
    return ^id(id obj) {
        self.section.footerReuseIdHandler = obj;
        return self;
    };
}

- (HoloTableSectionMaker * (^)(CGFloat (^)(id)))headerHeightHandler {
    return ^id(id obj) {
        self.section.headerHeightHandler = obj;
        return self;
    };
}

- (HoloTableSectionMaker * (^)(CGFloat (^)(id)))footerHeightHandler {
    return ^id(id obj) {
        self.section.footerHeightHandler = obj;
        return self;
    };
}

- (HoloTableSectionMaker * (^)(CGFloat (^)(id)))headerEstimatedHeightHandler {
    return ^id(id obj) {
        self.section.headerEstimatedHeightHandler = obj;
        return self;
    };
}

- (HoloTableSectionMaker * (^)(CGFloat (^)(id)))footerEstimatedHeightHandler {
    return ^id(id obj) {
        self.section.footerEstimatedHeightHandler = obj;
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

#pragma mark - priority high
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

- (HoloTableSectionMaker *(^)(SEL))willDisplayHeaderSEL {
    return ^id(SEL s) {
        self.section.willDisplayHeaderSEL = s;
        return self;
    };
}

- (HoloTableSectionMaker *(^)(SEL))willDisplayFooterSEL {
    return ^id(SEL s) {
        self.section.willDisplayFooterSEL = s;
        return self;
    };
}

- (HoloTableSectionMaker *(^)(SEL))didEndDisplayingHeaderSEL {
    return ^id(SEL s) {
        self.section.didEndDisplayingHeaderSEL = s;
        return self;
    };
}

- (HoloTableSectionMaker *(^)(SEL))didEndDisplayingFooterSEL {
    return ^id(SEL s) {
        self.section.didEndDisplayingFooterSEL = s;
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



- (HoloTableSection *)fetchTableSection {
    return self.section;
}

- (void)giveTableSection:(HoloTableSection *)section {
    self.section = section;
}

#pragma mark - getter
- (HoloTableSection *)section {
    if (!_section) {
        _section = [HoloTableSection new];
    }
    return _section;
}

@end
