//
//  HoloTableRowMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2020/6/1.
//

#import <Foundation/Foundation.h>
@class HoloTableRow;

NS_ASSUME_NONNULL_BEGIN

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

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^heightHandler)(CGFloat (^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^estimatedHeightHandler)(CGFloat (^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^shouldHighlightHandler)(BOOL (^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^canEditHandler)(BOOL (^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^canMoveHandler)(BOOL (^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^leadingSwipeActionsHandler)(NSArray *(^)(id _Nullable model)) API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^trailingSwipeActionsHandler)(NSArray *(^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^editingDeleteTitleHandler)(NSString *(^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^editingStyleHandler)(UITableViewCellEditingStyle(^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willSelectHandler)(void(^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willDeselectHandler)(void(^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didDeselectHandler)(void(^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didSelectHandler)(void(^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willDisplayHandler)(void(^)(UITableViewCell *cell, id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didEndDisplayingHandler)(void(^)(UITableViewCell *cell, id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didHighlightHandler)(void(^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didUnHighlightHandler)(void(^)(id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^accessoryButtonTappedHandler)(void(^)(id _Nullable model));

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

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^heightSEL)(SEL heightSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^estimatedHeightSEL)(SEL estimatedHeightSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^shouldHighlightSEL)(SEL shouldHighlightSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^canEditSEL)(SEL canEditSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^canMoveSEL)(SEL canMoveSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^leadingSwipeActionsSEL)(SEL leadingSwipeActionsSEL) API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^trailingSwipeActionsSEL)(SEL trailingSwipeActionsSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^editingDeleteTitleSEL)(SEL editingDeleteTitleSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^editingStyleSEL)(SEL editingStyleSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willSelectSEL)(SEL willSelectSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willDeselectSEL)(SEL willDeselectSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didDeselectSEL)(SEL didDeselectSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didSelectSEL)(SEL didSelectSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willDisplaySEL)(SEL willDisplaySEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didEndDisplayingSEL)(SEL didEndDisplayingSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didHighlightSEL)(SEL didHighlightSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didUnHighlightSEL)(SEL didUnHighlightSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^accessoryButtonTappedSEL)(SEL accessoryButtonTappedSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^willBeginEditingSEL)(SEL willBeginEditingSEL);

@property (nonatomic, copy, readonly) HoloTableRowMaker *(^didEndEditingSEL)(SEL didEndEditingSEL);


- (HoloTableRow *)fetchTableRow;

- (void)giveTableRow:(HoloTableRow *)tableRow;

@end

NS_ASSUME_NONNULL_END
