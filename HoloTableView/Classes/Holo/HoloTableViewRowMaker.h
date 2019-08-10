//
//  HoloTableViewRowMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import <Foundation/Foundation.h>
@class HoloTableViewRowSwipeAction;

NS_ASSUME_NONNULL_BEGIN

////////////////////////////////////////////////////////////
@interface HoloRow : NSObject

@property (nonatomic, copy) NSString *cell;

@property (nonatomic, strong) id model;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat estimatedHeight;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, assign) SEL configSEL;

@property (nonatomic, assign) SEL heightSEL;

@property (nonatomic, assign) SEL estimatedHeightSEL;

@property (nonatomic, assign) BOOL shouldHighlight;

@property (nonatomic, copy) void (^willSelectHandler)(id model);

@property (nonatomic, copy) void (^willDeselectHandler)(id model);

@property (nonatomic, copy) void (^didDeselectHandler)(id model);

@property (nonatomic, copy) void (^didSelectHandler)(id model);

@property (nonatomic, copy) void (^willDisplayHandler)(UITableViewCell *cell, id model);

@property (nonatomic, copy) void (^didEndDisplayingHandler)(UITableViewCell *cell, id model);

@property (nonatomic, copy) void (^didHighlightHandler)(id model);

@property (nonatomic, copy) void (^didUnHighlightHandler)(id model);

@property (nonatomic, copy) void (^accessoryHandler)(id model);

/// Editing
@property (nonatomic, assign) BOOL canEdit;

/// Editing: swipe
@property (nonatomic, copy) NSArray *leadingSwipeActions API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

@property (nonatomic, copy) NSArray *trailingSwipeActions;

@property (nonatomic, copy) void (^leadingSwipeHandler)(id action, NSInteger index, void(^completionHandler)(BOOL actionPerformed)) API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

@property (nonatomic, copy) void (^trailingSwipeHandler)(id action, NSInteger index, void(^completionHandler)(BOOL actionPerformed));

@property (nonatomic, copy) void (^willBeginSwipingHandler)(id model);

@property (nonatomic, copy) void (^didEndSwipingHandler)(id model);

/// Editing: move
@property (nonatomic, assign) BOOL canMove;

@property (nonatomic, copy) NSIndexPath *(^targetMoveHandler)(NSIndexPath *atIndexPath, NSIndexPath *toIndexPath);

@property (nonatomic, copy) void (^moveHandler)(NSIndexPath *atIndexPath, NSIndexPath *toIndexPath);

/// Editing: delete
@property (nonatomic, copy) NSString *editingDeleteTitle;

@property (nonatomic, copy) void (^editingDeleteHandler)(id model);

/// Editing: insert
@property (nonatomic, copy) void (^editingInsertHandler)(id model);

@property (nonatomic, assign) UITableViewCellEditingStyle editingStyle;

@end

////////////////////////////////////////////////////////////
@interface HoloRowMaker : NSObject

@property (nonatomic, strong, readonly) HoloRow *row;

@property (nonatomic, copy, readonly) HoloRowMaker *(^model)(id model);

@property (nonatomic, copy, readonly) HoloRowMaker *(^height)(CGFloat height);

@property (nonatomic, copy, readonly) HoloRowMaker *(^estimatedHeight)(CGFloat estimatedHeight);

@property (nonatomic, copy, readonly) HoloRowMaker *(^tag)(NSString *tag);

@property (nonatomic, copy, readonly) HoloRowMaker *(^configSEL)(SEL configSEL);

@property (nonatomic, copy, readonly) HoloRowMaker *(^heightSEL)(SEL heightSEL);

@property (nonatomic, copy, readonly) HoloRowMaker *(^estimatedHeightSEL)(SEL estimatedHeightSEL);

@property (nonatomic, copy, readonly) HoloRowMaker *(^shouldHighlight)(BOOL shouldHighlight);

@property (nonatomic, copy, readonly) HoloRowMaker *(^willSelectHandler)(void(^)(id model));

@property (nonatomic, copy, readonly) HoloRowMaker *(^willDeselectHandler)(void(^)(id model));

@property (nonatomic, copy, readonly) HoloRowMaker *(^didDeselectHandler)(void(^)(id model));

@property (nonatomic, copy, readonly) HoloRowMaker *(^didSelectHandler)(void(^)(id model));

@property (nonatomic, copy, readonly) HoloRowMaker *(^willDisplayHandler)(void(^)(UITableViewCell *cell, id model));

@property (nonatomic, copy, readonly) HoloRowMaker *(^didEndDisplayingHandler)(void(^)(UITableViewCell *cell, id model));

@property (nonatomic, copy, readonly) HoloRowMaker *(^didHighlightHandler)(void(^)(id model));

@property (nonatomic, copy, readonly) HoloRowMaker *(^didUnHighlightHandler)(void(^)(id model));

@property (nonatomic, copy, readonly) HoloRowMaker *(^accessoryHandler)(void(^)(id model));

/// Editing
@property (nonatomic, copy, readonly) HoloRowMaker *(^canEdit)(BOOL canEdit);

/// Editing: swipe
/// HoloTableViewRowSwipeAction or NSDictionary
@property (nonatomic, copy, readonly) HoloRowMaker *(^leadingSwipeActions)(NSArray *leadingSwipeActions) API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

@property (nonatomic, copy, readonly) HoloRowMaker *(^trailingSwipeActions)(NSArray *trailingSwipeActions);

@property (nonatomic, copy, readonly) HoloRowMaker *(^leadingSwipeHandler)(void(^)(id action, NSInteger index, void(^completionHandler)(BOOL actionPerformed))) API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

@property (nonatomic, copy, readonly) HoloRowMaker *(^trailingSwipeHandler)(void(^)(id action, NSInteger index, void(^completionHandler)(BOOL actionPerformed)));

@property (nonatomic, copy, readonly) HoloRowMaker *(^willBeginSwipingHandler)(void(^)(id model));

@property (nonatomic, copy, readonly) HoloRowMaker *(^didEndSwipingHandler)(void(^)(id model));

/// Editing: move
@property (nonatomic, copy, readonly) HoloRowMaker *(^canMove)(BOOL canMove);

@property (nonatomic, copy, readonly) HoloRowMaker *(^targetMoveHandler)(NSIndexPath *(^targetIndexPath)(NSIndexPath *atIndexPath, NSIndexPath *toIndexPath));

@property (nonatomic, copy, readonly) HoloRowMaker *(^moveHandler)(void(^)(NSIndexPath *atIndexPath, NSIndexPath *toIndexPath));

/// Editing: delete
@property (nonatomic, copy, readonly) HoloRowMaker *(^editingDeleteTitle)(NSString *title);

@property (nonatomic, copy, readonly) HoloRowMaker *(^editingDeleteHandler)(void(^)(id model));

/// Editing: insert
@property (nonatomic, copy, readonly) HoloRowMaker *(^editingInsertHandler)(void(^)(id model));

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewRowMaker : NSObject

@property (nonatomic, copy, readonly) HoloRowMaker *(^row)(NSString *rowName);

- (NSArray<HoloRow *> *)install;

@end

NS_ASSUME_NONNULL_END
