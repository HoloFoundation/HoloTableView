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

@property (nonatomic, assign) UITableViewCellStyle style;

@property (nonatomic, copy) NSString *reuseId;

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

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^height)(CGFloat height);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^estimatedHeight)(CGFloat estimatedHeight);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^style)(UITableViewCellStyle style);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^reuseId)(NSString *reuseId);

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

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewRowMaker : NSObject

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^row)(Class row);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^rowS)(NSString *rowString);

- (NSArray<HoloTableRow *> *)install;

@end

NS_ASSUME_NONNULL_END
