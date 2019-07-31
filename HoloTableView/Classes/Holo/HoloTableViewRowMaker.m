//
//  HoloTableViewRowMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import "HoloTableViewRowMaker.h"

#define HOLO_SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define HOLO_SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height

//============================================================:HoloRow
@implementation HoloRow

- (instancetype)init {
    self = [super init];
    if (self) {
        _height = CGFLOAT_MIN;
        _estimatedHeight = HOLO_SCREEN_HEIGHT;
        _shouldHighlight = YES;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        _configSEL = @selector(cellForRow:);
        _heightSEL = @selector(heightForRow:);
        _estimatedHeightSEL = @selector(estimatedHeightForRow:);
#pragma clang diagnostic pop
    }
    
    return self;
}

@end

//============================================================:HoloRowMaker
@implementation HoloRowMaker

- (instancetype)init {
    self = [super init];
    if (self) {
        _row = [HoloRow new];
    }
    return self;
}

- (HoloRowMaker *(^)(id))model {
    return ^id(id model){
        self.row.model = model;
        return self;
    };
}

- (HoloRowMaker *(^)(CGFloat))height {
    return ^id(CGFloat height){
        self.row.height = height;
        return self;
    };
}

- (HoloRowMaker *(^)(CGFloat))estimatedHeight {
    return ^id(CGFloat estimatedHeight){
        self.row.estimatedHeight = estimatedHeight;
        return self;
    };
}

- (HoloRowMaker *(^)(NSString *))tag {
    return ^id(NSString *tag){
        self.row.tag = tag;
        return self;
    };
}

- (HoloRowMaker *(^)(SEL))configSEL {
    return ^id(SEL configSEL) {
        self.row.configSEL = configSEL;
        return self;
    };
}

- (HoloRowMaker *(^)(SEL))estimatedHeightSEL {
    return ^id(SEL estimatedHeightSEL) {
        self.row.estimatedHeightSEL = estimatedHeightSEL;
        return self;
    };
}

- (HoloRowMaker *(^)(SEL))heightSEL {
    return ^id(SEL heightSEL) {
        self.row.heightSEL = heightSEL;
        return self;
    };
}

- (HoloRowMaker *(^)(BOOL))shouldHighlight {
    return ^id(BOOL shouldHighlight) {
        self.row.shouldHighlight = shouldHighlight;
        return self;
    };
}

- (HoloRowMaker * (^)(void (^)(id)))willSelectHandler {
    return ^id( void (^willSelectHandler)(id) ){
        self.row.willSelectHandler = willSelectHandler;
        return self;
    };
}

- (HoloRowMaker * (^)(void (^)(id)))willDeselectHandler {
    return ^id( void (^willDeselectHandler)(id) ){
        self.row.willDeselectHandler = willDeselectHandler;
        return self;
    };
}

- (HoloRowMaker * (^)(void (^)(id)))didDeselectHandler {
    return ^id( void (^didDeselectHandler)(id) ){
        self.row.didDeselectHandler = didDeselectHandler;
        return self;
    };
}

- (HoloRowMaker * (^)(void (^)(id)))didSelectHandler {
    return ^id( void (^didSelectHandler)(id) ){
        self.row.didSelectHandler = didSelectHandler;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(UITableViewCell *)))willDisplayHandler {
    return ^id( void (^willDisplayHandler)(UITableViewCell *cell) ){
        self.row.willDisplayHandler = willDisplayHandler;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(UITableViewCell *)))didEndDisplayingHandler {
    return ^id( void (^didEndDisplayingHandler)(UITableViewCell *cell) ){
        self.row.didEndDisplayingHandler = didEndDisplayingHandler;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(id)))didHighlightHandler {
    return ^id( void (^didHighlightHandler)(id) ){
        self.row.didHighlightHandler = didHighlightHandler;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(id)))didUnHighlightHandler {
    return ^id( void (^didUnHighlightHandler)(id) ){
        self.row.didUnHighlightHandler = didUnHighlightHandler;
        return self;
    };
}

@end

//============================================================:HoloTableViewRowMaker
@interface HoloTableViewRowMaker ()

@property (nonatomic, strong) NSMutableArray<HoloRow *> *holoRows;

@end

@implementation HoloTableViewRowMaker

- (HoloRowMaker *(^)(NSString *))row {
    __weak typeof(self) weakSelf = self;
    return ^id(NSString *cell) {
        __weak typeof(weakSelf) strongSelf = weakSelf;
        HoloRowMaker *rowMaker = [HoloRowMaker new];
        rowMaker.row.cell = cell;
        [strongSelf.holoRows addObject:rowMaker.row];
        return rowMaker;
    };
}

- (NSArray<HoloRow *> *)install {
    return self.holoRows;
}

#pragma mark - getter
- (NSMutableArray<HoloRow *> *)holoRows {
    if (!_holoRows) {
        _holoRows = [NSMutableArray new];
    }
    return _holoRows;
}

@end
