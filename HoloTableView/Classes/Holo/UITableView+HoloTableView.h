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
 *  If the class doesn't exist, creat a class with the cell name.
 *
 *  @param block scope within which you can configure the cell name and class name's map which you wish to apply to current UITableView.
 */
- (void)holo_configTableView:(void(NS_NOESCAPE ^)(HoloTableViewConfiger *configer))block;


#pragma mark - operate section
/**
 *  Creates a HoloTableViewSectionMaker in the callee for current UITableView.
 *  Append these sections in the callee to the data source, don't care about tag of the section.
 *
 *  @param block scope within which you can create some sections which you wish to apply to current UITableView.
 */
- (void)holo_makeSection:(void(NS_NOESCAPE ^)(HoloTableViewSectionMaker *make))block;

/**
 *  Creates a HoloTableViewSectionMaker in the callee for current UITableView.
 *  Update these sections in the callee for current UITableView.
 *  If current UITableView don't contain some sections in the callee, append them to the data source.
 *
 *  @param block scope within which you can create some sections which you wish to apply to current UITableView.
 */
- (void)holo_updateSection:(void(NS_NOESCAPE ^)(HoloTableViewSectionMaker *make))block;

/**
 *  Remove all sections.
 */
- (void)holo_removeAllSection;

/**
 *  Remove a section according to the tag.
 *
 *  @param tag section tag
 */
- (void)holo_removeSection:(NSString *)tag;


#pragma mark - operate row
/**
 *  Creates a HoloTableViewRowMaker in the callee for current UITableView.
 *  Append these rows in the callee to defult section of UITableView.
 *  If current UITableView don't contain any section, create a new one and append it to the data source.
 *
 *  @param block scope within which you can create some rows which you wish to apply to current UITableView.
 */
- (void)holo_makeRows:(void(NS_NOESCAPE ^)(HoloTableViewRowMaker *make))block;

/**
 *  Creates a HoloTableViewUpdateRowMaker in the callee for current UITableView.
 *  Update these rows in the callee for current UITableView.
 *  If current UITableView can't find these rows, ignore theme.
 *
 *  @param block scope within which you can create some rows which you wish to apply to current UITableView.
 */
- (void)holo_updateRows:(void(NS_NOESCAPE ^)(HoloTableViewUpdateRowMaker *make))block;

/**
 *  Creates a HoloTableViewRowMaker in the callee for current UITableView.
 *  Append these rows in the callee to a section according to the tag.
 *  If current UITableView don't contain a section with the tag, create a new one with the tag and append it to the data source.
 *
 *  @param tag section tag
 *
 *  @param block scope within which you can create some rows which you wish to apply to current UITableView.
 */
- (void)holo_makeRowsInSection:(NSString *)tag block:(void(NS_NOESCAPE ^)(HoloTableViewRowMaker *make))block;

/**
 *  Remove all rows in a section according to the tag.
 *
 *  @param tag section tag
 */
- (void)holo_removeAllRowsInSection:(NSString *)tag;

/**
 *  Remove a rows according to the tag in all sections.
 *
 *  @param tag row tag
 */
- (void)holo_removeRow:(NSString *)tag;

@end

NS_ASSUME_NONNULL_END
