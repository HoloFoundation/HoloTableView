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
    return ^id(void (^willSelectHandler)(id)){
        self.row.willSelectHandler = willSelectHandler;
        return self;
    };
}

- (HoloRowMaker * (^)(void (^)(id)))willDeselectHandler {
    return ^id(void (^willDeselectHandler)(id)) {
        self.row.willDeselectHandler = willDeselectHandler;
        return self;
    };
}

- (HoloRowMaker * (^)(void (^)(id)))didDeselectHandler {
    return ^id(void (^didDeselectHandler)(id)) {
        self.row.didDeselectHandler = didDeselectHandler;
        return self;
    };
}

- (HoloRowMaker * (^)(void (^)(id)))didSelectHandler {
    return ^id(void (^didSelectHandler)(id)) {
        self.row.didSelectHandler = didSelectHandler;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(UITableViewCell *, id)))willDisplayHandler {
    return ^id(void (^willDisplayHandler)(UITableViewCell *, id)) {
        self.row.willDisplayHandler = willDisplayHandler;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(UITableViewCell *, id)))didEndDisplayingHandler {
    return ^id(void (^didEndDisplayingHandler)(UITableViewCell *, id)) {
        self.row.didEndDisplayingHandler = didEndDisplayingHandler;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(id)))didHighlightHandler {
    return ^id(void (^didHighlightHandler)(id)) {
        self.row.didHighlightHandler = didHighlightHandler;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(id)))didUnHighlightHandler {
    return ^id(void (^didUnHighlightHandler)(id)) {
        self.row.didUnHighlightHandler = didUnHighlightHandler;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(id)))accessoryHandler {
    return ^id(void (^accessoryHandler)(id)) {
        self.row.accessoryHandler = accessoryHandler;
        return self;
    };
}

- (HoloRowMaker *(^)(BOOL))canEdit {
    return ^id(BOOL canEdit) {
        self.row.canEdit = canEdit;
        return self;
    };
}

- (HoloRowMaker *(^)(NSArray *))leadingSwipeActions {
    return ^id(NSArray *leadingSwipeActions) {
        if (leadingSwipeActions.count > 0) self.row.canEdit = YES;
        self.row.leadingSwipeActions = leadingSwipeActions;
        return self;
    };
}

- (HoloRowMaker *(^)(NSArray *))trailingSwipeActions {
    return ^id(NSArray *trailingSwipeActions) {
        if (trailingSwipeActions.count > 0) self.row.canEdit = YES;
        self.row.trailingSwipeActions = trailingSwipeActions;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(id, NSInteger, void(^)(BOOL))))leadingSwipeHandler {
    return ^id(void (^leadingSwipeHandler)(id, NSInteger, void(^)(BOOL))) {
        self.row.leadingSwipeHandler = leadingSwipeHandler;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(id, NSInteger, void(^)(BOOL))))trailingSwipeHandler {
    return ^id(void (^trailingSwipeHandler)(id, NSInteger, void(^)(BOOL))) {
        self.row.trailingSwipeHandler = trailingSwipeHandler;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(id)))willBeginSwipingHandler {
    return ^id(void (^willBeginSwipingHandler)(id)) {
        self.row.willBeginSwipingHandler = willBeginSwipingHandler;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(id)))didEndSwipingHandler {
    return ^id(void (^didEndSwipingHandler)(id)) {
        self.row.didEndSwipingHandler = didEndSwipingHandler;
        return self;
    };
}

- (HoloRowMaker *(^)(BOOL))canMove {
    return ^id(BOOL canMove) {
        if (canMove) self.row.canEdit = YES;
        self.row.canMove = canMove;
        return self;
    };
}

- (HoloRowMaker *(^)(NSIndexPath *(^)(NSIndexPath *, NSIndexPath *)))targetMoveHandler {
    return ^id(NSIndexPath *(^targetMoveHandler)(NSIndexPath *, NSIndexPath *)) {
        self.row.targetMoveHandler = targetMoveHandler;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(NSIndexPath *, NSIndexPath *, void(^)(BOOL))))moveHandler {
    return ^id(void (^moveHandler)(NSIndexPath *, NSIndexPath *, void(^)(BOOL))) {
        if (moveHandler) {
            self.row.canEdit = YES;
            self.row.canMove = YES;
        }
        self.row.moveHandler = moveHandler;
        return self;
    };
}

- (HoloRowMaker *(^)(NSString *))editingDeleteTitle {
    return ^id(NSString *editingDeleteTitle) {
        self.row.editingDeleteTitle = editingDeleteTitle;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(id)))editingDeleteHandler {
    return ^id(void (^editingDeleteHandler)(id)) {
        if (editingDeleteHandler) {
            self.row.canEdit = YES;
            self.row.editingStyle = UITableViewCellEditingStyleDelete;
        }
        self.row.editingDeleteHandler = editingDeleteHandler;
        return self;
    };
}

- (HoloRowMaker *(^)(void (^)(id)))editingInsertHandler {
    return ^id(void (^editingInsertHandler)(id)) {
        if (editingInsertHandler) {
            self.row.canEdit = YES;
            self.row.editingStyle = UITableViewCellEditingStyleInsert;
        }
        self.row.editingInsertHandler = editingInsertHandler;
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
    return ^id(NSString *cell) {
        HoloRowMaker *rowMaker = [HoloRowMaker new];
        rowMaker.row.cell = cell;
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
