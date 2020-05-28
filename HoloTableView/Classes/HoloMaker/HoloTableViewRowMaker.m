//
//  HoloTableViewRowMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import "HoloTableViewRowMaker.h"

////////////////////////////////////////////////////////////
@implementation HoloTableRow

- (instancetype)init {
    self = [super init];
    if (self) {
        _height = CGFLOAT_MIN;
        _estimatedHeight = CGFLOAT_MIN;
        _shouldHighlight = YES;
        _style = UITableViewCellStyleDefault;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        _configSEL              = @selector(holo_configureCellWithModel:);
        _heightSEL              = @selector(holo_heightForCellWithModel:);
        _estimatedHeightSEL     = @selector(holo_estimatedHeightForCellWithModel:);
        _shouldHighlightSEL     = @selector(holo_shouldHighlightForCellWithModel:);
        _canEditSEL             = @selector(holo_canEditForCellWithModel:);
        _canMoveSEL             = @selector(holo_canMoveForCellWithModel:);
        _leadingSwipeActionsSEL     = @selector(holo_leadingSwipeActionsForCellWithModel:);
        _trailingSwipeActionsSEL    = @selector(holo_trailingSwipeActionsForCellWithModel:);
        _editingDeleteTitleSEL      = @selector(holo_editingDeleteTitleForCellWithModel:);
        _editingStyleSEL        = @selector(holo_editingStyleForCellWithModel:);
        _willSelectSEL          = @selector(holo_willSelectCellWithModel:);
        _willDeselectSEL        = @selector(holo_willDeselectCellWithModel:);
        _didDeselectSEL         = @selector(holo_didDeselectCellWithModel:);
        _didSelectSEL           = @selector(holo_didSelectCellWithModel:);
        _willDisplaySEL         = @selector(holo_willDisplayCellWithModel:);
        _didEndDisplayingSEL    = @selector(holo_didEndDisplayingCellWithModel:);
        _didHighlightSEL        = @selector(holo_didHighlightCellWithModel:);
        _didUnHighlightSEL      = @selector(holo_didUnHighlightCellWithModel:);
        _accessorySEL           = @selector(holo_accessoryCellWithModel:);
        _willBeginEditingSEL    = @selector(holo_willBeginEditingCellWithModel:);
        _didEndEditingSEL       = @selector(holo_didEndEditingCellWithModel:);
        
        // support set a delegate for cell
        _delegateSEL = @selector(holo_configureCellDelegate:);
#pragma clang diagnostic pop
        _canEdit = NO;
        _canMove = NO;
        _editingStyle = UITableViewCellEditingStyleNone;
    }
    
    return self;
}

@end

////////////////////////////////////////////////////////////
@interface HoloTableRowMaker ()

@property (nonatomic, strong) HoloTableRow *tableRow;

@end

@implementation HoloTableRowMaker

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

#pragma mark - priority low
- (HoloTableRowMaker *(^)(id))model {
    return ^id(id obj) {
        self.tableRow.model = obj;
        return self;
    };
}

- (HoloTableRowMaker * (^)(UITableViewCellStyle))style {
    return ^id(UITableViewCellStyle style) {
        self.tableRow.style = style;
        return self;
    };
}

- (HoloTableRowMaker * (^)(NSString *))reuseId {
    return ^id(id obj) {
        self.tableRow.reuseId = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(NSString *))tag {
    return ^id(id obj) {
        self.tableRow.tag = obj;
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

- (HoloTableRowMaker *(^)(BOOL))shouldHighlight {
    return ^id(BOOL b) {
        self.tableRow.shouldHighlight = b;
        return self;
    };
}

- (HoloTableRowMaker *(^)(BOOL))canEdit {
    return ^id(BOOL b) {
        self.tableRow.canEdit = b;
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

- (HoloTableRowMaker *(^)(NSArray *))leadingSwipeActions {
    return ^id(NSArray *a) {
        if (a.count > 0) self.tableRow.canEdit = YES;
        if (@available(iOS 11.0, *)) {
            self.tableRow.leadingSwipeActions = a;
        }
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

- (HoloTableRowMaker *(^)(NSString *))editingDeleteTitle {
    return ^id(id obj) {
        self.tableRow.editingDeleteTitle = obj;
        return self;
    };
}

#pragma mark - priority middle
- (HoloTableRowMaker * (^)(id (^)(void)))modelHandler {
    return ^id(id obj) {
        self.tableRow.modelHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker * (^)(UITableViewCellStyle (^)(id)))styleHandler {
    return ^id(id obj) {
        self.tableRow.styleHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker * (^)(NSString * (^)(id)))reuseIdHandler {
    return ^id(id obj) {
        self.tableRow.reuseIdHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker * (^)(CGFloat (^)(id)))heightHandler {
    return ^id(id obj) {
        self.tableRow.heightHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker * (^)(CGFloat (^)(id)))estimatedHeightHandler {
    return ^id(id obj) {
        self.tableRow.estimatedHeightHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker * (^)(BOOL (^)(id)))shouldHighlightHandler {
    return ^id(id obj) {
        self.tableRow.shouldHighlightHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker * (^)(BOOL (^)(id)))canEditHandler {
    return ^id(id obj) {
        self.tableRow.canEditHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker * (^)(BOOL (^)(id)))canMoveHandler {
    return ^id(id obj) {
        self.tableRow.canMoveHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker * (^)(NSArray *(^)(id)))leadingSwipeActionsHandler {
    return ^id(id obj) {
        if (@available(iOS 11.0, *)) {
            self.tableRow.leadingSwipeActionsHandler = obj;
        }
        return self;
    };
}

- (HoloTableRowMaker * (^)(NSArray *(^)(id)))trailingSwipeActionsHandler {
    return ^id(id obj) {
        self.tableRow.trailingSwipeActionsHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker * (^)(NSString * (^)(id)))editingDeleteTitleHandler {
    return ^id(id obj) {
        self.tableRow.editingDeleteTitleHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker * (^)(UITableViewCellEditingStyle (^)(id)))editingStyleHandler {
    return ^id(id obj) {
        self.tableRow.editingStyleHandler = obj;
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

- (HoloTableRowMaker *(^)(void (^)(id)))willBeginEditingHandler {
    return ^id(id obj) {
        self.tableRow.willBeginEditingHandler = obj;
        return self;
    };
}

- (HoloTableRowMaker *(^)(void (^)(id)))didEndEditingHandler {
    return ^id(id obj) {
        self.tableRow.didEndEditingHandler = obj;
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

#pragma mark - priority high
- (HoloTableRowMaker *(^)(SEL))configSEL {
    return ^id(SEL s) {
        self.tableRow.configSEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))heightSEL {
    return ^id(SEL s) {
        self.tableRow.heightSEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))estimatedHeightSEL {
    return ^id(SEL s) {
        self.tableRow.estimatedHeightSEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))shouldHighlightSEL {
    return ^id(SEL s) {
        self.tableRow.shouldHighlightSEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))canEditSEL {
    return ^id(SEL s) {
        self.tableRow.canEditSEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))canMoveSEL {
    return ^id(SEL s) {
        self.tableRow.canMoveSEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))leadingSwipeActionsSEL {
    return ^id(SEL s) {
        self.tableRow.leadingSwipeActionsSEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))trailingSwipeActionsSEL {
    return ^id(SEL s) {
        self.tableRow.trailingSwipeActionsSEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))editingDeleteTitleSEL {
    return ^id(SEL s) {
        self.tableRow.editingDeleteTitleSEL = s;
        return self;
    };
}

- (HoloTableRowMaker * (^)(SEL))editingStyleSEL {
    return ^id(SEL s) {
        self.tableRow.editingStyleSEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))willSelectSEL {
    return ^id(SEL s) {
        self.tableRow.willSelectSEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))willDeselectSEL {
    return ^id(SEL s) {
        self.tableRow.willDeselectSEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))didDeselectSEL {
    return ^id(SEL s) {
        self.tableRow.didDeselectSEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))didSelectSEL {
    return ^id(SEL s) {
        self.tableRow.didSelectSEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))willDisplaySEL {
    return ^id(SEL s) {
        self.tableRow.willDisplaySEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))didEndDisplayingSEL {
    return ^id(SEL s) {
        self.tableRow.didEndDisplayingSEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))didHighlightSEL {
    return ^id(SEL s) {
        self.tableRow.didHighlightSEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))didUnHighlightSEL {
    return ^id(SEL s) {
        self.tableRow.didUnHighlightSEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))accessorySEL {
    return ^id(SEL s) {
        self.tableRow.accessorySEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))willBeginEditingSEL {
    return ^id(SEL s) {
        self.tableRow.willBeginEditingSEL = s;
        return self;
    };
}

- (HoloTableRowMaker *(^)(SEL))didEndEditingSEL {
    return ^id(SEL s) {
        self.tableRow.didEndEditingSEL = s;
        return self;
    };
}


- (HoloTableRow *)fetchTableRow {
    return self.tableRow;
}

- (void)giveTableRow:(HoloTableRow *)tableRow {
    self.tableRow = tableRow;
}

#pragma mark - getter
- (HoloTableRow *)tableRow {
    if (!_tableRow) {
        _tableRow = [HoloTableRow new];
    }
    return _tableRow;
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
        // reuseId is equal to cell by default
        rowMaker.tableRow.reuseId = rowMaker.tableRow.cell;
        
        [self.holoRows addObject:rowMaker.tableRow];
        return rowMaker;
    };
}

- (HoloTableRowMaker *(^)(NSString *))rowS {
    return ^id(id obj) {
        HoloTableRowMaker *rowMaker = [HoloTableRowMaker new];
        rowMaker.tableRow.cell = obj;
        // reuseId is equal to cell by default
        rowMaker.tableRow.reuseId = rowMaker.tableRow.cell;
        
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
