//
//  HoloTableRowMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2020/6/1.
//

#import "HoloTableRowMaker.h"
#import "HoloTableRow.h"

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

- (HoloTableRowMaker * (^)(UITableViewCellEditingStyle))editingStyle {
    return ^id(UITableViewCellEditingStyle editingStyle) {
        self.tableRow.editingStyle = editingStyle;
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

- (HoloTableRowMaker * (^)(void (^)(UITableViewCell *, id)))cellForRowHandler {
    return ^id(id obj) {
        self.tableRow.cellForRowHandler = obj;
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

- (HoloTableRowMaker *(^)(void (^)(id)))accessoryButtonTappedHandler {
    return ^id(id obj) {
        self.tableRow.accessoryButtonTappedHandler = obj;
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

- (HoloTableRowMaker *(^)(SEL))accessoryButtonTappedSEL {
    return ^id(SEL s) {
        self.tableRow.accessoryButtonTappedSEL = s;
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

