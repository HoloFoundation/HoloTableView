//
//  HoloTableViewRowMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

////////////////////////////////////////////////////////////
@interface HoloTableRow : NSObject

@property (nonatomic, copy) NSString *cell;

#pragma mark - priority low
@property (nonatomic, strong) id model;

@property (nonatomic, assign) UITableViewCellStyle style;

@property (nonatomic, copy) NSString *reuseId;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat estimatedHeight;

@property (nonatomic, assign) BOOL shouldHighlight;

@property (nonatomic, assign) BOOL canEdit;

@property (nonatomic, assign) BOOL canMove;

@property (nonatomic, copy) NSArray *leadingSwipeActions API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

@property (nonatomic, copy) NSArray *trailingSwipeActions;

@property (nonatomic, copy) NSString *editingDeleteTitle;

@property (nonatomic, assign) UITableViewCellEditingStyle editingStyle;

// support set a delegate for cell
@property (nonatomic, assign) SEL delegateSEL;

@property (nonatomic, weak) id delegate;

#pragma mark - priority middle
@property (nonatomic, copy) id (^modelHandler)(void);

@property (nonatomic, copy) UITableViewCellStyle (^styleHandler)(id _Nullable model);

@property (nonatomic, copy) NSString *(^reuseIdHandler)(id _Nullable model);

@property (nonatomic, copy) NSString *(^tagHandler)(id _Nullable model);

@property (nonatomic, copy) CGFloat (^heightHandler)(id _Nullable model);

@property (nonatomic, copy) CGFloat (^estimatedHeightHandler)(id _Nullable model);

@property (nonatomic, copy) BOOL (^shouldHighlightHandler)(id _Nullable model);

@property (nonatomic, copy) BOOL (^canEditHandler)(id _Nullable model);

@property (nonatomic, copy) BOOL (^canMoveHandler)(id _Nullable model);

@property (nonatomic, copy) NSArray *(^leadingSwipeActionsHandler)(id _Nullable model) API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

@property (nonatomic, copy) NSArray *(^trailingSwipeActionsHandler)(id _Nullable model);

@property (nonatomic, copy) NSArray *(^editingDeleteTitleHandler)(id _Nullable model);

@property (nonatomic, copy) void (^willSelectHandler)(id _Nullable model);

@property (nonatomic, copy) void (^willDeselectHandler)(id _Nullable model);

@property (nonatomic, copy) void (^didDeselectHandler)(id _Nullable model);

@property (nonatomic, copy) void (^didSelectHandler)(id _Nullable model);

@property (nonatomic, copy) void (^willDisplayHandler)(UITableViewCell *cell, id _Nullable model);

@property (nonatomic, copy) void (^didEndDisplayingHandler)(UITableViewCell *cell, id _Nullable model);

@property (nonatomic, copy) void (^didHighlightHandler)(id _Nullable model);

@property (nonatomic, copy) void (^didUnHighlightHandler)(id _Nullable model);

@property (nonatomic, copy) void (^accessoryHandler)(id _Nullable model);

@property (nonatomic, copy) void (^leadingSwipeHandler)(id action, NSInteger index, void(^completionHandler)(BOOL actionPerformed)) API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

@property (nonatomic, copy) void (^trailingSwipeHandler)(id action, NSInteger index, void(^completionHandler)(BOOL actionPerformed));

@property (nonatomic, copy) void (^willBeginEditingHandler)(id _Nullable model);

@property (nonatomic, copy) void (^didEndEditingHandler)(id _Nullable model);

@property (nonatomic, copy) NSIndexPath *(^targetMoveHandler)(NSIndexPath *atIndexPath, NSIndexPath *toIndexPath);

@property (nonatomic, copy) void (^moveHandler)(NSIndexPath *atIndexPath, NSIndexPath *toIndexPath, void(^completionHandler)(BOOL actionPerformed));

@property (nonatomic, copy) void (^editingDeleteHandler)(id _Nullable model, void(^completionHandler)(BOOL actionPerformed));

@property (nonatomic, copy) void (^editingInsertHandler)(id _Nullable model);

#pragma mark - priority high
@property (nonatomic, assign) SEL configSEL;

@property (nonatomic, assign) SEL styleSEL;

@property (nonatomic, assign) SEL reuseIdSEL;

@property (nonatomic, assign) SEL tagSEL;

@property (nonatomic, assign) SEL heightSEL;

@property (nonatomic, assign) SEL estimatedHeightSEL;

@property (nonatomic, assign) SEL shouldHighlightSEL;

@property (nonatomic, assign) SEL canEditSEL;

@property (nonatomic, assign) SEL canMoveSEL;

@property (nonatomic, assign) SEL leadingSwipeActionsSEL;

@property (nonatomic, assign) SEL trailingSwipeActionsSEL;

@property (nonatomic, assign) SEL editingDeleteTitleSEL;


@property (nonatomic, assign) SEL willSelectSEL;

@property (nonatomic, assign) SEL willDeselectSEL;

@property (nonatomic, assign) SEL didDeselectSEL;

@property (nonatomic, assign) SEL didSelectSEL;

@property (nonatomic, assign) SEL willDisplaySEL;

@property (nonatomic, assign) SEL didEndDisplayingSEL;

@property (nonatomic, assign) SEL didHighlightSEL;

@property (nonatomic, assign) SEL didUnHighlightSEL;

@property (nonatomic, assign) SEL accessorySEL;

@property (nonatomic, assign) SEL leadingSwipeSEL API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

@property (nonatomic, assign) SEL trailingSwipeSEL;

@property (nonatomic, assign) SEL willBeginEditingSEL;

@property (nonatomic, assign) SEL didEndEditingSEL;

@property (nonatomic, assign) SEL targetMoveSEL;

@property (nonatomic, assign) SEL moveSEL;

@property (nonatomic, assign) SEL editingDeleteSEL;

@property (nonatomic, assign) SEL editingInsertSEL;

@end

////////////////////////////////////////////////////////////
@interface HoloTableRowMaker : NSObject

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^row)(Class row);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^rowS)(NSString *rowString);

#pragma mark - priority low
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^model)(id model);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^style)(UITableViewCellStyle style);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^reuseId)(NSString *reuseId);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^tag)(NSString *tag);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^height)(CGFloat height);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^estimatedHeight)(CGFloat estimatedHeight);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^shouldHighlight)(BOOL shouldHighlight);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^canEdit)(BOOL canEdit);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^canMove)(BOOL canMove);
/// HoloTableViewRowSwipeAction or NSDictionary
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^leadingSwipeActions)(NSArray *leadingSwipeActions) API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^trailingSwipeActions)(NSArray *trailingSwipeActions);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^editingDeleteTitle)(NSString *title);

#pragma mark - priority middle
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^modelHandler)(id (^)(void));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^styleHandler)(UITableViewCellStyle (^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^reuseIdHandler)(NSString *(^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^tagHandler)(NSString *(^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^heightHandler)(CGFloat (^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^estimatedHeightHandler)(CGFloat (^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^shouldHighlightHandler)(BOOL (^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^canEditHandler)(BOOL (^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^canMoveHandler)(BOOL (^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^leadingSwipeActionsHandler)(NSArray *(^)(id _Nullable model)) API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^trailingSwipeActionsHandler)(NSArray *(^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^editingDeleteTitleHandler)(BOOL (^)(id _Nullable model));


@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willSelectHandler)(void(^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willDeselectHandler)(void(^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didDeselectHandler)(void(^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didSelectHandler)(void(^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willDisplayHandler)(void(^)(UITableViewCell *cell, id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didEndDisplayingHandler)(void(^)(UITableViewCell *cell, id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didHighlightHandler)(void(^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didUnHighlightHandler)(void(^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^accessoryHandler)(void(^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^leadingSwipeHandler)(void(^)(id action, NSInteger index, void(^completionHandler)(BOOL actionPerformed))) API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^trailingSwipeHandler)(void(^)(id action, NSInteger index, void(^completionHandler)(BOOL actionPerformed)));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willBeginEditingHandler)(void(^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didEndEditingHandler)(void(^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^targetMoveHandler)(NSIndexPath *(^targetIndexPath)(NSIndexPath *atIndexPath, NSIndexPath *toIndexPath));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^moveHandler)(void(^)(NSIndexPath *atIndexPath, NSIndexPath *toIndexPath, void(^completionHandler)(BOOL actionPerformed)));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^editingDeleteHandler)(void(^)(id _Nullable model, void(^completionHandler)(BOOL actionPerformed)));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^editingInsertHandler)(void(^)(id _Nullable model));

#pragma mark - priority high
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^configSEL)(SEL configSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^styleSEL)(SEL styleSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^reuseIdSEL)(SEL reuseIdSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^tagSEL)(SEL tagSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^heightSEL)(SEL heightSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^estimatedHeightSEL)(SEL estimatedHeightSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^shouldHighlightSEL)(SEL shouldHighlightSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^canEditSEL)(SEL canEditSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^canMoveSEL)(SEL canMoveSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^leadingSwipeActionsSEL)(SEL leadingSwipeActionsSEL) API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^trailingSwipeActionsSEL)(SEL trailingSwipeActionsSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^editingDeleteTitleSEL)(SEL editingDeleteTitleSEL);


@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willSelectSEL)(SEL willSelectSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willDeselectSEL)(SEL willDeselectSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didDeselectSEL)(SEL didDeselectSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didSelectSEL)(SEL didSelectSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willDisplaySEL)(SEL willDisplaySEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didEndDisplayingSEL)(SEL didEndDisplayingSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didHighlightSEL)(SEL didHighlightSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didUnHighlightSEL)(SEL didUnHighlightSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^accessorySEL)(SEL accessorySEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^leadingSwipeSEL)(SEL leadingSwipeSEL) API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^trailingSwipeSEL)(SEL trailingSwipeSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willBeginEditingSEL)(SEL willBeginEditingSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didEndEditingSEL)(SEL didEndEditingSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^targetMoveSEL)(SEL targetMoveSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^moveSEL)(SEL moveSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^editingDeleteSEL)(SEL editingDeleteSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^editingInsertSEL)(SEL editingInsertSEL);


- (HoloTableRow *)fetchTableRow;

- (void)giveTableRow:(HoloTableRow *)tableRow;

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewRowMaker : NSObject

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^row)(Class row);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^rowS)(NSString *rowString);

- (NSArray<HoloTableRow *> *)install;

@end

NS_ASSUME_NONNULL_END
