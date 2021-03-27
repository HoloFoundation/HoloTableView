//
//  HoloTableRow.h
//  HoloTableView
//
//  Created by 与佳期 on 2020/6/1.
//

#import <Foundation/Foundation.h>
#import "HoloTableRowProtocol.h"
@class HoloTableViewRowSwipeAction;

NS_ASSUME_NONNULL_BEGIN

@interface HoloTableRow : NSObject <HoloTableRowProtocol>

/**
 *  Cell class.
 */
@property (nonatomic, assign) Class cell;

/**
 *  Set the data for the cell using the `model` property.
 *
 *  If the `modelHandler` property is nil, then use the `model` property.
 */
@property (nonatomic, strong, nullable) id model;
@property (nonatomic, copy, nullable) id (^modelHandler)(void);

/**
 * The cell must implement the `configSEL` property setting method in order for the HoloTableView to pass the model for the cell.
 */
@property (nonatomic, assign) SEL configSEL;
@property (nonatomic, copy, nullable) void (^beforeConfigureHandler)(UITableViewCell *cell, id _Nullable model);
@property (nonatomic, copy, nullable) void (^afterConfigureHandler)(UITableViewCell *cell, id _Nullable model);


/**
 *  Set the style for the cell using the `style` property.
 *
 *  If the `styleHandler` property is nil, then use the `style` property.
 */
@property (nonatomic, assign) UITableViewCellStyle style;
@property (nonatomic, copy, nullable) UITableViewCellStyle (^styleHandler)(id _Nullable model);

/**
 *  Set the reuse identifier for the cell using the `reuseId` property.
 *
 *  If the `reuseIdHandler` property is nil, then use the `reuseId` property.
 */
@property (nonatomic, copy, nullable) NSString *reuseId;
@property (nonatomic, copy, nullable) NSString *(^reuseIdHandler)(id _Nullable model);

/**
 *  Set the tag for the cell using the `tag` property.
 */
@property (nonatomic, copy, nullable) NSString *tag;

/**
 *  Set the height for the cell using the `height` property.
 *
 *  If the `heightSEL` property is nil or the cell don't implement the `heightSEL` property setting method, then use the `heightHandler` property.
 *  If the `heightHandler` property is nil, then use the `height` property.
 */
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, copy, nullable) CGFloat (^heightHandler)(id _Nullable model);
@property (nonatomic, assign) SEL heightSEL;

/**
 *  Set the estimated height for the cell using the `estimatedHeight` property.
 *
 *  If the `estimatedHeightSEL` property is nil or the cell don't implement the `estimatedHeightSEL` property setting method, then use the `estimatedHeightHandler` property.
 *  If the `estimatedHeightHandler` property is nil, then use the `estimatedHeight` property.
 */
@property (nonatomic, assign) CGFloat estimatedHeight;
@property (nonatomic, copy, nullable) CGFloat (^estimatedHeightHandler)(id _Nullable model);
@property (nonatomic, assign) SEL estimatedHeightSEL;

/**
 *  Set the should highlight or not for the cell using the `estimatedHeight` property.
 *
 *  If the `shouldHighlightSEL` property is nil or the cell don't implement the `shouldHighlightSEL` property setting method, then use the `shouldHighlightHandler` property.
 *  If the `shouldHighlightHandler` property is nil, then use the `shouldHighlight` property.
 */
@property (nonatomic, assign) BOOL shouldHighlight;
@property (nonatomic, copy, nullable) BOOL (^shouldHighlightHandler)(id _Nullable model);
@property (nonatomic, assign) SEL shouldHighlightSEL;

/**
 *  Set the can edit or not for the cell using the `canEdit` property.
 *
 *  If the `canEditHandler` property is nil, then use the `canEdit` property.
 */
@property (nonatomic, assign) BOOL canEdit;
@property (nonatomic, copy, nullable) BOOL (^canEditHandler)(id _Nullable model);
//@property (nonatomic, assign) SEL canEditSEL;

/**
 *  Set the can move or not for the cell using the `canMove` property.
 *
 *  If the `canMoveHandler` property is nil, then use the `canEdit` property.
 */
@property (nonatomic, assign) BOOL canMove;
@property (nonatomic, copy, nullable) BOOL (^canMoveHandler)(id _Nullable model);
//@property (nonatomic, assign) SEL canMoveSEL;

/**
 *  Set the leading swipe actions for the cell using the `leadingSwipeActions` property.
 *
 *  If the `leadingSwipeActionsHandler` property is nil, then use the `leadingSwipeActions` property.
 */
@property (nonatomic, copy, nullable) NSArray<HoloTableViewRowSwipeAction *> *leadingSwipeActions API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);
@property (nonatomic, copy, nullable) NSArray<HoloTableViewRowSwipeAction *> *(^leadingSwipeActionsHandler)(id _Nullable model) API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);
//@property (nonatomic, assign) SEL leadingSwipeActionsSEL;

/**
 *  Set the leading swipe for the cell using the `leadingSwipeHandler` property.
 */
@property (nonatomic, copy, nullable) void (^leadingSwipeHandler)(id action, NSInteger index, void(^completionHandler)(BOOL actionPerformed)) API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);
//@property (nonatomic, assign) SEL leadingSwipeSEL API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

/**
 *  Set the trailing swipe actions for the cell using the `trailingSwipeActions` property.
 *
 *  If the `trailingSwipeActionsHandler` property is nil, then use the `trailingSwipeActions` property.
 */
@property (nonatomic, copy, nullable) NSArray<HoloTableViewRowSwipeAction *> *trailingSwipeActions;
@property (nonatomic, copy, nullable) NSArray<HoloTableViewRowSwipeAction *> *(^trailingSwipeActionsHandler)(id _Nullable model);
//@property (nonatomic, assign) SEL trailingSwipeActionsSEL;

/**
 *  Set the trailing swipe for the cell using the `trailingSwipeHandler` property.
 */
@property (nonatomic, copy, nullable) void (^trailingSwipeHandler)(id action, NSInteger index, void(^completionHandler)(BOOL actionPerformed));
//@property (nonatomic, assign) SEL trailingSwipeSEL;

/**
 *  Set the editing delete title for the cell using the `editingDeleteTitle` property.
 *
 *  If the `editingDeleteTitleHandler` property is nil, then use the `editingDeleteTitle` property.
 */
@property (nonatomic, copy, nullable) NSString *editingDeleteTitle;
@property (nonatomic, copy, nullable) NSString *(^editingDeleteTitleHandler)(id _Nullable model);
//@property (nonatomic, assign) SEL editingDeleteTitleSEL;

/**
 *  Set the editing style for the cell using the `editingStyle` property.
 *
 *  If the `editingStyleHandler` property is nil, then use the `editingStyle` property.
 */
@property (nonatomic, assign) UITableViewCellEditingStyle editingStyle;
@property (nonatomic, copy, nullable) UITableViewCellEditingStyle(^editingStyleHandler)(id _Nullable model);
//@property (nonatomic, assign) SEL editingStyleSEL;

/**
 *  If the cell will select, the `willSelectHandler` will be called.
 *
 *  If the `willSelectSEL` property is nil or the cell don't implement the `willSelectSEL` property setting method, then use the `willSelectHandler` property.
 */
@property (nonatomic, copy, nullable) void (^willSelectHandler)(id _Nullable model);
@property (nonatomic, assign) SEL willSelectSEL;

/**
 *  If the cell will deselect, the `willDeselectHandler` will be called.
 *
 *  If the `willDeselectSEL` property is nil or the cell don't implement the `willDeselectSEL` property setting method, then use the `willDeselectHandler` property.
 */
@property (nonatomic, copy, nullable) void (^willDeselectHandler)(id _Nullable model);
@property (nonatomic, assign) SEL willDeselectSEL;

/**
 *  If the cell did deselect, the `didDeselectHandler` will be called.
 *
 *  If the `didDeselectSEL` property is nil or the cell don't implement the `didDeselectSEL` property setting method, then use the `didDeselectHandler` property.
 */
@property (nonatomic, copy, nullable) void (^didDeselectHandler)(id _Nullable model);
@property (nonatomic, assign) SEL didDeselectSEL;

/**
 *  If the cell did select, the `didSelectHandler` will be called.
 *
 *  If the `didSelectSEL` property is nil or the cell don't implement the `didSelectSEL` property setting method, then use the `didSelectHandler` property.
 */
@property (nonatomic, copy, nullable) void (^didSelectHandler)(id _Nullable model);
@property (nonatomic, assign) SEL didSelectSEL;

/**
 *  If the cell will display, the `willDisplayHandler` will be called.
 *
 *  If the `willDisplaySEL` property is nil or the cell don't implement the `willDisplaySEL` property setting method, then use the `willDisplayHandler` property.
 */
@property (nonatomic, copy, nullable) void (^willDisplayHandler)(UITableViewCell *cell, id _Nullable model);
@property (nonatomic, assign) SEL willDisplaySEL;

/**
 *  If the cell did end displaying, the `didEndDisplayingHandler` will be called.
 *
 *  If the `didEndDisplayingSEL` property is nil or the cell don't implement the `didEndDisplayingSEL` property setting method, then use the `didEndDisplayingHandler` property.
 */
@property (nonatomic, copy, nullable) void (^didEndDisplayingHandler)(UITableViewCell *cell, id _Nullable model);
@property (nonatomic, assign) SEL didEndDisplayingSEL;

/**
 *  If the cell did highlight, the `didHighlightHandler` will be called.
 *
 *  If the `didHighlightSEL` property is nil or the cell don't implement the `didHighlightSEL` property setting method, then use the `didHighlightHandler` property.
 */
@property (nonatomic, copy, nullable) void (^didHighlightHandler)(id _Nullable model);
@property (nonatomic, assign) SEL didHighlightSEL;

/**
 *  If the cell did unhighlight, the `didUnHighlightHandler` will be called.
 *
 *  If the `didUnHighlightSEL` property is nil or the cell don't implement the `didUnHighlightSEL` property setting method, then use the `didUnHighlightHandler` property.
 */
@property (nonatomic, copy, nullable) void (^didUnHighlightHandler)(id _Nullable model);
@property (nonatomic, assign) SEL didUnHighlightSEL;

/**
 *  If the cell accessory button tapped, the `accessoryButtonTappedHandler` will be called.
 *
 *  If the `accessoryButtonTappedSEL` property is nil or the cell don't implement the `accessoryButtonTappedSEL` property setting method, then use the `accessoryButtonTappedHandler` property.
 */
@property (nonatomic, copy, nullable) void (^accessoryButtonTappedHandler)(id _Nullable model);
@property (nonatomic, assign) SEL accessoryButtonTappedSEL;

/**
 *  If the cell will begin editing, the `willBeginEditingHandler` will be called.
 *
 *  If the `willBeginEditingSEL` property is nil or the cell don't implement the `willBeginEditingSEL` property setting method, then use the `willBeginEditingHandler` property.
 */
@property (nonatomic, copy, nullable) void (^willBeginEditingHandler)(id _Nullable model);
@property (nonatomic, assign) SEL willBeginEditingSEL;

/**
 *  If the cell did end editing, the `didEndEditingHandler` will be called.
 *
 *  If the `didEndEditingSEL` property is nil or the cell don't implement the `didEndEditingSEL` property setting method, then use the `didEndEditingHandler` property.
 */
@property (nonatomic, copy, nullable) void (^didEndEditingHandler)(id _Nullable model);
@property (nonatomic, assign) SEL didEndEditingSEL;

/**
 *  Set the target move index for the cell using the `targetMoveHandler` property.
 */
@property (nonatomic, copy, nullable) NSIndexPath *(^targetMoveHandler)(NSIndexPath *atIndexPath, NSIndexPath *toIndexPath);
//@property (nonatomic, assign) SEL targetMoveSEL;

/**
 *  If the cell is moved, the `moveHandler` will be called.
 */
@property (nonatomic, copy, nullable) void (^moveHandler)(NSIndexPath *atIndexPath, NSIndexPath *toIndexPath, void(^completionHandler)(BOOL actionPerformed));
//@property (nonatomic, assign) SEL moveSEL;

/**
 *  If the cell is editing delete, the `editingDeleteHandler` will be called.
 */
@property (nonatomic, copy, nullable) void (^editingDeleteHandler)(id _Nullable model, void(^completionHandler)(BOOL actionPerformed));
//@property (nonatomic, assign) SEL editingDeleteSEL;

/**
 *  If the cell is editing Insert, the `editingInsertHandler` will be called.
 */
@property (nonatomic, copy, nullable) void (^editingInsertHandler)(id _Nullable model);
//@property (nonatomic, assign) SEL editingInsertSEL;


/**
 *  Set the delegate for the cell using the `delegate` property.
 *
 *  If the `delegateSEL` property is nil or the cell don't implement the `delegateSEL` property setting method, then use the `delegate` property.
 */
@property (nonatomic, weak, nullable) id delegate;
@property (nonatomic, assign) SEL delegateSEL;

@end

NS_ASSUME_NONNULL_END
