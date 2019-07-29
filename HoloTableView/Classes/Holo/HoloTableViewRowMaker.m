//
//  HoloTableViewRowMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import "HoloTableViewRowMaker.h"

//============================================================:HoloRow
@implementation HoloRow

- (instancetype)init {
    self = [super init];
    if (self) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        _configSEL = @selector(cellForRow:);
        _heightSEL = @selector(heightForRow:);
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

- (HoloRowMaker *(^)(NSString *))tag {
    return ^id(NSString *tag){
        self.row.tag = tag;
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
