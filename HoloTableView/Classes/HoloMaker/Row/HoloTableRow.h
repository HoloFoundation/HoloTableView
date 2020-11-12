//
//  HoloTableRow.h
//  HoloTableView
//
//  Created by 与佳期 on 2020/6/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

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

@property (nonatomic, copy) CGFloat (^heightHandler)(id _Nullable model);

@property (nonatomic, copy) CGFloat (^estimatedHeightHandler)(id _Nullable model);

@property (nonatomic, copy) BOOL (^shouldHighlightHandler)(id _Nullable model);

@property (nonatomic, copy) BOOL (^canEditHandler)(id _Nullable model);

@property (nonatomic, copy) BOOL (^canMoveHandler)(id _Nullable model);

@property (nonatomic, copy) NSArray *(^leadingSwipeActionsHandler)(id _Nullable model) API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

@property (nonatomic, copy) NSArray *(^trailingSwipeActionsHandler)(id _Nullable model);

@property (nonatomic, copy) NSString *(^editingDeleteTitleHandler)(id _Nullable model);

@property (nonatomic, copy) UITableViewCellEditingStyle(^editingStyleHandler)(id _Nullable model);

@property (nonatomic, copy) void (^willSelectHandler)(id _Nullable model);

@property (nonatomic, copy) void (^willDeselectHandler)(id _Nullable model);

@property (nonatomic, copy) void (^didDeselectHandler)(id _Nullable model);

@property (nonatomic, copy) void (^didSelectHandler)(id _Nullable model);

@property (nonatomic, copy) void (^beforeConfigureHandler)(UITableViewCell *cell, id _Nullable model);

@property (nonatomic, copy) void (^afterConfigureHandler)(UITableViewCell *cell, id _Nullable model);

@property (nonatomic, copy) void (^willDisplayHandler)(UITableViewCell *cell, id _Nullable model);

@property (nonatomic, copy) void (^didEndDisplayingHandler)(UITableViewCell *cell, id _Nullable model);

@property (nonatomic, copy) void (^didHighlightHandler)(id _Nullable model);

@property (nonatomic, copy) void (^didUnHighlightHandler)(id _Nullable model);

@property (nonatomic, copy) void (^accessoryButtonTappedHandler)(id _Nullable model);

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

@property (nonatomic, assign) SEL heightSEL;

@property (nonatomic, assign) SEL estimatedHeightSEL;

@property (nonatomic, assign) SEL shouldHighlightSEL;

//@property (nonatomic, assign) SEL canEditSEL;
//
//@property (nonatomic, assign) SEL canMoveSEL;
//
//@property (nonatomic, assign) SEL leadingSwipeActionsSEL;
//
//@property (nonatomic, assign) SEL trailingSwipeActionsSEL;
//
//@property (nonatomic, assign) SEL editingDeleteTitleSEL;
//
//@property (nonatomic, assign) SEL editingStyleSEL;

@property (nonatomic, assign) SEL willSelectSEL;

@property (nonatomic, assign) SEL willDeselectSEL;

@property (nonatomic, assign) SEL didDeselectSEL;

@property (nonatomic, assign) SEL didSelectSEL;

@property (nonatomic, assign) SEL willDisplaySEL;

@property (nonatomic, assign) SEL didEndDisplayingSEL;

@property (nonatomic, assign) SEL didHighlightSEL;

@property (nonatomic, assign) SEL didUnHighlightSEL;

@property (nonatomic, assign) SEL accessoryButtonTappedSEL;

//@property (nonatomic, assign) SEL leadingSwipeSEL API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);
//
//@property (nonatomic, assign) SEL trailingSwipeSEL;

@property (nonatomic, assign) SEL willBeginEditingSEL;

@property (nonatomic, assign) SEL didEndEditingSEL;

//@property (nonatomic, assign) SEL targetMoveSEL;
//
//@property (nonatomic, assign) SEL moveSEL;
//
//@property (nonatomic, assign) SEL editingDeleteSEL;
//
//@property (nonatomic, assign) SEL editingInsertSEL;

@end

NS_ASSUME_NONNULL_END
