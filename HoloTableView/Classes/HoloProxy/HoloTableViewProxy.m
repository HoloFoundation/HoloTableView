//
//  HoloTableViewProxy.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import "HoloTableViewProxy.h"
#import "HoloTableViewProxyData.h"
#import "HoloTableViewRowMaker.h"
#import "HoloTableViewSectionMaker.h"
#import "HoloTableViewRowSwipeAction.h"

@interface HoloTableViewProxy ()

@property (nonatomic, copy, readonly) NSArray<HoloTableSection *> *holoSections;

@property (nonatomic, copy, readonly) NSDictionary<NSString *, Class> *holoCellClsMap;

@end

@implementation HoloTableViewProxy

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.holo_dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [self.holo_dataSource numberOfSectionsInTableView:tableView];
    }
    
    return self.holoSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.holo_dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        return [self.holo_dataSource tableView:tableView numberOfRowsInSection:section];
    }
    if (section >= self.holoSections.count) return 0;
    
    HoloTableSection *holoSection = self.holoSections[section];
    return holoSection.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_dataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        return [self.holo_dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    
    NSString *clsName = NSStringFromClass(self.holoCellClsMap[holoRow.cell]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:clsName forIndexPath:indexPath];
    
    if (holoRow.configSEL && [cell respondsToSelector:holoRow.configSEL]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [cell performSelector:holoRow.configSEL withObject:holoRow.model];
#pragma clang diagnostic pop
    }
    return cell;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if ([self.holo_dataSource respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
        return [self.holo_dataSource sectionIndexTitlesForTableView:tableView];
    }
    
    return self.holo_proxyData.holo_sectionIndexTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if ([self.holo_dataSource respondsToSelector:@selector(tableView:sectionForSectionIndexTitle:atIndex:)]) {
        return [self.holo_dataSource tableView:tableView sectionForSectionIndexTitle:title atIndex:index];
    }
    
    if (self.holo_proxyData.holo_sectionForSectionIndexTitleHandler) {
        return self.holo_proxyData.holo_sectionForSectionIndexTitleHandler(title, index);
    }
    return index;
}

/// Editing
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_dataSource respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
        return [self.holo_dataSource tableView:tableView canEditRowAtIndexPath:indexPath];
    }
    
    if (indexPath.section >= self.holoSections.count) return NO;
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    if (indexPath.row >= holoSection.rows.count) return NO;
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    return holoRow.canEdit;
}

/// Editing: delete/insert
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_dataSource respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        [self.holo_dataSource tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
    
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (holoRow.editingDeleteHandler) {
            holoRow.editingDeleteHandler(holoRow.model, ^(BOOL actionPerformed) {
                // must remove the data before deleting the cell
                [holoSection holo_removeRow:holoRow];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            });
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        if (holoRow.editingInsertHandler) holoRow.editingInsertHandler(holoRow.model);
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_dataSource respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)]) {
        return [self.holo_dataSource tableView:tableView canMoveRowAtIndexPath:indexPath];
    }

    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    return holoRow.canMove;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if ([self.holo_dataSource respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)]) {
        [self.holo_dataSource tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
    
    HoloTableSection *sourceSection = self.holoSections[sourceIndexPath.section];
    HoloTableRow *sourceRow = sourceSection.rows[sourceIndexPath.row];
    if (sourceRow.moveHandler) {
        sourceRow.moveHandler(sourceIndexPath, destinationIndexPath, ^(BOOL actionPerformed) {
            if (actionPerformed) {
                HoloTableSection *destinationSection = self.holoSections[destinationIndexPath.section];
                [sourceSection holo_removeRow:sourceRow];
                [destinationSection holo_insertRows:@[sourceRow] atIndex:destinationIndexPath.row];
            }
        });
    }
}

// support these two methods with viewForHeaderInSection: and viewForFooterInSection:
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return [self.holo_delegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    
    Class cls = self.holoCellClsMap[holoRow.cell];
    if (holoRow.heightSEL && [cls respondsToSelector:holoRow.heightSEL]) {
        return [self _heightWithMethodSignatureCls:cls selector:holoRow.heightSEL model:holoRow.model];
    }
    return holoRow.height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)]) {
        return [self.holo_delegate tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
    }
    
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];

    Class cls = self.holoCellClsMap[holoRow.cell];
    if (holoRow.estimatedHeightSEL && [cls respondsToSelector:holoRow.estimatedHeightSEL]) {
        return [self _heightWithMethodSignatureCls:cls selector:holoRow.estimatedHeightSEL model:holoRow.model];
    }
    
    // Only on iOS12, when you slide the tableView to the bottom and out of one screen, then perform "reloadData" method, the tableView will flash.
    // To solve this problem, return tableView:heightForRowAtIndexPath: value on iOS12.
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 12.0 && version.doubleValue < 13.0) {
        return [self tableView:tableView heightForRowAtIndexPath:indexPath];
    } else {
        return holoRow.estimatedHeight;
    }
}

- (CGFloat)_heightWithMethodSignatureCls:(Class)cls selector:(SEL)selector model:(id)model {
    NSMethodSignature *signature = [cls methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = cls;
    invocation.selector = selector;
    [invocation setArgument:&model atIndex:2];
    [invocation invoke];
    
    CGFloat height;
    [invocation getReturnValue:&height];
    return height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.holo_delegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
    
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    if (holoRow.willDisplayHandler) holoRow.willDisplayHandler(cell, holoRow.model);
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)]) {
        [self.holo_delegate tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
    }
    
    if (indexPath.section >= self.holoSections.count) return;
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    
    if (indexPath.row >= holoSection.rows.count) return;
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    if (holoRow.didEndDisplayingHandler) holoRow.didEndDisplayingHandler(cell, holoRow.model);
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
        return [self.holo_delegate tableView:tableView willSelectRowAtIndexPath:indexPath];
    }
    
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    if (holoRow.willSelectHandler) holoRow.willSelectHandler(holoRow.model);
    return indexPath;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:willDeselectRowAtIndexPath:)]) {
        return [self.holo_delegate tableView:tableView willDeselectRowAtIndexPath:indexPath];
    }
    
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    if (holoRow.willDeselectHandler) holoRow.willDeselectHandler(holoRow.model);
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
        [self.holo_delegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
    
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    if (holoRow.didDeselectHandler) holoRow.didDeselectHandler(holoRow.model);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.holo_delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    if (holoRow.didSelectHandler) holoRow.didSelectHandler(holoRow.model);
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:shouldHighlightRowAtIndexPath:)]) {
        return [self.holo_delegate tableView:tableView shouldHighlightRowAtIndexPath:indexPath];
    }
    
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    return holoRow.shouldHighlight;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:didHighlightRowAtIndexPath:)]) {
        [self.holo_delegate tableView:tableView didHighlightRowAtIndexPath:indexPath];
    }
    
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    if (holoRow.didHighlightHandler) holoRow.didHighlightHandler(holoRow.model);
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:didUnhighlightRowAtIndexPath:)]) {
        [self.holo_delegate tableView:tableView didUnhighlightRowAtIndexPath:indexPath];
    }
    
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    if (holoRow.didUnHighlightHandler) holoRow.didUnHighlightHandler(holoRow.model);
}

#pragma mark header and footer
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [self.holo_delegate tableView:tableView viewForHeaderInSection:section];
    }
    
    HoloTableSection *holoSection = self.holoSections[section];
    UIView *holoHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:holoSection.header];
    if (holoSection.headerFooterConfigSEL && [holoHeaderView respondsToSelector:holoSection.headerFooterConfigSEL]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [holoHeaderView performSelector:holoSection.headerFooterConfigSEL withObject:holoSection.headerModel];
#pragma clang diagnostic pop
    }
    if (!holoHeaderView && [self.holo_dataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        NSString *title = [self.holo_dataSource tableView:tableView titleForHeaderInSection:section];
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
        headerView.textLabel.font = [UIFont boldSystemFontOfSize:17.0];
        headerView.textLabel.textColor = [UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1];
        headerView.textLabel.text = title;
        return headerView;
    }
    return holoHeaderView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        return [self.holo_delegate tableView:tableView viewForFooterInSection:section];
    }
    
    HoloTableSection *holoSection = self.holoSections[section];
    UIView *holoFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:holoSection.footer];
    if (holoSection.headerFooterConfigSEL && [holoFooterView respondsToSelector:holoSection.headerFooterConfigSEL]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [holoFooterView performSelector:holoSection.headerFooterConfigSEL withObject:holoSection.footerModel];
#pragma clang diagnostic pop
    }
    if (!holoFooterView && [self.holo_dataSource respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
        NSString *title = [self.holo_dataSource tableView:tableView titleForFooterInSection:section];
        UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
        footerView.textLabel.font = [UIFont boldSystemFontOfSize:17.0];
        footerView.textLabel.textColor = [UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1];
        footerView.textLabel.text = title;
        return footerView;
    }
    return holoFooterView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return [self.holo_delegate tableView:tableView heightForHeaderInSection:section];
    }
    if (section >= self.holoSections.count) return CGFLOAT_MIN;
    
    HoloTableSection *holoSection = self.holoSections[section];
    Class header = NSClassFromString(holoSection.header);
    if (holoSection.headerFooterHeightSEL && [header respondsToSelector:holoSection.headerFooterHeightSEL]) {
        return [self _heightWithMethodSignatureCls:header selector:holoSection.headerFooterHeightSEL model:holoSection.headerModel];
    }
    if ((holoSection.headerHeight == CGFLOAT_MIN) && [self.holo_dataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        return 28.0;
    }
    return holoSection.headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        return [self.holo_delegate tableView:tableView heightForFooterInSection:section];
    }
    if (section >= self.holoSections.count) return CGFLOAT_MIN;
    
    HoloTableSection *holoSection = self.holoSections[section];
    Class footer = NSClassFromString(holoSection.footer);
    if (holoSection.headerFooterHeightSEL && [footer respondsToSelector:holoSection.headerFooterHeightSEL]) {
        return [self _heightWithMethodSignatureCls:footer selector:holoSection.headerFooterHeightSEL model:holoSection.footerModel];
    }
    if ((holoSection.footerHeight == CGFLOAT_MIN) && [self.holo_dataSource respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
        return 28.0;
    }
    return holoSection.footerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:estimatedHeightForHeaderInSection:)]) {
        return [self.holo_delegate tableView:tableView estimatedHeightForHeaderInSection:section];
    }
    
    HoloTableSection *holoSection = self.holoSections[section];
    Class header = NSClassFromString(holoSection.header);
    if (holoSection.headerFooterEstimatedHeightSEL && [header respondsToSelector:holoSection.headerFooterEstimatedHeightSEL]) {
        return [self _heightWithMethodSignatureCls:header selector:holoSection.headerFooterEstimatedHeightSEL model:holoSection.headerModel];
    }
    return holoSection.headerEstimatedHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:estimatedHeightForFooterInSection:)]) {
        return [self.holo_delegate tableView:tableView estimatedHeightForFooterInSection:section];
    }
    
    HoloTableSection *holoSection = self.holoSections[section];
    Class footer = NSClassFromString(holoSection.footer);
    if (holoSection.headerFooterEstimatedHeightSEL && [footer respondsToSelector:holoSection.headerFooterEstimatedHeightSEL]) {
        return [self _heightWithMethodSignatureCls:footer selector:holoSection.headerFooterEstimatedHeightSEL model:holoSection.footerModel];
    }
    return holoSection.footerEstimatedHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)]) {
        [self.holo_delegate tableView:tableView willDisplayHeaderView:view forSection:section];
    }
    
    HoloTableSection *holoSection = self.holoSections[section];
    if (holoSection.willDisplayHeaderHandler) holoSection.willDisplayHeaderHandler(view, holoSection.headerModel);
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:willDisplayFooterView:forSection:)]) {
        [self.holo_delegate tableView:tableView willDisplayFooterView:view forSection:section];
    }
    
    HoloTableSection *holoSection = self.holoSections[section];
    if (holoSection.willDisplayFooterHandler) holoSection.willDisplayFooterHandler(view, holoSection.footerModel);
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)]) {
        [self.holo_delegate tableView:tableView didEndDisplayingHeaderView:view forSection:section];
    }
    
    HoloTableSection *holoSection = self.holoSections[section];
    if (holoSection.didEndDisplayingHeaderHandler) holoSection.didEndDisplayingHeaderHandler(view, holoSection.headerModel);
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)]) {
        [self.holo_delegate tableView:tableView didEndDisplayingFooterView:view forSection:section];
    }
    
    HoloTableSection *holoSection = self.holoSections[section];
    if (holoSection.didEndDisplayingFooterHandler) holoSection.didEndDisplayingFooterHandler(view, holoSection.footerModel);
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)]) {
        [self.holo_delegate tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
    
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    if (holoRow.accessoryHandler) holoRow.accessoryHandler(holoRow.model);
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
        return [self.holo_delegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    return holoRow.editingStyle;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
        return [self.holo_delegate tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    return holoRow.editingDeleteTitle;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:editActionsForRowAtIndexPath:)]) {
        return [self.holo_delegate tableView:tableView editActionsForRowAtIndexPath:indexPath];
    }
    
    NSMutableArray *array = [NSMutableArray new];
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    if (holoRow.trailingSwipeActions.count <= 0) return nil;

    for (id object in holoRow.trailingSwipeActions) {
        NSString *title = [object valueForKey:kHoloSwipActionTitle];
        NSInteger style = [[object valueForKey:kHoloSwipActionStyle] integerValue];
        UIColor *backgroundColor = [object valueForKey:kHoloSwipActionBackgroundColor];
        UIVisualEffect *backgroundEffect = [object valueForKey:kHoloSwipActionBackgroundEffect];
        HoloTableViewRowSwipeActionHandler handler = [object valueForKey:kHoloSwipActionHandler];
        NSInteger index = [holoRow.trailingSwipeActions indexOfObject:object];
        
        UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:!style title:title handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            if (handler) {
                handler(object, index, ^(BOOL actionPerformed) {
                    if (style == HoloTableViewRowSwipeActionStyleDestructive && actionPerformed) {
                        // must remove the data before deleting the cell
                        [holoSection holo_removeRow:holoRow];
                        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }
                });
            }
            if (holoRow.trailingSwipeHandler) {
                holoRow.trailingSwipeHandler(object, index, ^(BOOL actionPerformed) {
                    if (style == HoloTableViewRowSwipeActionStyleDestructive && actionPerformed) {
                        // must remove the data before deleting the cell
                        [holoSection holo_removeRow:holoRow];
                        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }
                });
            }
        }];
        if (backgroundColor) action.backgroundColor = backgroundColor;
        if (backgroundEffect) action.backgroundEffect = backgroundEffect;
        
        [array addObject:action];
    }
    return [array copy];
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos) {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:leadingSwipeActionsConfigurationForRowAtIndexPath:)]) {
        return [self.holo_delegate tableView:tableView leadingSwipeActionsConfigurationForRowAtIndexPath:indexPath];
    }
    
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    return [self _tableView:tableView swipeActionsConfigurationWithIndexPath:indexPath swipeActions:holoRow.leadingSwipeActions swipeHandler:holoRow.leadingSwipeHandler];
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos) {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:trailingSwipeActionsConfigurationForRowAtIndexPath:)]) {
        return [self.holo_delegate tableView:tableView trailingSwipeActionsConfigurationForRowAtIndexPath:indexPath];
    }
    
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    return [self _tableView:tableView swipeActionsConfigurationWithIndexPath:indexPath swipeActions:holoRow.trailingSwipeActions swipeHandler:holoRow.trailingSwipeHandler];
}

- (UISwipeActionsConfiguration *)_tableView:(UITableView *)tableView swipeActionsConfigurationWithIndexPath:(NSIndexPath *)indexPath swipeActions:(NSArray *)swipeActions swipeHandler:(HoloTableViewRowSwipeActionHandler)swipeHandler API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos) {
    
    if (swipeActions.count <= 0) return nil;
    
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    
    NSMutableArray *array = [NSMutableArray new];
    for (id object in swipeActions) {
        NSString *title = [object valueForKey:kHoloSwipActionTitle];
        NSInteger style = [[object valueForKey:kHoloSwipActionStyle] integerValue];
        UIColor *backgroundColor = [object valueForKey:kHoloSwipActionBackgroundColor];
        UIImage *image = [object valueForKey:kHoloSwipActionImage];
        HoloTableViewRowSwipeActionHandler swipeActionHandler = [object valueForKey:kHoloSwipActionHandler];
        NSInteger index = [swipeActions indexOfObject:object];
        
        UIContextualAction *action = [UIContextualAction contextualActionWithStyle:style title:title handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            if (swipeActionHandler) {
                swipeActionHandler(object, index, ^(BOOL actionPerformed) {
                    completionHandler(actionPerformed);
                    if (style == UIContextualActionStyleDestructive && actionPerformed) {
                        [holoSection holo_removeRow:holoRow];
                        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }
                });
            }
            if (swipeHandler) {
                swipeHandler(object, index, ^(BOOL actionPerformed) {
                    completionHandler(actionPerformed);
                    if (style == UIContextualActionStyleDestructive && actionPerformed) {
                        [holoSection holo_removeRow:holoRow];
                        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }
                });
            }
        }];
        if (backgroundColor) action.backgroundColor = backgroundColor;
        if (image) action.image = image;
        
        [array addObject:action];
    }
    UISwipeActionsConfiguration *configuration = [UISwipeActionsConfiguration configurationWithActions:[array copy]];
    return configuration;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)]) {
        [self.holo_delegate tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
    }
    
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    if (holoRow.willBeginSwipingHandler) holoRow.willBeginSwipingHandler(holoRow.model);
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)]) {
        [self.holo_delegate tableView:tableView didEndEditingRowAtIndexPath:indexPath];
    }
    
    if (indexPath.section >= self.holoSections.count) return;
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    if (indexPath.row >= holoSection.rows.count) return;
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    if (holoRow.didEndSwipingHandler) holoRow.didEndSwipingHandler(holoRow.model);
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:)]) {
        return [self.holo_delegate tableView:tableView targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath toProposedIndexPath:proposedDestinationIndexPath];
    }
    
    HoloTableSection *holoSection = self.holoSections[sourceIndexPath.section];
    HoloTableRow *holoRow = holoSection.rows[sourceIndexPath.row];
    if (holoRow.targetMoveHandler) {
        return holoRow.targetMoveHandler(sourceIndexPath, proposedDestinationIndexPath);
    }
    return proposedDestinationIndexPath;
}

#pragma mark override delegate
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:shouldIndentWhileEditingRowAtIndexPath:)]) {
        return [self.holo_delegate tableView:tableView shouldIndentWhileEditingRowAtIndexPath:indexPath];
    }
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:indentationLevelForRowAtIndexPath:)]) {
        return [self.holo_delegate tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
    }
    return 0;
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:shouldShowMenuForRowAtIndexPath:)]) {
        return [self.holo_delegate tableView:tableView shouldShowMenuForRowAtIndexPath:indexPath];
    }
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:canPerformAction:forRowAtIndexPath:withSender:)]) {
        return [self.holo_delegate tableView:tableView canPerformAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:performAction:forRowAtIndexPath:withSender:)]) {
        [self.holo_delegate tableView:tableView performAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
}

- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0) {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:canFocusRowAtIndexPath:)]) {
        return [self.holo_delegate tableView:tableView canFocusRowAtIndexPath:indexPath];
    }
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context NS_AVAILABLE_IOS(9_0) {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:shouldUpdateFocusInContext:)]) {
        return [self.holo_delegate tableView:tableView shouldUpdateFocusInContext:context];
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator NS_AVAILABLE_IOS(9_0) {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:didUpdateFocusInContext:withAnimationCoordinator:)]) {
        [self.holo_delegate tableView:tableView didUpdateFocusInContext:context withAnimationCoordinator:coordinator];
    }
}

- (NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView NS_AVAILABLE_IOS(9_0) {
    if ([self.holo_delegate respondsToSelector:@selector(indexPathForPreferredFocusedViewInTableView:)]) {
        return [self.holo_delegate indexPathForPreferredFocusedViewInTableView:tableView];
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView shouldSpringLoadRowAtIndexPath:(NSIndexPath *)indexPath withContext:(id<UISpringLoadedInteractionContext>)context API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos, watchos) {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:shouldSpringLoadRowAtIndexPath:withContext:)]) {
        return [self.holo_delegate tableView:tableView shouldSpringLoadRowAtIndexPath:indexPath withContext:context];
    }
    return YES;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.holo_scrollDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.holo_scrollDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if ([self.holo_scrollDelegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [self.holo_scrollDelegate scrollViewDidZoom:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.holo_scrollDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.holo_scrollDelegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ([self.holo_scrollDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.holo_scrollDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.holo_scrollDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.holo_scrollDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if ([self.holo_scrollDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.holo_scrollDelegate scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.holo_scrollDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.holo_scrollDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if ([self.holo_scrollDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.holo_scrollDelegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if ([self.holo_scrollDelegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        return [self.holo_scrollDelegate viewForZoomingInScrollView:scrollView];
    }
    return nil;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    if ([self.holo_scrollDelegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [self.holo_scrollDelegate scrollViewWillBeginZooming:scrollView withView:view];
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    if ([self.holo_scrollDelegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [self.holo_scrollDelegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    if ([self.holo_scrollDelegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        return [self.holo_scrollDelegate scrollViewShouldScrollToTop:scrollView];
    }
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if ([self.holo_scrollDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.holo_scrollDelegate scrollViewDidScrollToTop:scrollView];
    }
}

- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView API_AVAILABLE(ios(11.0), tvos(11.0)) {
    if ([self.holo_scrollDelegate respondsToSelector:@selector(scrollViewDidChangeAdjustedContentInset:)]) {
        [self.holo_scrollDelegate scrollViewDidChangeAdjustedContentInset:scrollView];
    }
}

#pragma mark - getter
- (HoloTableViewProxyData *)holo_proxyData {
    if (!_holo_proxyData) {
        _holo_proxyData = [HoloTableViewProxyData new];
    }
    return _holo_proxyData;
}

- (NSArray<HoloTableSection *> *)holoSections {
    return self.holo_proxyData.holo_sections;
}

- (NSDictionary<NSString *, Class> *)holoCellClsMap {
    return self.holo_proxyData.holo_cellClsMap;
}

@end
