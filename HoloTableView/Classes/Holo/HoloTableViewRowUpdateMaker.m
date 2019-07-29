//
//  HoloTableViewRowUpdateMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/29.
//

#import "HoloTableViewRowUpdateMaker.h"

//============================================================:HoloUpdateRow
@implementation HoloUpdateRow

@end

//============================================================:HoloRowUpdateMaker
@implementation HoloRowUpdateMaker

- (instancetype)init {
    self = [super init];
    if (self) {
        _updateRow = [HoloUpdateRow new];
    }
    return self;
}

- (HoloRowUpdateMaker *(^)(id))model {
    return ^id(id model){
        self.updateRow.model = model;
        return self;
    };
}

- (HoloRowUpdateMaker *(^)(CGFloat))height {
    return ^id(CGFloat height){
        self.updateRow.height = height;
        return self;
    };
}

@end

//============================================================:HoloTableViewRowUpdateMaker
@interface HoloTableViewRowUpdateMaker ()

@property (nonatomic, strong) NSMutableArray<HoloUpdateRow *> *holoUpdateRows;

@end

@implementation HoloTableViewRowUpdateMaker

- (HoloRowUpdateMaker *(^)(NSString *))tag {
    __weak typeof(self) weakSelf = self;
    return ^id(NSString *tag) {
        __weak typeof(weakSelf) strongSelf = weakSelf;
        HoloRowUpdateMaker *rowMaker = [HoloRowUpdateMaker new];
        rowMaker.updateRow.tag = tag;
        [strongSelf.holoUpdateRows addObject:rowMaker.updateRow];
        return rowMaker;
    };
}

- (NSArray<HoloUpdateRow *> *)install {
    return self.holoUpdateRows;
}

#pragma mark - getter
- (NSMutableArray<HoloUpdateRow *> *)holoUpdateRows {
    if (!_holoUpdateRows) {
        _holoUpdateRows = [NSMutableArray new];
    }
    return _holoUpdateRows;
}

@end
