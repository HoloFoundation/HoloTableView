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
        _configSEL = @selector(holo_configureCellWithModel:);
        _heightSEL = @selector(holo_heightForCellWithModel:);
        _estimatedHeightSEL = @selector(holo_estimatedHeightForCellWithModel:);
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
        _tableRow = [HoloTableRow new];
    }
    return self;
}

- (HoloTableRowMaker * (^)(Class))row {
    return ^id(Class cls) {
        self.tableRow.cell = NSStringFromClass(cls);
        return self;
    };
}

- (HoloTableRowMaker *(^)(NSString *))rowS {
    return ^id(id obj) {
        self.tableRow.cell = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(id))model {
    return ^id(id obj) {
        self.tableRow.model = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(CGFloat))height {
    return ^id(CGFloat f) {
        self.tableRow.height = f;
        return self;
    };
}

- (HoloTableRowMaker *(^)(CGFloat))estimatedHeight {
    return ^id(CGFloat f) {
        self.tableRow.estimatedHeight = f;
        return self;
    };
}

- (HoloTableRowMaker *(^)(NSString *))tag {
    return ^id(id obj) {
        self.tableRow.tag = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))configSEL {
    return ^id(SEL s) {
        self.tableRow.configSEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))estimatedHeightSEL {
    return ^id(SEL s) {
        self.tableRow.estimatedHeightSEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))heightSEL {
    return ^id(SEL s) {
        self.tableRow.heightSEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(BOOL))shouldHighlight {
    return ^id(BOOL b) {
        self.tableRow.shouldHighlight = b;
        return self;
    };
}

- (HoloTableRowMaker * (^)(void (^)(id)))willSelectHandler {
    return ^id(id obj) {
        self.tableRow.willSelectHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker * (^)(void (^)(id)))willDeselectHandler {
    return ^id(id obj) {
        self.tableRow.willDeselectHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker * (^)(void (^)(id)))didDeselectHandler {
    return ^id(id obj) {
        self.tableRow.didDeselectHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker * (^)(void (^)(id)))didSelectHandler {
    return ^id(id obj) {
        self.tableRow.didSelectHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(void (^)(UITableViewCell *, id)))willDisplayHandler {
    return ^id(id obj) {
        self.tableRow.willDisplayHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(void (^)(UITableViewCell *, id)))didEndDisplayingHandler {
    return ^id(id obj) {
        self.tableRow.didEndDisplayingHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(void (^)(id)))didHighlightHandler {
    return ^id(id obj) {
        self.tableRow.didHighlightHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(void (^)(id)))didUnHighlightHandler {
    return ^id(id obj) {
        self.tableRow.didUnHighlightHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(void (^)(id)))accessoryHandler {
    return ^id(id obj) {
        self.tableRow.accessoryHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(BOOL))canEdit {
    return ^id(BOOL b) {
        self.tableRow.canEdit = b;
        return self;
    };
}

- (HoloTableRowMaker *(^)(NSArray *))leadingSwipeActions {
    return ^id(NSArray *a) {
        if (a.count > 0) self.tableRow.canEdit = YES;
        self.tableRow.leadingSwipeActions = a;
        return self;
    };
}

- (HoloTableRowMaker *(^)(NSArray *))trailingSwipeActions {
    return ^id(NSArray *a) {
        if (a.count > 0) self.tableRow.canEdit = YES;
        self.tableRow.trailingSwipeActions = a;
        return self;
    };
}

- (HoloTableRowMaker *(^)(void (^)(id, NSInteger, void(^)(BOOL))))leadingSwipeHandler {
    return ^id(id obj) {
        self.tableRow.leadingSwipeHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(void (^)(id, NSInteger, void(^)(BOOL))))trailingSwipeHandler {
    return ^id(id obj) {
        self.tableRow.trailingSwipeHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(void (^)(id)))willBeginSwipingHandler {
    return ^id(id obj) {
        self.tableRow.willBeginSwipingHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(void (^)(id)))didEndSwipingHandler {
    return ^id(id obj) {
        self.tableRow.didEndSwipingHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(BOOL))canMove {
    return ^id(BOOL b) {
        if (b) self.tableRow.canEdit = YES;
        self.tableRow.canMove = b;
        return self;
    };
}

- (HoloTableRowMaker *(^)(NSIndexPath *(^)(NSIndexPath *, NSIndexPath *)))targetMoveHandler {
    return ^id(id obj) {
        self.tableRow.targetMoveHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(void (^)(NSIndexPath *, NSIndexPath *, void(^)(BOOL))))moveHandler {
    return ^id(id obj) {
        if (obj) {
            self.tableRow.canEdit = YES;
            self.tableRow.canMove = YES;
        }
        self.tableRow.moveHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(NSString *))editingDeleteTitle {
    return ^id(id obj) {
        self.tableRow.editingDeleteTitle = obj;
        return self;
    };
}

- (HoloTableRowMaker * (^)(void (^)(id, void (^)(BOOL))))editingDeleteHandler {
    return ^id(id obj) {
        if (obj) {
            self.tableRow.canEdit = YES;
            self.tableRow.editingStyle = UITableViewCellEditingStyleDelete;
        }
        self.tableRow.editingDeleteHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(void (^)(id)))editingInsertHandler {
    return ^id(id obj) {
        if (obj) {
            self.tableRow.canEdit = YES;
            self.tableRow.editingStyle = UITableViewCellEditingStyleInsert;
        }
        self.tableRow.editingInsertHandler = obj;
        return self;
    };
}

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewRowMaker ()

@property (nonatomic, strong) NSMutableArray<HoloTableRow *> *holoRows;

@end

@implementation HoloTableViewRowMaker

- (HoloTableRowMaker * (^)(Class))row {
    return ^id(Class cls) {
        HoloTableRowMaker *rowMaker = [HoloTableRowMaker new];
        rowMaker.tableRow.cell = NSStringFromClass(cls);
        [self.holoRows addObject:rowMaker.tableRow];
        return rowMaker;
    };
}

- (HoloTableRowMaker *(^)(NSString *))rowS {
    return ^id(id obj) {
        HoloTableRowMaker *rowMaker = [HoloTableRowMaker new];
        rowMaker.tableRow.cell = obj;
        [self.holoRows addObject:rowMaker.tableRow];
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
