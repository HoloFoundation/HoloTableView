//
//  HoloTableRowMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2020/6/1.
//

#import <Foundation/Foundation.h>
@class HoloTableRow, HoloTableViewRowSwipeAction;

NS_ASSUME_NONNULL_BEGIN

@interface HoloTableRowMaker : NSObject

/**
 *  Make a cell with class.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^row)(Class row);

/**
 *  Set the data for current row using the `model` property.
 *
 *  If the `modelHandler` property is nil, then use the `model` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^model)(id model);
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^modelHandler)(id (^)(void));

/**
 * current row must implement the `configSEL` property setting method in order for the HoloTableView to pass the model for current row.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^configSEL)(SEL configSEL);

/**
 *  Performed before `configSEL`.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^beforeConfigureHandler)(void(^)(UITableViewCell *cell, id _Nullable model));

/**
 *  Performed after `configSEL`.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^afterConfigureHandler)(void(^)(UITableViewCell *cell, id _Nullable model));

/**
 *  Set the style for current row using the `style` property.
 *
 *  If the `styleHandler` property is nil, then use the `style` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^style)(UITableViewCellStyle style);
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^styleHandler)(UITableViewCellStyle (^)(id _Nullable model));

/**
 *  Set the reuse identifier for current row using the `reuseId` property.
 *
 *  If the `reuseIdHandler` property is nil, then use the `reuseId` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^reuseId)(NSString *reuseId);
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^reuseIdHandler)(NSString *(^)(id _Nullable model));

/**
 *  Set the tag for current row using the `tag` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^tag)(NSString *tag);

/**
 *  Set the height for current row using the `height` property.
 *
 *  If the `heightSEL` property is nil or current row don't implement the `heightSEL` property setting method, then use the `heightHandler` property.
 *  If the `heightHandler` property is nil, then use the `height` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^height)(CGFloat height);
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^heightHandler)(CGFloat (^)(id _Nullable model));
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^heightSEL)(SEL heightSEL);

/**
 *  Set the estimated height for current row using the `estimatedHeight` property.
 *
 *  If the `estimatedHeightSEL` property is nil or current row don't implement the `estimatedHeightSEL` property setting method, then use the `estimatedHeightHandler` property.
 *  If the `estimatedHeightHandler` property is nil, then use the `estimatedHeight` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^estimatedHeight)(CGFloat estimatedHeight);
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^estimatedHeightHandler)(CGFloat (^)(id _Nullable model));
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^estimatedHeightSEL)(SEL estimatedHeightSEL);

/**
 *  Set the should highlight or not for current row using the `estimatedHeight` property.
 *
 *  If the `shouldHighlightSEL` property is nil or current row don't implement the `shouldHighlightSEL` property setting method, then use the `shouldHighlightHandler` property.
 *  If the `shouldHighlightHandler` property is nil, then use the `shouldHighlight` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^shouldHighlight)(BOOL shouldHighlight);
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^shouldHighlightHandler)(BOOL (^)(id _Nullable model));
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^shouldHighlightSEL)(SEL shouldHighlightSEL);

/**
 *  Set the can edit or not for current row using the `canEdit` property.
 *
 *  If the `canEditHandler` property is nil, then use the `canEdit` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^canEdit)(BOOL canEdit);
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^canEditHandler)(BOOL (^)(id _Nullable model));

/**
 *  Set the can move or not for current row using the `canMove` property.
 *
 *  If the `canMoveHandler` property is nil, then use the `canEdit` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^canMove)(BOOL canMove);
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^canMoveHandler)(BOOL (^)(id _Nullable model));

/**
 *  Set the leading swipe actions for current row using the `leadingSwipeActions` property.
 *
 *  If the `leadingSwipeActionsHandler` property is nil, then use the `leadingSwipeActions` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^leadingSwipeActions)(NSArray<HoloTableViewRowSwipeAction *> *leadingSwipeActions) API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^leadingSwipeActionsHandler)(NSArray<HoloTableViewRowSwipeAction *> *(^)(id _Nullable model)) API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

/**
 *  Set the leading swipe for current row using the `leadingSwipeHandler` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^leadingSwipeHandler)(void(^)(id action, NSInteger index, void(^completionHandler)(BOOL actionPerformed))) API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

/**
 *  Set the trailing swipe actions for current row using the `trailingSwipeActions` property.
 *
 *  If the `trailingSwipeActionsHandler` property is nil, then use the `trailingSwipeActions` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^trailingSwipeActions)(NSArray<HoloTableViewRowSwipeAction *> *trailingSwipeActions);
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^trailingSwipeActionsHandler)(NSArray<HoloTableViewRowSwipeAction *> *(^)(id _Nullable model));

/**
 *  Set the trailing swipe for current row using the `trailingSwipeHandler` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^trailingSwipeHandler)(void(^)(id action, NSInteger index, void(^completionHandler)(BOOL actionPerformed)));

/**
 *  Set the editing delete title for current row using the `editingDeleteTitle` property.
 *
 *  If the `editingDeleteTitleHandler` property is nil, then use the `editingDeleteTitle` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^editingDeleteTitle)(NSString *title);
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^editingDeleteTitleHandler)(NSString *(^)(id _Nullable model));

/**
 *  Set the editing style for current row using the `editingStyle` property.
 *
 *  If the `editingStyleHandler` property is nil, then use the `editingStyle` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^editingStyle)(UITableViewCellEditingStyle editingStyle);
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^editingStyleHandler)(UITableViewCellEditingStyle(^)(id _Nullable model));

/**
 *  If current row will select, the `willSelectHandler` will be called.
 *
 *  If the `willSelectSEL` property is nil or current row don't implement the `willSelectSEL` property setting method, then use the `willSelectHandler` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willSelectHandler)(void(^)(id _Nullable model));
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willSelectSEL)(SEL willSelectSEL);

/**
 *  If current row will deselect, the `willDeselectHandler` will be called.
 *
 *  If the `willDeselectSEL` property is nil or current row don't implement the `willDeselectSEL` property setting method, then use the `willDeselectHandler` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willDeselectHandler)(void(^)(id _Nullable model));
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willDeselectSEL)(SEL willDeselectSEL);

/**
 *  If current row did deselect, the `didDeselectHandler` will be called.
 *
 *  If the `didDeselectSEL` property is nil or current row don't implement the `didDeselectSEL` property setting method, then use the `didDeselectHandler` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didDeselectHandler)(void(^)(id _Nullable model));
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didDeselectSEL)(SEL didDeselectSEL);

/**
 *  If current row did select, the `didSelectHandler` will be called.
 *
 *  If the `didSelectSEL` property is nil or current row don't implement the `didSelectSEL` property setting method, then use the `didSelectHandler` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didSelectHandler)(void(^)(id _Nullable model));
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didSelectSEL)(SEL didSelectSEL);

/**
 *  If current row will display, the `willDisplayHandler` will be called.
 *
 *  If the `willDisplaySEL` property is nil or current row don't implement the `willDisplaySEL` property setting method, then use the `willDisplayHandler` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willDisplayHandler)(void(^)(UITableViewCell *cell, id _Nullable model));
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willDisplaySEL)(SEL willDisplaySEL);

/**
 *  If current row did end displaying, the `didEndDisplayingHandler` will be called.
 *
 *  If the `didEndDisplayingSEL` property is nil or current row don't implement the `didEndDisplayingSEL` property setting method, then use the `didEndDisplayingHandler` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didEndDisplayingHandler)(void(^)(UITableViewCell *cell, id _Nullable model));
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didEndDisplayingSEL)(SEL didEndDisplayingSEL);

/**
 *  If current row did highlight, the `didHighlightHandler` will be called.
 *
 *  If the `didHighlightSEL` property is nil or current row don't implement the `didHighlightSEL` property setting method, then use the `didHighlightHandler` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didHighlightHandler)(void(^)(id _Nullable model));
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didHighlightSEL)(SEL didHighlightSEL);

/**
 *  If current row did unhighlight, the `didUnHighlightHandler` will be called.
 *
 *  If the `didUnHighlightSEL` property is nil or current row don't implement the `didUnHighlightSEL` property setting method, then use the `didUnHighlightHandler` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didUnHighlightHandler)(void(^)(id _Nullable model));
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didUnHighlightSEL)(SEL didUnHighlightSEL);

/**
 *  If current row accessory button tapped, the `accessoryButtonTappedHandler` will be called.
 *
 *  If the `accessoryButtonTappedSEL` property is nil or current row don't implement the `accessoryButtonTappedSEL` property setting method, then use the `accessoryButtonTappedHandler` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^accessoryButtonTappedHandler)(void(^)(id _Nullable model));
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^accessoryButtonTappedSEL)(SEL accessoryButtonTappedSEL);

/**
 *  If current row will begin editing, the `willBeginEditingHandler` will be called.
 *
 *  If the `willBeginEditingSEL` property is nil or current row don't implement the `willBeginEditingSEL` property setting method, then use the `willBeginEditingHandler` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willBeginEditingHandler)(void(^)(id _Nullable model));
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willBeginEditingSEL)(SEL willBeginEditingSEL);

/**
 *  If current row did end editing, the `didEndEditingHandler` will be called.
 *
 *  If the `didEndEditingSEL` property is nil or current row don't implement the `didEndEditingSEL` property setting method, then use the `didEndEditingHandler` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didEndEditingHandler)(void(^)(id _Nullable model));
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didEndEditingSEL)(SEL didEndEditingSEL);

/**
 *  Set the target move index for current row using the `targetMoveHandler` property.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^targetMoveHandler)(NSIndexPath *(^targetIndexPath)(NSIndexPath *atIndexPath, NSIndexPath *toIndexPath));

/**
 *  If current row is moved, the `moveHandler` will be called.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^moveHandler)(void(^)(NSIndexPath *atIndexPath, NSIndexPath *toIndexPath, void(^completionHandler)(BOOL actionPerformed)));

/**
 *  If current row is editing delete, the `editingDeleteHandler` will be called.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^editingDeleteHandler)(void(^)(id _Nullable model, void(^completionHandler)(BOOL actionPerformed)));

/**
 *  If current row is editing Insert, the `editingInsertHandler` will be called.
 */
@property (nonatomic, copy, readonly) HoloTableRowMaker *(^editingInsertHandler)(void(^)(id _Nullable model));


- (HoloTableRow *)fetchTableRow;

- (void)giveTableRow:(HoloTableRow *)tableRow;

@end

NS_ASSUME_NONNULL_END
