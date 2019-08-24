//
//  HoloTableViewRowMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import "HoloTableViewRowMaker.h"
#import "HoloTableViewMacro.h"

////////////////////////////////////////////////////////////
@implementation HoloTableRow

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
@implementation HoloTableRowMaker

- (instancetype)init {
    self = [super init];
    if (self) {
        _row = [HoloTableRow new];
    }
    return self;
}

- (HoloTableRowMaker *(^)(id))model {
    return ^id(id obj) {
        self.row.model = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(CGFloat))height {
    return ^id(CGFloat f) {
        self.row.height = f;
        return self;
    };
}

- (HoloTableRowMaker *(^)(CGFloat))estimatedHeight {
    return ^id(CGFloat f) {
        self.row.estimatedHeight = f;
        return self;
    };
}

- (HoloTableRowMaker *(^)(NSString *))tag {
    return ^id(id obj) {
        self.row.tag = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))configSEL {
    return ^id(SEL s) {
        self.row.configSEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))estimatedHeightSEL {
    return ^id(SEL s) {
        self.row.estimatedHeightSEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))heightSEL {
    return ^id(SEL s) {
        self.row.heightSEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(BOOL))shouldHighlight {
    return ^id(BOOL b) {
        self.row.shouldHighlight = b;
        return self;
    };
}

- (HoloTableRowMaker * (^)(void (^)(id)))willSelectHandler {
    return ^id(id obj) {
        self.row.willSelectHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker * (^)(void (^)(id)))willDeselectHandler {
    return ^id(id obj) {
        self.row.willDeselectHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker * (^)(void (^)(id)))didDeselectHandler {
    return ^id(id obj) {
        self.row.didDeselectHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker * (^)(void (^)(id)))didSelectHandler {
    return ^id(id obj) {
        self.row.didSelectHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(void (^)(UITableViewCell *, id)))willDisplayHandler {
    return ^id(id obj) {
        self.row.willDisplayHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(void (^)(UITableViewCell *, id)))didEndDisplayingHandler {
    return ^id(id obj) {
        self.row.didEndDisplayingHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(void (^)(id)))didHighlightHandler {
    return ^id(id obj) {
        self.row.didHighlightHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(void (^)(id)))didUnHighlightHandler {
    return ^id(id obj) {
        self.row.didUnHighlightHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(void (^)(id)))accessoryHandler {
    return ^id(id obj) {
        self.row.accessoryHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(BOOL))canEdit {
    return ^id(BOOL b) {
        self.row.canEdit = b;
        return self;
    };
}

- (HoloTableRowMaker *(^)(NSArray *))leadingSwipeActions {
    return ^id(NSArray *a) {
        if (a.count > 0) self.row.canEdit = YES;
        self.row.leadingSwipeActions = a;
        return self;
    };
}

- (HoloTableRowMaker *(^)(NSArray *))trailingSwipeActions {
    return ^id(NSArray *a) {
        if (a.count > 0) self.row.canEdit = YES;
        self.row.trailingSwipeActions = a;
        return self;
    };
}

- (HoloTableRowMaker *(^)(void (^)(id, NSInteger, void(^)(BOOL))))leadingSwipeHandler {
    return ^id(id obj) {
        self.row.leadingSwipeHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(void (^)(id, NSInteger, void(^)(BOOL))))trailingSwipeHandler {
    return ^id(id obj) {
        self.row.trailingSwipeHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(void (^)(id)))willBeginSwipingHandler {
    return ^id(id obj) {
        self.row.willBeginSwipingHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(void (^)(id)))didEndSwipingHandler {
    return ^id(id obj) {
        self.row.didEndSwipingHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(BOOL))canMove {
    return ^id(BOOL b) {
        if (b) self.row.canEdit = YES;
        self.row.canMove = b;
        return self;
    };
}

- (HoloTableRowMaker *(^)(NSIndexPath *(^)(NSIndexPath *, NSIndexPath *)))targetMoveHandler {
    return ^id(id obj) {
        self.row.targetMoveHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(void (^)(NSIndexPath *, NSIndexPath *, void(^)(BOOL))))moveHandler {
    return ^id(id obj) {
        if (obj) {
            self.row.canEdit = YES;
            self.row.canMove = YES;
        }
        self.row.moveHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(NSString *))editingDeleteTitle {
    return ^id(id obj) {
        self.row.editingDeleteTitle = obj;
        return self;
    };
}

- (HoloTableRowMaker * (^)(void (^)(id, void (^)(BOOL))))editingDeleteHandler {
    return ^id(id obj) {
        if (obj) {
            self.row.canEdit = YES;
            self.row.editingStyle = UITableViewCellEditingStyleDelete;
        }
        self.row.editingDeleteHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(void (^)(id)))editingInsertHandler {
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

@property (nonatomic, strong) NSMutableArray<HoloTableRow *> *holoRows;

@end

@implementation HoloTableViewRowMaker

- (HoloTableRowMaker *(^)(NSString *))row {
    return ^id(id obj) {
        HoloTableRowMaker *rowMaker = [HoloTableRowMaker new];
        rowMaker.row.cell = obj;
        [self.holoRows addObject:rowMaker.row];
        return rowMaker;
    };
}

- (NSArray<HoloTableRow *> *)install {
    return self.holoRows;
}

#pragma mark - getter
- (NSMutableArray<HoloTableRow *> *)holoRows {
    if (!_holoRows) {
        _holoRows = [NSMutableArray new];
    }
    return _holoRows;
}

@end
