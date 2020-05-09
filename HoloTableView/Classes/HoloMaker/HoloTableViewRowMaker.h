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

@property (nonatomic, strong) id model;

@property (nonatomic, assign) UITableViewCellStyle style;

@property (nonatomic, copy) NSString *reuseId;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, assign) SEL configSEL;

/// priority low
@property (nonatomic, assign) CGFloat height;
/// priority middle (if row has the block)
@property (nonatomic, copy) CGFloat (^heightHandler)(id _Nullable model);
/// priority high (if cell implement the selector)
@property (nonatomic, assign) SEL heightSEL;

/// priority low
@property (nonatomic, assign) CGFloat estimatedHeight;
/// priority middle (if row has the block)
@property (nonatomic, copy) CGFloat (^estimatedHeightHandler)(id _Nullable model);
/// priority high (if cell implement the selector)
@property (nonatomic, assign) SEL estimatedHeightSEL;

/// priority low
@property (nonatomic, assign) BOOL shouldHighlight;
/// priority high (if row has the block)
@property (nonatomic, copy) BOOL (^shouldHighlightHandler)(id _Nullable model);

/// priority low
@property (nonatomic, assign) BOOL canEdit;
/// priority high (if row has the block)
@property (nonatomic, copy) BOOL (^canEditHandler)(id _Nullable model);

/// priority low
@property (nonatomic, assign) BOOL canMove;
/// priority high (if row has the block)
@property (nonatomic, copy) BOOL (^canMoveHandler)(id _Nullable model);

/// priority low
@property (nonatomic, copy) NSArray *leadingSwipeActions API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);
/// priority high (if row has the block)
@property (nonatomic, copy) NSArray *(^leadingSwipeActionsHandler)(id _Nullable model) API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

/// priority low
@property (nonatomic, copy) NSArray *trailingSwipeActions;
/// priority high (if row has the block)
@property (nonatomic, copy) NSArray *(^trailingSwipeActionsHandler)(id _Nullable model);

/// priority low
@property (nonatomic, copy) NSString *editingDeleteTitle;
/// priority high (if row has the block)
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

@property (nonatomic, assign) UITableViewCellEditingStyle editingStyle;

// support set a delegate for cell
@property (nonatomic, assign) SEL delegateSEL;

@property (nonatomic, weak) id delegate;

@end

////////////////////////////////////////////////////////////
@interface HoloTableRowMaker : NSObject

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^row)(Class row);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^rowS)(NSString *rowString);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^model)(id model);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^style)(UITableViewCellStyle style);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^reuseId)(NSString *reuseId);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^tag)(NSString *tag);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^configSEL)(SEL configSEL);

/// priority low
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^height)(CGFloat height);
/// priority middle (if row has the block)
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^heightHandler)(CGFloat (^)(id _Nullable model));
/// priority high (if cell implement the selector)
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^heightSEL)(SEL heightSEL);

/// priority low
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^estimatedHeight)(CGFloat estimatedHeight);
/// priority middle (if row has the block)
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^estimatedHeightHandler)(CGFloat (^)(id _Nullable model));
/// priority high (if cell implement the selector)
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^estimatedHeightSEL)(SEL estimatedHeightSEL);

/// priority low
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^shouldHighlight)(BOOL shouldHighlight);
/// priority high (if row has the block)
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^shouldHighlightHandler)(BOOL (^)(id _Nullable model));

/// priority low
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^canEdit)(BOOL canEdit);
/// priority high (if row has the block)
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^canEditHandler)(BOOL (^)(id _Nullable model));

/// priority low
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^canMove)(BOOL canMove);
/// priority high (if row has the block)
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^canMoveHandler)(BOOL (^)(id _Nullable model));

/// HoloTableViewRowSwipeAction or NSDictionary
/// priority low
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^leadingSwipeActions)(NSArray *leadingSwipeActions) API_AVAILABLE(ios(10)) API_UNAVAILABLE(tvos);
/// priority high (if row has the block)
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^leadingSwipeActionsHandler)(NSArray *(^)(id _Nullable model)) API_AVAILABLE(ios(10)) API_UNAVAILABLE(tvos);

/// priority low
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^trailingSwipeActions)(NSArray *trailingSwipeActions);
/// priority high (if row has the block)
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^trailingSwipeActionsHandler)(NSArray *(^)(id _Nullable model));

/// priority low
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^editingDeleteTitle)(NSString *title);
/// priority high (if row has the block)
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
