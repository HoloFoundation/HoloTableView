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
@interface HoloTableRow : NSObject

@property (nonatomic, copy) NSString *cell;

@property (nonatomic, strong) id model;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat estimatedHeight;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, assign) SEL configSEL;

@property (nonatomic, assign) SEL heightSEL;

@property (nonatomic, assign) SEL estimatedHeightSEL;

@property (nonatomic, assign) BOOL shouldHighlight;

@property (nonatomic, assign) BOOL canEdit;

@property (nonatomic, assign) BOOL canMove;

@property (nonatomic, copy) NSArray *leadingSwipeActions API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

@property (nonatomic, copy) NSArray *trailingSwipeActions;

@property (nonatomic, copy) NSString *editingDeleteTitle;

@property (nonatomic, copy) void (^willSelectHandler)(id model);

@property (nonatomic, copy) void (^willDeselectHandler)(id model);

@property (nonatomic, copy) void (^didDeselectHandler)(id model);

@property (nonatomic, copy) void (^didSelectHandler)(id model);

@property (nonatomic, copy) void (^willDisplayHandler)(UITableViewCell *cell, id model);

@property (nonatomic, copy) void (^didEndDisplayingHandler)(UITableViewCell *cell, id model);

@property (nonatomic, copy) void (^didHighlightHandler)(id model);

@property (nonatomic, copy) void (^didUnHighlightHandler)(id model);

@property (nonatomic, copy) void (^accessoryHandler)(id model);

@property (nonatomic, copy) void (^leadingSwipeHandler)(id action, NSInteger index, void(^completionHandler)(BOOL actionPerformed)) API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

@property (nonatomic, copy) void (^trailingSwipeHandler)(id action, NSInteger index, void(^completionHandler)(BOOL actionPerformed));

@property (nonatomic, copy) void (^willBeginSwipingHandler)(id model);

@property (nonatomic, copy) void (^didEndSwipingHandler)(id model);

@property (nonatomic, copy) NSIndexPath *(^targetMoveHandler)(NSIndexPath *atIndexPath, NSIndexPath *toIndexPath);

@property (nonatomic, copy) void (^moveHandler)(NSIndexPath *atIndexPath, NSIndexPath *toIndexPath, void(^completionHandler)(BOOL actionPerformed));

@property (nonatomic, copy) void (^editingDeleteHandler)(id model, void(^completionHandler)(BOOL actionPerformed));

@property (nonatomic, copy) void (^editingInsertHandler)(id model);

@property (nonatomic, assign) UITableViewCellEditingStyle editingStyle;

@end

////////////////////////////////////////////////////////////
@interface HoloTableRowMaker : NSObject

@property (nonatomic, strong, readonly) HoloTableRow *tableRow;

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^row)(NSString *rowName);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^rowCls)(Class rowCls);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^model)(id model);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^height)(CGFloat height);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^estimatedHeight)(CGFloat estimatedHeight);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^tag)(NSString *tag);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^configSEL)(SEL configSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^heightSEL)(SEL heightSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^estimatedHeightSEL)(SEL estimatedHeightSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^shouldHighlight)(BOOL shouldHighlight);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^canEdit)(BOOL canEdit);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^canMove)(BOOL canMove);

/// HoloTableViewRowSwipeAction or NSDictionary
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^leadingSwipeActions)(NSArray *leadingSwipeActions) API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^trailingSwipeActions)(NSArray *trailingSwipeActions);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^editingDeleteTitle)(NSString *title);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willSelectHandler)(void(^)(id model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willDeselectHandler)(void(^)(id model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didDeselectHandler)(void(^)(id model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didSelectHandler)(void(^)(id model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willDisplayHandler)(void(^)(UITableViewCell *cell, id model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didEndDisplayingHandler)(void(^)(UITableViewCell *cell, id model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didHighlightHandler)(void(^)(id model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didUnHighlightHandler)(void(^)(id model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^accessoryHandler)(void(^)(id model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^leadingSwipeHandler)(void(^)(id action, NSInteger index, void(^completionHandler)(BOOL actionPerformed))) API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^trailingSwipeHandler)(void(^)(id action, NSInteger index, void(^completionHandler)(BOOL actionPerformed)));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willBeginSwipingHandler)(void(^)(id model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didEndSwipingHandler)(void(^)(id model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^targetMoveHandler)(NSIndexPath *(^targetIndexPath)(NSIndexPath *atIndexPath, NSIndexPath *toIndexPath));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^moveHandler)(void(^)(NSIndexPath *atIndexPath, NSIndexPath *toIndexPath, void(^completionHandler)(BOOL actionPerformed)));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^editingDeleteHandler)(void(^)(id model, void(^completionHandler)(BOOL actionPerformed)));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^editingInsertHandler)(void(^)(id model));

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewRowMaker : NSObject

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^row)(NSString *rowName);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^rowCls)(Class rowCls);

- (NSArray<HoloTableRow *> *)install;

@end

NS_ASSUME_NONNULL_END
