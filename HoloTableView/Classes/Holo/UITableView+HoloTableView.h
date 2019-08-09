//
//  UITableView+HoloTableView.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import <UIKit/UIKit.h>
@class HoloTableViewConfiger, HoloTableViewRowMaker, HoloTableViewSectionMaker, HoloTableViewUpdateRowMaker;

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (HoloTableView)

#pragma mark - configure cell class map
/**
 *  Creates a HoloTableViewConfiger in the callee for current UITableView.
 *  Configure pairs of map (class name match cell name) for all cells.
 *  If the class name doesn't exist, creat a class with the cell name.
 *
 *  @param block Scope within which you can configure the cell name and class name's map which you wish to apply to current UITableView.
 */
- (void)holo_configTableView:(void(NS_NOESCAPE ^)(HoloTableViewConfiger *configer))block;


#pragma mark - section
/**
 *  Creates a HoloTableViewSectionMaker in the callee for current UITableView.
 *  Append these sections in the callee to the data source, don't care about tag of the section.
 *
 *  @param block Scope within which you can create some sections which you wish to apply to current UITableView.
 */
- (void)holo_makeSections:(void(NS_NOESCAPE ^)(HoloTableViewSectionMaker *make))block;

/**
 *  Creates a HoloTableViewSectionMaker in the callee for current UITableView.
 *  Append these sections in the callee to the data source, don't care about tag of the section.
 *
 *  Refresh current UITableView automatically.
 *
 *  @param block Scope within which you can create some sections which you wish to apply to current UITableView.
 *  @param animation A constant that indicates how the insertion is to be animated, for example, fade in or slide in from the left. See UITableViewRowAnimation for descriptions of these constants.
 *
 */
- (void)holo_makeSections:(void(NS_NOESCAPE ^)(HoloTableViewSectionMaker *make))block withReloadAnimation:(UITableViewRowAnimation)animation;

/**
 *  Creates a HoloTableViewSectionMaker in the callee for current UITableView.
 *  Update these sections in the callee for current UITableView.
 *  If current UITableView don't contain some sections in the callee, ignore them.
 *
 *  @param block Scope within which you can create some sections which you wish to apply to current UITableView.
 */
- (void)holo_updateSections:(void(NS_NOESCAPE ^)(HoloTableViewSectionMaker *make))block;

/**
 *  Creates a HoloTableViewSectionMaker in the callee for current UITableView.
 *  Update these sections in the callee for current UITableView.
 *  If current UITableView don't contain some sections in the callee, ignore them.
 *
 *  Refresh current UITableView automatically.
 *
 *  @param block Scope within which you can create some sections which you wish to apply to current UITableView.
 *  @param animation A constant that indicates how the reloading is to be animated, for example, fade out or slide out from the bottom. See UITableViewRowAnimation for descriptions of these constants. The animation constant affects the direction in which both the old and the new section rows slide. For example, if the animation constant is UITableViewRowAnimationRight, the old rows slide out to the right and the new cells slide in from the right.
 */
- (void)holo_updateSections:(void(NS_NOESCAPE ^)(HoloTableViewSectionMaker *make))block withReloadAnimation:(UITableViewRowAnimation)animation;

/**
 *  Creates a HoloTableViewSectionMaker in the callee for current UITableView.
 *  Remake these sections (Reinit all properties) in the callee for current UITableView.
 *  If current UITableView don't contain some sections in the callee, ignore them.
 *
 *  @param block Scope within which you can create some sections which you wish to apply to current UITableView.
 */
- (void)holo_remakeSections:(void(NS_NOESCAPE ^)(HoloTableViewSectionMaker *make))block;

/**
 *  Creates a HoloTableViewSectionMaker in the callee for current UITableView.
 *  Remake these sections (Reinit all properties) in the callee for current UITableView.
 *  If current UITableView don't contain some sections in the callee, ignore them.
 *
 *  Refresh current UITableView automatically.
 *
 *  @param block Scope within which you can create some sections which you wish to apply to current UITableView.
 *  @param animation A constant that indicates how the reloading is to be animated, for example, fade out or slide out from the bottom. See UITableViewRowAnimation for descriptions of these constants. The animation constant affects the direction in which both the old and the new section rows slide. For example, if the animation constant is UITableViewRowAnimationRight, the old rows slide out to the right and the new cells slide in from the right.
 */
- (void)holo_remakeSections:(void(NS_NOESCAPE ^)(HoloTableViewSectionMaker *make))block withReloadAnimation:(UITableViewRowAnimation)animation;

/**
 *  Remove all sections.
 */
- (void)holo_removeAllSections;

/**
 *  Remove all sections.
 *
 *  Refresh current UITableView automatically.
 *
 *  @param animation A constant that either specifies the kind of animation to perform when deleting the section or requests no animation. See UITableViewRowAnimation for descriptions of the constants.
 */
- (void)holo_removeAllSectionsWithReloadAnimation:(UITableViewRowAnimation)animation;

/**
 *  Remove a section according to the tag.
 *
 *  @param tag section tag
 */
- (void)holo_removeSection:(NSString *)tag;

/**
 *  Remove a section according to the tag.
 *
 *  Refresh current UITableView automatically.
 *
 *  @param tag section tag
 *  @param animation A constant that either specifies the kind of animation to perform when deleting the section or requests no animation. See UITableViewRowAnimation for descriptions of the constants.
 */
- (void)holo_removeSection:(NSString *)tag withReloadAnimation:(UITableViewRowAnimation)animation;


#pragma mark - row
/**
 *  Creates a HoloTableViewRowMaker in the callee for current UITableView.
 *  Append these rows in the callee to defult section of UITableView.
 *  If current UITableView don't contain any section, create a new one and append it to the data source.
 *
 *  @param block Scope within which you can create some rows which you wish to apply to current UITableView.
 */
- (void)holo_makeRows:(void(NS_NOESCAPE ^)(HoloTableViewRowMaker *make))block;

/**
 *  Creates a HoloTableViewRowMaker in the callee for current UITableView.
 *  Append these rows in the callee to defult section of UITableView.
 *  If current UITableView don't contain any section, create a new one and append it to the data source.
 *
 *  Refresh current UITableView automatically.
 *
 *  @param block Scope within which you can create some rows which you wish to apply to current UITableView.
 *  @param animation A constant that either specifies the kind of animation to perform when inserting the cell or requests no animation. See UITableViewRowAnimation for descriptions of the constants.
 */
- (void)holo_makeRows:(void(NS_NOESCAPE ^)(HoloTableViewRowMaker *make))block withReloadAnimation:(UITableViewRowAnimation)animation;

/**
 *  Creates a HoloTableViewRowMaker in the callee for current UITableView.
 *  Append these rows in the callee to a section according to the tag.
 *  If current UITableView don't contain a section with the tag, create a new one with the tag and append it to the data source.
 *
 *  @param tag section tag
 *  @param block Scope within which you can create some rows which you wish to apply to current UITableView.
 */
- (void)holo_makeRowsInSection:(NSString *)tag block:(void(NS_NOESCAPE ^)(HoloTableViewRowMaker *make))block;

/**
 *  Creates a HoloTableViewRowMaker in the callee for current UITableView.
 *  Append these rows in the callee to a section according to the tag.
 *  If current UITableView don't contain a section with the tag, create a new one with the tag and append it to the data source.
 *
 *  Refresh current UITableView automatically.
 *
 *  @param tag section tag
 *  @param block Scope within which you can create some rows which you wish to apply to current UITableView.
 *  @param animation A constant that either specifies the kind of animation to perform when inserting the cell or requests no animation. See UITableViewRowAnimation for descriptions of the constants.
 */
- (void)holo_makeRowsInSection:(NSString *)tag block:(void(NS_NOESCAPE ^)(HoloTableViewRowMaker *make))block withReloadAnimation:(UITableViewRowAnimation)animation;

/**
 *  Creates a HoloTableViewUpdateRowMaker in the callee for current UITableView.
 *  Update these rows in the callee for current UITableView.
 *  If current UITableView don't contain these rows, ignore them.
 *
 *  @param block Scope within which you can create some rows which you wish to apply to current UITableView.
 */
- (void)holo_updateRows:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block;

/**
 *  Creates a HoloTableViewUpdateRowMaker in the callee for current UITableView.
 *  Update these rows in the callee for current UITableView.
 *  If current UITableView don't contain these rows, ignore them.
 *
 *  Refresh current UITableView automatically.
 *
 *  @param block Scope within which you can create some rows which you wish to apply to current UITableView.
 *  @param animation A constant that indicates how the reloading is to be animated, for example, fade out or slide out from the bottom. See UITableViewRowAnimation for descriptions of these constants. The animation constant affects the direction in which both the old and the new rows slide. For example, if the animation constant is UITableViewRowAnimationRight, the old rows slide out to the right and the new cells slide in from the right.
 */
- (void)holo_updateRows:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block withReloadAnimation:(UITableViewRowAnimation)animation;

/**
 *  Creates a HoloTableViewUpdateRowMaker in the callee for current UITableView.
 *  Remake these rows (Reinit all properties) in the callee for current UITableView.
 *  If current UITableView don't contain these rows, ignore them.
 *
 *  @param block Scope within which you can create some rows which you wish to apply to current UITableView.
 */
- (void)holo_remakeRows:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block;

/**
 *  Creates a HoloTableViewUpdateRowMaker in the callee for current UITableView.
 *  Remake these rows (Reinit all properties) in the callee for current UITableView.
 *  If current UITableView don't contain these rows, ignore them.
 *
 *  Refresh current UITableView automatically.
 *
 *  @param block Scope within which you can create some rows which you wish to apply to current UITableView.
 *  @param animation A constant that indicates how the reloading is to be animated, for example, fade out or slide out from the bottom. See UITableViewRowAnimation for descriptions of these constants. The animation constant affects the direction in which both the old and the new rows slide. For example, if the animation constant is UITableViewRowAnimationRight, the old rows slide out to the right and the new cells slide in from the right.
 */
- (void)holo_remakeRows:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block withReloadAnimation:(UITableViewRowAnimation)animation;

/**
 *  Remove all rows in a section according to the tag.
 *
 *  @param tag section tag
 */
- (void)holo_removeAllRowsInSection:(NSString *)tag;

/**
 *  Remove all rows in a section according to the tag.
 *
 *  @param tag section tag
 *  @param animation A constant that indicates how the deletion is to be animated, for example, fade out or slide out from the bottom. See UITableViewRowAnimation for descriptions of these constants.
 */
- (void)holo_removeAllRowsInSection:(NSString *)tag withReloadAnimation:(UITableViewRowAnimation)animation;

/**
 *  Remove a rows according to the tag in all sections.
 *
 *  @param tag row tag
 */
- (void)holo_removeRow:(NSString *)tag;

/**
 *  Remove a rows according to the tag in all sections.
 *
 *  Refresh current UITableView automatically.
 *
 *  @param tag row tag
 *  @param animation A constant that indicates how the deletion is to be animated, for example, fade out or slide out from the bottom. See UITableViewRowAnimation for descriptions of these constants.
 */
- (void)holo_removeRow:(NSString *)tag withReloadAnimation:(UITableViewRowAnimation)animation;

//- (void)holo_removeRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)holo_appendRow:(HoloRow *)row atIndexPath:(NSIndexPath *)indexPath;
//- (void)holo_moveRowFromIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
