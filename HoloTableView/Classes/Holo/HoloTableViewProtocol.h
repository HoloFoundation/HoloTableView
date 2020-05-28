//
//  HoloTableViewProtocol.h
//  Pods
//
//  Created by 与佳期 on 2019/7/28.
//

#ifndef HoloTableViewProtocol_h
#define HoloTableViewProtocol_h

NS_ASSUME_NONNULL_BEGIN

////////////////////////////////////////////////////////////
@protocol HoloTableViewCellProtocol <NSObject>

@optional

- (void)holo_configureCellWithModel:(id)model;

+ (CGFloat)holo_heightForCellWithModel:(id)model;

+ (CGFloat)holo_estimatedHeightForCellWithModel:(id)model;

- (BOOL)holo_shouldHighlightForCellWithModel:(id)model;

- (BOOL)holo_canEditForCellWithModel:(id)model;

- (BOOL)holo_canMoveForCellWithModel:(id)model;

- (NSArray *)holo_leadingSwipeActionsForCellWithModel:(id)model;

- (NSArray *)holo_trailingSwipeActionsForCellWithModel:(id)model;

- (NSString *)holo_editingDeleteTitleForCellWithModel:(id)model;

- (NSString *)holo_editingStyleForCellWithModel:(id)model;

- (void)holo_willSelectCellWithModel:(id)model;

- (void)holo_willDeselectCellWithModel:(id)model;

- (void)holo_didDeselectCellWithModel:(id)model;

- (void)holo_didSelectCellWithModel:(id)model;

- (void)holo_willDisplayCellWithModel:(id)model;

- (void)holo_didEndDisplayingCellWithModel:(id)model;

- (void)holo_didHighlightCellWithModel:(id)model;

- (void)holo_didUnHighlightCellWithModel:(id)model;

- (void)holo_accessoryCellWithModel:(id)model;

- (void)holo_willBeginEditingCellWithModel:(id)model;

- (void)holo_didEndEditingCellWithModel:(id)model;

@end

////////////////////////////////////////////////////////////
@protocol HoloTableViewHeaderProtocol <NSObject>

@optional

- (void)holo_configureHeaderWithModel:(id)model;

+ (CGFloat)holo_heightForHeaderWithModel:(id)model;

+ (CGFloat)holo_estimatedHeightForHeaderWithModel:(id)model;

- (void)holo_willDisplayHeaderWithModel:(id)model;

- (void)holo_didEndDisplayingHeaderWithModel:(id)model;

@end

////////////////////////////////////////////////////////////
@protocol HoloTableViewFooterProtocol <NSObject>

@optional

- (void)holo_configureFooterWithModel:(id)model;

+ (CGFloat)holo_heightForFooterWithModel:(id)model;

+ (CGFloat)holo_estimatedHeightForFooterWithModel:(id)model;

- (void)holo_willDisplayFooterWithModel:(id)model;

- (void)holo_didEndDisplayingFooterWithModel:(id)model;

@end

////////////////////////////////////////////////////////////
@protocol HoloTableViewHeaderFooterProtocol <NSObject>
@optional
- (void)holo_configureHeaderFooterWithModel:(id)model DEPRECATED_MSG_ATTRIBUTE("Please use `headerConfigSEL` or `footerConfigSEL` api instead.");
+ (CGFloat)holo_heightForHeaderFooterWithModel:(id)model DEPRECATED_MSG_ATTRIBUTE("Please use `headerHeightSEL` or `footerHeightSEL` api instead.");
+ (CGFloat)holo_estimatedHeightForHeaderFooterWithModel:(id)model DEPRECATED_MSG_ATTRIBUTE("Please use `headerEstimatedHeightSEL` or `footerEstimatedHeightSEL` api instead.");
@end

////////////////////////////////////////////////////////////
@protocol HoloTableViewDelegate <UITableViewDelegate>

@end

////////////////////////////////////////////////////////////
@protocol HoloTableViewDataSource <NSObject>

@optional

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;    // fixed font style. use custom view (UILabel) if you want something different
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;

// Editing

// Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

// Moving/reordering

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;

// Index

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView;                               // return list of section titles to display in section index view (e.g. "ABCD...Z#")
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;  // tell table which section corresponds to section title/index (e.g. "B",1))

// Data manipulation - insert and delete support

// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
// Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

// Data manipulation - reorder / moving support

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

@end

NS_ASSUME_NONNULL_END

#endif /* HoloTableViewProtocol_h */
