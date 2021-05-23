//
//  UITableView+HoloDeprecated.h
//  HoloTableView
//
//  Created by 与佳期 on 2021/5/22.
//

#import <UIKit/UIKit.h>
@class HoloTableViewUpdateRowMaker;

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (HoloDeprecated)

/**
 *  Creates a HoloTableViewUpdateRowMaker in the callee for current UITableView.
 *  Update these rows in the callee for the section according to the tag.
 *  If the section according to the tag don't contain these rows, ignore them.
 *
 *  @param block Scope within which you can update some rows which you wish to apply to the section according to the tag.
 *  @param tag The tag of section which you wish to update rows.
 */
- (void)holo_updateRows:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block
              inSection:(NSString *)tag DEPRECATED_MSG_ATTRIBUTE("Please use `holo_updateRowsInSection:block:` api instead.");

/**
 *  Creates a HoloTableViewUpdateRowMaker in the callee for current UITableView.
 *  Update these rows in the callee for the section according to the tag.
 *  If the section according to the tag don't contain these rows, ignore them.
 *
 *  Refresh current UITableView automatically.
 *
 *  @param block Scope within which you can update some rows which you wish to apply to the section according to the tag.
 *  @param tag The tag of section which you wish to update rows.
 *  @param animation A constant that indicates how the reloading is to be animated, for example, fade out or slide out from the bottom. See UITableViewRowAnimation for descriptions of these constants. The animation constant affects the direction in which both the old and the new rows slide. For example, if the animation constant is UITableViewRowAnimationRight, the old rows slide out to the right and the new cells slide in from the right.
 */
- (void)holo_updateRows:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block
              inSection:(NSString *)tag
    withReloadAnimation:(UITableViewRowAnimation)animation DEPRECATED_MSG_ATTRIBUTE("Please use `holo_updateRowsInSection:block:withReloadAnimation:` api instead.");

/**
 *  Creates a HoloTableViewUpdateRowMaker in the callee for current UITableView.
 *  Re-create these rows in the callee for the section according to the tag.
 *  If the section according to the tag don't contain these rows, ignore them.
 *
 *  @param block Scope within which you can re-create some rows which you wish to apply to the section according to the tag.
 *  @param tag The tag of section which you wish to remake rows.
*/
- (void)holo_remakeRows:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block
              inSection:(NSString *)tag DEPRECATED_MSG_ATTRIBUTE("Please use `holo_remakeRows:block:` api instead.");

/**
 *  Creates a HoloTableViewUpdateRowMaker in the callee for current UITableView.
 *  Re-create these rows in the callee for the section according to the tag.
 *  If the section according to the tag don't contain these rows, ignore them.
 *
 *  Refresh current UITableView automatically.
 *
 *  @param block Scope within which you can re-create some rows which you wish to apply to the section according to the tag.
 *  @param tag The tag of section which you wish to remake rows.
 *  @param animation A constant that indicates how the reloading is to be animated, for example, fade out or slide out from the bottom. See UITableViewRowAnimation for descriptions of these constants. The animation constant affects the direction in which both the old and the new rows slide. For example, if the animation constant is UITableViewRowAnimationRight, the old rows slide out to the right and the new cells slide in from the right.
 */
- (void)holo_remakeRows:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block
              inSection:(NSString *)tag
    withReloadAnimation:(UITableViewRowAnimation)animation DEPRECATED_MSG_ATTRIBUTE("Please use `holo_remakeRows:block:withReloadAnimation:` api instead.");

@end

NS_ASSUME_NONNULL_END
