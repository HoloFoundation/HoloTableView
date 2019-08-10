//
//  HoloTableViewRowMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import "HoloTableViewRowMaker.h"
#import "HoloTableViewMacro.h"

////////////////////////////////////////////////////////////
@implementation HoloRow

- (instancetype)init {
    self = [super init];
    if (self) {
        _height = CGFLOAT_MIN;
        _estimatedHeight = HOLO_SCREEN_HEIGHT;
        _shouldHighlight = YES;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        _configSEL = @selector(configureCellWithModel:);
        _heightSEL = @selector(heightForCellWithModel:);
        _estimatedHeightSEL = @selector(estimatedHeightForCellWithModel:);
#pragma clang diagnostic pop
        _canEdit = NO;
        _canMove = NO;
        _editingStyle = UITableViewCellEditingStyleNone;
    }
    
    return self;
}

@end

////////////////////////////////////////////////////////////
@implementation HoloRowMaker

- (instancetype)init {
    self = [super init];
    if (self) {
        _row = [HoloRow new];
    }
    return self;
}

- (HoloRowMaker *(^)(id))model {
    return ^id(id obj) {
        self.row.model = obj;
        return self;
    };
}

- (HoloRowMaker *(^)(CGFloat))height {
    return ^id(CGFloat f) {
        self.row.height = f;
        return self;
    };
}

- (HoloRowMaker *(^)(CGFloat))estimatedHeight {
    return ^id(CGFloat f) {
        self.row.estimatedHeight = f;
        return self;
    };
}

- (HoloRowMaker *(^)(NSString *))tag {
    return ^id(id obj) {
        self.row.tag = obj;
        return self;
    };
}

- (HoloRowMaker *(^)(SEL))configSEL {
    return ^id(SEL s) {
        self.row.configSEL = s;
        return self;
    };
}

- (HoloRowMaker *(^)(SEL))estimatedHeightSEL {
    return ^id(SEL s) {
        self.row.estimatedHeightSEL = s;
        return self;
    };
}

- (HoloRowMaker *(^)(SEL))heightSEL {
    return ^id(SEL s) {
        self.row.heightSEL = s;
        return self;
    };
}

- (HoloRowMaker *(^)(BOOL))shouldHighlight {
    return ^id(BOOL b) {
        self.row.shouldHighlight = b;
        return self;
    };
}

- (HoloRowMaker * (^)(void (^)(id)))willSelectHandler {
    return ^id(id obj) {
        self.row.willSelectHandler = obj;
        return self;
    };
}

- (HoloRowMaker * (^)(void (^)(id)))willDeselectHandler {
    return ^id(id obj) {
        self.row.willDeselectHandler = obj;
        return self;
    };
}

- (HoloRowMaker * (^)(void (^)(id)))didDeselectHandler {
    return ^id(id obj) {
        self.row.didDeselectHandler = obj;
        return self;
    };
}

- (HoloRowMaker * (^)(void (^)(id)))didSelectHandler {
    return ^id(id obj) {
        self.row.didSelectHandler = obj;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(UITableViewCell *, id)))willDisplayHandler {
    return ^id(id obj) {
        self.row.willDisplayHandler = obj;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(UITableViewCell *, id)))didEndDisplayingHandler {
    return ^id(id obj) {
        self.row.didEndDisplayingHandler = obj;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(id)))didHighlightHandler {
    return ^id(id obj) {
        self.row.didHighlightHandler = obj;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(id)))didUnHighlightHandler {
    return ^id(id obj) {
        self.row.didUnHighlightHandler = obj;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(id)))accessoryHandler {
    return ^id(id obj) {
        self.row.accessoryHandler = obj;
        return self;
    };
}

- (HoloRowMaker *(^)(BOOL))canEdit {
    return ^id(BOOL b) {
        self.row.canEdit = b;
        return self;
    };
}

- (HoloRowMaker *(^)(NSArray *))leadingSwipeActions {
    return ^id(NSArray *a) {
        if (a.count > 0) self.row.canEdit = YES;
        self.row.leadingSwipeActions = a;
        return self;
    };
}

- (HoloRowMaker *(^)(NSArray *))trailingSwipeActions {
    return ^id(NSArray *a) {
        if (a.count > 0) self.row.canEdit = YES;
        self.row.trailingSwipeActions = a;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(id, NSInteger, void(^)(BOOL))))leadingSwipeHandler {
    return ^id(id obj) {
        self.row.leadingSwipeHandler = obj;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(id, NSInteger, void(^)(BOOL))))trailingSwipeHandler {
    return ^id(id obj) {
        self.row.trailingSwipeHandler = obj;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(id)))willBeginSwipingHandler {
    return ^id(id obj) {
        self.row.willBeginSwipingHandler = obj;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(id)))didEndSwipingHandler {
    return ^id(id obj) {
        self.row.didEndSwipingHandler = obj;
        return self;
    };
}

- (HoloRowMaker *(^)(BOOL))canMove {
    return ^id(BOOL b) {
        if (b) self.row.canEdit = YES;
        self.row.canMove = b;
        return self;
    };
}

- (HoloRowMaker *(^)(NSIndexPath *(^)(NSIndexPath *, NSIndexPath *)))targetMoveHandler {
    return ^id(id obj) {
        self.row.targetMoveHandler = obj;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(NSIndexPath *, NSIndexPath *, void(^)(BOOL))))moveHandler {
    return ^id(id obj) {
        if (obj) {
            self.row.canEdit = YES;
            self.row.canMove = YES;
        }
        self.row.moveHandler = obj;
        return self;
    };
}

- (HoloRowMaker *(^)(NSString *))editingDeleteTitle {
    return ^id(id obj) {
        self.row.editingDeleteTitle = obj;
        return self;
    };
}

- (HoloRowMaker * (^)(void (^)(id, void (^)(BOOL))))editingDeleteHandler {
    return ^id(id obj) {
        if (obj) {
            self.row.canEdit = YES;
            self.row.editingStyle = UITableViewCellEditingStyleDelete;
        }
        self.row.editingDeleteHandler = obj;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(id)))editingInsertHandler {
    return ^id(id obj) {
        if (obj) {
            self.row.canEdit = YES;
            self.row.editingStyle = UITableViewCellEditingStyleInsert;
        }
        self.row.editingInsertHandler = obj;
        return self;
    };
}

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewRowMaker ()

@property (nonatomic, strong) NSMutableArray<HoloRow *> *holoRows;

@end

@implementation HoloTableViewRowMaker

- (HoloRowMaker *(^)(NSString *))row {
    return ^id(id obj) {
        HoloRowMaker *rowMaker = [HoloRowMaker new];
        rowMaker.row.cell = obj;
        [self.holoRows addObject:rowMaker.row];
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
