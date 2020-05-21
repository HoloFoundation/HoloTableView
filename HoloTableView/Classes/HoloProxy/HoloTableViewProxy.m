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

static HoloTableViewProxy *kProxySelf;

@interface HoloTableViewProxy ()

@property (nonatomic, copy, readonly) NSArray<HoloTableSection *> *holoSections;

@property (nonatomic, copy, readonly) NSDictionary<NSString *, Class> *holoRowsMap;

@property (nonatomic, copy, readonly) NSDictionary<NSString *, Class> *holoHeadersMap;

@property (nonatomic, copy, readonly) NSDictionary<NSString *, Class> *holoFootersMap;

@end

@implementation HoloTableViewProxy

- (instancetype)init {
    self = [super init];
    if (self) {
        kProxySelf = self;
    }
    return self;
}

static CGFloat HoloProxyAPIFloatResultWithMethodSignatureCls(Class cls, SEL selector, id model) {
    NSMethodSignature *signature = [cls methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = cls;
    invocation.selector = selector;
    [invocation setArgument:&model atIndex:2];
    [invocation invoke];
    
    CGFloat retLoc;
    [invocation getReturnValue:&retLoc];
    return retLoc;
}

static BOOL HoloProxyAPIBOOLResultWithMethodSignatureCls(Class cls, SEL selector, id model) {
    NSMethodSignature *signature = [cls methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = cls;
    invocation.selector = selector;
    [invocation setArgument:&model atIndex:2];
    [invocation invoke];
    
    BOOL retLoc;
    [invocation getReturnValue:&retLoc];
    return retLoc;
}

static UITableViewCellEditingStyle HoloProxyAPIEditingStyleResultWithMethodSignatureCls(Class cls, SEL selector, id model) {
    NSMethodSignature *signature = [cls methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = cls;
    invocation.selector = selector;
    [invocation setArgument:&model atIndex:2];
    [invocation invoke];
    
    UITableViewCellEditingStyle retLoc;
    [invocation getReturnValue:&retLoc];
    return retLoc;
}

static HoloTableRow *HoloTableRowWithIndexPath(NSIndexPath *indexPath) {
    if (indexPath.section >= kProxySelf.proxyData.sections.count) return nil;
    HoloTableSection *holoSection = kProxySelf.proxyData.sections[indexPath.section];
    
    if (indexPath.row >= holoSection.rows.count) return nil;
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    
    return holoRow;
}

static CGFloat HoloProxyAPIFloatResult(HoloTableRow *row, SEL sel, CGFloat (^handler)(id), CGFloat height) {
    if (!row) return CGFLOAT_MIN;
    
    Class cls = kProxySelf.proxyData.rowsMap[row.cell];
    if (sel && [cls respondsToSelector:sel]) {
        return HoloProxyAPIFloatResultWithMethodSignatureCls(cls, sel, row.model);
    } else if (handler) {
        return handler(row.model);
    }
    return height;
}

static BOOL HoloProxyAPIBOOLResult(HoloTableRow *row, SEL sel, BOOL (^handler)(id), BOOL can) {
    if (!row) return NO;
    
    Class cls = kProxySelf.proxyData.rowsMap[row.cell];
    if (sel && [cls respondsToSelector:sel]) {
        return HoloProxyAPIBOOLResultWithMethodSignatureCls(cls, sel, row.model);
    } else if (handler) {
        return handler(row.model);
    }
    return can;
}

static UITableViewCellEditingStyle HoloProxyAPIEditingStyleResult(HoloTableRow *row, SEL sel, UITableViewCellEditingStyle (^handler)(id), UITableViewCellEditingStyle editingStyle) {
    if (!row) return UITableViewCellEditingStyleNone;
    
    Class cls = kProxySelf.proxyData.rowsMap[row.cell];
    if (sel && [cls respondsToSelector:sel]) {
        return HoloProxyAPIEditingStyleResultWithMethodSignatureCls(cls, sel, row.model);
    } else if (handler) {
        return handler(row.model);
    }
    return editingStyle;
}

static void HoloProxyAPIPerformWithCell(HoloTableRow *row, SEL sel, void (^handler)(UITableViewCell *, id), UITableViewCell *cell) {
    if (!row) return;
    
    Class cls = kProxySelf.proxyData.rowsMap[row.cell];
    if (sel && [cls respondsToSelector:sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [cls performSelector:sel withObject:cell withObject:row.model];
#pragma clang diagnostic pop
    } else if (row.willDisplayHandler) {
        handler(cell, row.model);
    }
}

static void HoloProxyAPIPerform(HoloTableRow *row, SEL sel, void (^handler)(id)) {
    if (!row) return;
    
    Class cls = kProxySelf.proxyData.rowsMap[row.cell];
    if (sel && [cls respondsToSelector:sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [cls performSelector:sel withObject:row.model];
#pragma clang diagnostic pop
    } else if (row.willDisplayHandler) {
        handler(row.model);
    }
}

static NSString *HoloProxyAPIStringPerform(HoloTableRow *row, SEL sel, NSString *(^handler)(id), NSString *string) {
    if (!row) return nil;
    
    Class cls = kProxySelf.proxyData.rowsMap[row.cell];
    if (sel && [cls respondsToSelector:sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [cls performSelector:sel withObject:row.model];
#pragma clang diagnostic pop
    } else if (row.willDisplayHandler) {
        return handler(row.model);
    }
    return string;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [self.dataSource numberOfSectionsInTableView:tableView];
    }
    
    return self.holoSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        return [self.dataSource tableView:tableView numberOfRowsInSection:section];
    }
    if (section >= self.holoSections.count) return 0;
    
    HoloTableSection *holoSection = self.holoSections[section];
    return holoSection.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        return [self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    
    if (holoRow.modelHandler) holoRow.model = holoRow.modelHandler();
    if (holoRow.reuseIdHandler) holoRow.reuseId = holoRow.reuseIdHandler(holoRow.model);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:holoRow.reuseId];
    if (!cell) {
        Class cls = self.holoRowsMap[holoRow.cell];
        if (!cls) cls = UITableViewCell.class;
        if (holoRow.styleHandler) holoRow.style = holoRow.styleHandler(holoRow.model);
        cell = [[cls alloc] initWithStyle:holoRow.style reuseIdentifier:holoRow.reuseId];
    }
    
    if (holoRow.configSEL && [cell respondsToSelector:holoRow.configSEL]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [cell performSelector:holoRow.configSEL withObject:holoRow.model];
#pragma clang diagnostic pop
    }
    
    // support set a delegate for cell
    if (holoRow.delegateSEL && [cell respondsToSelector:holoRow.delegateSEL]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [cell performSelector:holoRow.delegateSEL withObject:holoRow.delegate];
#pragma clang diagnostic pop
    }
    return cell;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if ([self.dataSource respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
        return [self.dataSource sectionIndexTitlesForTableView:tableView];
    }
    
    return self.proxyData.sectionIndexTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if ([self.dataSource respondsToSelector:@selector(tableView:sectionForSectionIndexTitle:atIndex:)]) {
        return [self.dataSource tableView:tableView sectionForSectionIndexTitle:title atIndex:index];
    }
    
    if (self.proxyData.sectionForSectionIndexTitleHandler) {
        return self.proxyData.sectionForSectionIndexTitleHandler(title, index);
    }
    return index;
}

/// Editing
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataSource respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
        return [self.dataSource tableView:tableView canEditRowAtIndexPath:indexPath];
    }
    
    HoloTableRow *holoRow = HoloTableRowWithIndexPath(indexPath);
    return HoloProxyAPIBOOLResult(holoRow, holoRow.canEditSEL, holoRow.canEditHandler, holoRow.canEdit);
}

/// Editing: delete/insert
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataSource respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        [self.dataSource tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
        return;
    }
    
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (holoRow.editingDeleteHandler) {
            holoRow.editingDeleteHandler(holoRow.model, ^(BOOL actionPerformed) {
                // must remove the data before deleting the cell
                [holoSection removeRow:holoRow];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            });
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        if (holoRow.editingInsertHandler) holoRow.editingInsertHandler(holoRow.model);
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataSource respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)]) {
        return [self.dataSource tableView:tableView canMoveRowAtIndexPath:indexPath];
    }
    
    HoloTableRow *holoRow = HoloTableRowWithIndexPath(indexPath);
    return HoloProxyAPIBOOLResult(holoRow, holoRow.canMoveSEL, holoRow.canMoveHandler, holoRow.canMove);
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if ([self.dataSource respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)]) {
        [self.dataSource tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
        return;
    }
    
    HoloTableSection *sourceSection = self.holoSections[sourceIndexPath.section];
    HoloTableRow *sourceRow = sourceSection.rows[sourceIndexPath.row];
    if (sourceRow.moveHandler) {
        sourceRow.moveHandler(sourceIndexPath, destinationIndexPath, ^(BOOL actionPerformed) {
            if (actionPerformed) {
                HoloTableSection *destinationSection = self.holoSections[destinationIndexPath.section];
                [sourceSection removeRow:sourceRow];
                [destinationSection insertRows:@[sourceRow] atIndex:destinationIndexPath.row];
            }
        });
    }
}

// support these two methods with viewForHeaderInSection: and viewForFooterInSection:
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    
    HoloTableRow *holoRow = HoloTableRowWithIndexPath(indexPath);
    return HoloProxyAPIFloatResult(holoRow, holoRow.heightSEL, holoRow.heightHandler, holoRow.height);
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
    }
    
    HoloTableRow *holoRow = HoloTableRowWithIndexPath(indexPath);
    CGFloat estimatedHeight = HoloProxyAPIFloatResult(holoRow, holoRow.estimatedHeightSEL, holoRow.estimatedHeightHandler, holoRow.height);
    
    // If you don't plan to use the cell estimation function, you will default to the tableView:heightForRowAtIndexPath: method
    if (estimatedHeight == CGFLOAT_MIN) {
        return [self tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return estimatedHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.delegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
        return;
    }
    
    HoloTableRow *holoRow = HoloTableRowWithIndexPath(indexPath);
    HoloProxyAPIPerformWithCell(holoRow, holoRow.willDisplaySEL, holoRow.willDisplayHandler, cell);
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
        return;
    }
    
    HoloTableRow *holoRow = HoloTableRowWithIndexPath(indexPath);
    HoloProxyAPIPerformWithCell(holoRow, holoRow.didEndDisplayingSEL, holoRow.didEndDisplayingHandler, cell);
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView willSelectRowAtIndexPath:indexPath];
    }
    
    HoloTableRow *holoRow = HoloTableRowWithIndexPath(indexPath);
    HoloProxyAPIPerform(holoRow, holoRow.willSelectSEL, holoRow.willSelectHandler);
    
    return indexPath;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:willDeselectRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView willDeselectRowAtIndexPath:indexPath];
    }
    
    HoloTableRow *holoRow = HoloTableRowWithIndexPath(indexPath);
    HoloProxyAPIPerform(holoRow, holoRow.willDeselectSEL, holoRow.willDeselectHandler);
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
        return;
    }
    
    HoloTableRow *holoRow = HoloTableRowWithIndexPath(indexPath);
    HoloProxyAPIPerform(holoRow, holoRow.didDeselectSEL, holoRow.didDeselectHandler);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
        return;
    }
    
    HoloTableRow *holoRow = HoloTableRowWithIndexPath(indexPath);
    HoloProxyAPIPerform(holoRow, holoRow.didSelectSEL, holoRow.didSelectHandler);
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:shouldHighlightRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView shouldHighlightRowAtIndexPath:indexPath];
    }
    
    HoloTableRow *holoRow = HoloTableRowWithIndexPath(indexPath);
    return HoloProxyAPIBOOLResult(holoRow, holoRow.shouldHighlightSEL, holoRow.shouldHighlightHandler, holoRow.shouldHighlight);
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:didHighlightRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didHighlightRowAtIndexPath:indexPath];
        return;
    }
    
    HoloTableRow *holoRow = HoloTableRowWithIndexPath(indexPath);
    HoloProxyAPIPerform(holoRow, holoRow.didHighlightSEL, holoRow.didHighlightHandler);
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:didUnhighlightRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didUnhighlightRowAtIndexPath:indexPath];
        return;
    }
    
    HoloTableRow *holoRow = HoloTableRowWithIndexPath(indexPath);
    HoloProxyAPIPerform(holoRow, holoRow.didUnHighlightSEL, holoRow.didUnHighlightHandler);
}

#pragma mark header and footer
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [self.delegate tableView:tableView viewForHeaderInSection:section];
    }
    
    HoloTableSection *holoSection = self.holoSections[section];
    UIView *holoHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:holoSection.header];
    
    if (holoSection.headerConfigSEL && [holoHeaderView respondsToSelector:holoSection.headerConfigSEL]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [holoHeaderView performSelector:holoSection.headerConfigSEL withObject:holoSection.headerModel];
#pragma clang diagnostic pop
    } else if (holoSection.headerFooterConfigSEL && [holoHeaderView respondsToSelector:holoSection.headerFooterConfigSEL]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [holoHeaderView performSelector:holoSection.headerFooterConfigSEL withObject:holoSection.headerModel];
#pragma clang diagnostic pop
    }
    if (!holoHeaderView && [self.dataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        NSString *title = [self.dataSource tableView:tableView titleForHeaderInSection:section];
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
        headerView.textLabel.font = [UIFont boldSystemFontOfSize:17.0];
        headerView.textLabel.textColor = [UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1];
        headerView.textLabel.text = title;
        return headerView;
    }
    return holoHeaderView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        return [self.delegate tableView:tableView viewForFooterInSection:section];
    }
    
    HoloTableSection *holoSection = self.holoSections[section];
    UIView *holoFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:holoSection.footer];
    if (holoSection.footerConfigSEL && [holoFooterView respondsToSelector:holoSection.footerConfigSEL]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [holoFooterView performSelector:holoSection.footerConfigSEL withObject:holoSection.footerModel];
#pragma clang diagnostic pop
    }
    if (holoSection.headerFooterConfigSEL && [holoFooterView respondsToSelector:holoSection.headerFooterConfigSEL]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [holoFooterView performSelector:holoSection.headerFooterConfigSEL withObject:holoSection.footerModel];
#pragma clang diagnostic pop
    }
    if (!holoFooterView && [self.dataSource respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
        NSString *title = [self.dataSource tableView:tableView titleForFooterInSection:section];
        UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
        footerView.textLabel.font = [UIFont boldSystemFontOfSize:17.0];
        footerView.textLabel.textColor = [UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1];
        footerView.textLabel.text = title;
        return footerView;
    }
    return holoFooterView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return [self.delegate tableView:tableView heightForHeaderInSection:section];
    }
    if (section >= self.holoSections.count) return CGFLOAT_MIN;
    
    HoloTableSection *holoSection = self.holoSections[section];
    Class header = self.holoHeadersMap[holoSection.header];
    if (holoSection.headerHeightSEL && [header respondsToSelector:holoSection.headerHeightSEL]) {
        return HoloProxyAPIFloatResultWithMethodSignatureCls(header, holoSection.headerHeightSEL, holoSection.headerModel);
    } else if (holoSection.headerFooterHeightSEL && [header respondsToSelector:holoSection.headerFooterHeightSEL]) {
        return HoloProxyAPIFloatResultWithMethodSignatureCls(header, holoSection.headerFooterHeightSEL, holoSection.headerModel);
    }
    if ((holoSection.headerHeight == CGFLOAT_MIN) && [self.dataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        return 28.0;
    }
    return holoSection.headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        return [self.delegate tableView:tableView heightForFooterInSection:section];
    }
    if (section >= self.holoSections.count) return CGFLOAT_MIN;
    
    HoloTableSection *holoSection = self.holoSections[section];
    Class footer = self.holoFootersMap[holoSection.footer];
    if (holoSection.footerHeightSEL && [footer respondsToSelector:holoSection.footerHeightSEL]) {
        return HoloProxyAPIFloatResultWithMethodSignatureCls(footer, holoSection.footerHeightSEL, holoSection.footerModel);
    } else if (holoSection.headerFooterHeightSEL && [footer respondsToSelector:holoSection.headerFooterHeightSEL]) {
        return HoloProxyAPIFloatResultWithMethodSignatureCls(footer, holoSection.headerFooterHeightSEL, holoSection.footerModel);
    }
    if ((holoSection.footerHeight == CGFLOAT_MIN) && [self.dataSource respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
        return 28.0;
    }
    return holoSection.footerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:estimatedHeightForHeaderInSection:)]) {
        return [self.delegate tableView:tableView estimatedHeightForHeaderInSection:section];
    }
    
    HoloTableSection *holoSection = self.holoSections[section];
    Class header = self.holoHeadersMap[holoSection.header];
    if (holoSection.headerEstimatedHeightSEL && [header respondsToSelector:holoSection.headerEstimatedHeightSEL]) {
        return HoloProxyAPIFloatResultWithMethodSignatureCls(header, holoSection.headerEstimatedHeightSEL, holoSection.headerModel);
    } else if (holoSection.headerFooterEstimatedHeightSEL && [header respondsToSelector:holoSection.headerFooterEstimatedHeightSEL]) {
        return HoloProxyAPIFloatResultWithMethodSignatureCls(header, holoSection.headerFooterEstimatedHeightSEL, holoSection.headerModel);
    }
    
    // If you don't plan to use the header estimation function, you will default to the tableView:heightForHeaderInSection: method
    if (holoSection.headerEstimatedHeight == CGFLOAT_MIN) {
        return [self tableView:tableView heightForHeaderInSection:section];
    }
    return holoSection.headerEstimatedHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:estimatedHeightForFooterInSection:)]) {
        return [self.delegate tableView:tableView estimatedHeightForFooterInSection:section];
    }
    
    HoloTableSection *holoSection = self.holoSections[section];
    Class footer = self.holoFootersMap[holoSection.footer];
    if (holoSection.footerEstimatedHeightSEL && [footer respondsToSelector:holoSection.footerEstimatedHeightSEL]) {
        return HoloProxyAPIFloatResultWithMethodSignatureCls(footer, holoSection.footerEstimatedHeightSEL, holoSection.footerModel);
    } else if (holoSection.headerFooterEstimatedHeightSEL && [footer respondsToSelector:holoSection.headerFooterEstimatedHeightSEL]) {
        return HoloProxyAPIFloatResultWithMethodSignatureCls(footer, holoSection.headerFooterEstimatedHeightSEL, holoSection.footerModel);
    }
    
    // If you don't plan to use the footer estimation function, you will default to the tableView:heightForFooterInSection: method
    if (holoSection.footerEstimatedHeight == CGFLOAT_MIN) {
        return [self tableView:tableView heightForFooterInSection:section];
    }
    return holoSection.footerEstimatedHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)]) {
        [self.delegate tableView:tableView willDisplayHeaderView:view forSection:section];
        return;
    }
    
    HoloTableSection *holoSection = self.holoSections[section];
    if (holoSection.willDisplayHeaderHandler) holoSection.willDisplayHeaderHandler(view, holoSection.headerModel);
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:willDisplayFooterView:forSection:)]) {
        [self.delegate tableView:tableView willDisplayFooterView:view forSection:section];
        return;
    }
    
    HoloTableSection *holoSection = self.holoSections[section];
    if (holoSection.willDisplayFooterHandler) holoSection.willDisplayFooterHandler(view, holoSection.footerModel);
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)]) {
        [self.delegate tableView:tableView didEndDisplayingHeaderView:view forSection:section];
        return;
    }
    
    HoloTableSection *holoSection = self.holoSections[section];
    if (holoSection.didEndDisplayingHeaderHandler) holoSection.didEndDisplayingHeaderHandler(view, holoSection.headerModel);
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)]) {
        [self.delegate tableView:tableView didEndDisplayingFooterView:view forSection:section];
        return;
    }
    
    HoloTableSection *holoSection = self.holoSections[section];
    if (holoSection.didEndDisplayingFooterHandler) holoSection.didEndDisplayingFooterHandler(view, holoSection.footerModel);
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)]) {
        [self.delegate tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
        return;
    }
    
    HoloTableRow *holoRow = HoloTableRowWithIndexPath(indexPath);
    HoloProxyAPIPerform(holoRow, holoRow.accessorySEL, holoRow.accessoryHandler);
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    
    HoloTableRow *holoRow = HoloTableRowWithIndexPath(indexPath);
    return HoloProxyAPIEditingStyleResult(holoRow, holoRow.editingStyleSEL, holoRow.editingStyleHandler, holoRow.editingStyle);
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    
    HoloTableRow *holoRow = HoloTableRowWithIndexPath(indexPath);
    return HoloProxyAPIStringPerform(holoRow, holoRow.editingDeleteTitleSEL, holoRow.editingDeleteTitleHandler, holoRow.editingDeleteTitle);
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:editActionsForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView editActionsForRowAtIndexPath:indexPath];
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
                        [holoSection removeRow:holoRow];
                        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }
                });
            }
            if (holoRow.trailingSwipeHandler) {
                holoRow.trailingSwipeHandler(object, index, ^(BOOL actionPerformed) {
                    if (style == HoloTableViewRowSwipeActionStyleDestructive && actionPerformed) {
                        // must remove the data before deleting the cell
                        [holoSection removeRow:holoRow];
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
    if ([self.delegate respondsToSelector:@selector(tableView:leadingSwipeActionsConfigurationForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView leadingSwipeActionsConfigurationForRowAtIndexPath:indexPath];
    }
    
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    
    NSArray *leadingSwipeActions;
    Class cls = self.holoRowsMap[holoRow.cell];
    if (holoRow.leadingSwipeActionsSEL && [cls respondsToSelector:holoRow.leadingSwipeActionsSEL]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        leadingSwipeActions = [cls performSelector:holoRow.leadingSwipeActionsSEL withObject:holoRow.model];
#pragma clang diagnostic pop
    } else if (holoRow.leadingSwipeActionsHandler) {
        leadingSwipeActions = holoRow.leadingSwipeActionsHandler(holoRow.model);
    } else {
        leadingSwipeActions = holoRow.leadingSwipeActions;
    }
    return [self _tableView:tableView swipeActionsConfigurationWithIndexPath:indexPath swipeActions:leadingSwipeActions swipeHandler:holoRow.leadingSwipeHandler];
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos) {
    if ([self.delegate respondsToSelector:@selector(tableView:trailingSwipeActionsConfigurationForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView trailingSwipeActionsConfigurationForRowAtIndexPath:indexPath];
    }
    
    HoloTableSection *holoSection = self.holoSections[indexPath.section];
    HoloTableRow *holoRow = holoSection.rows[indexPath.row];
    
    NSArray *trailingSwipeActions;
    Class cls = self.holoRowsMap[holoRow.cell];
    if (holoRow.trailingSwipeActionsSEL && [cls respondsToSelector:holoRow.trailingSwipeActionsSEL]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        trailingSwipeActions = [cls performSelector:holoRow.trailingSwipeActionsSEL withObject:holoRow.model];
#pragma clang diagnostic pop
    } else if (holoRow.trailingSwipeActionsHandler) {
        trailingSwipeActions = holoRow.trailingSwipeActionsHandler(holoRow.model);
    } else {
        trailingSwipeActions = holoRow.trailingSwipeActions;
    }
    return [self _tableView:tableView swipeActionsConfigurationWithIndexPath:indexPath swipeActions:trailingSwipeActions swipeHandler:holoRow.trailingSwipeHandler];
}

- (UISwipeActionsConfiguration *)_tableView:(UITableView *)tableView
     swipeActionsConfigurationWithIndexPath:(NSIndexPath *)indexPath
                               swipeActions:(NSArray *)swipeActions
                               swipeHandler:(HoloTableViewRowSwipeActionHandler)swipeHandler API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos) {
    
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
                        [holoSection removeRow:holoRow];
                        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }
                });
            }
            if (swipeHandler) {
                swipeHandler(object, index, ^(BOOL actionPerformed) {
                    completionHandler(actionPerformed);
                    if (style == UIContextualActionStyleDestructive && actionPerformed) {
                        [holoSection removeRow:holoRow];
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
    if ([self.delegate respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)]) {
        [self.delegate tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
        return;
    }
    
    HoloTableRow *holoRow = HoloTableRowWithIndexPath(indexPath);
    HoloProxyAPIPerform(holoRow, holoRow.willBeginEditingSEL, holoRow.willBeginEditingHandler);
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didEndEditingRowAtIndexPath:indexPath];
        return;
    }
    
    HoloTableRow *holoRow = HoloTableRowWithIndexPath(indexPath);
    HoloProxyAPIPerform(holoRow, holoRow.didEndEditingSEL, holoRow.didEndEditingHandler);
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:)]) {
        return [self.delegate tableView:tableView targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath toProposedIndexPath:proposedDestinationIndexPath];
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
    if ([self.delegate respondsToSelector:@selector(tableView:shouldIndentWhileEditingRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView shouldIndentWhileEditingRowAtIndexPath:indexPath];
    }
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:indentationLevelForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
    }
    return 0;
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:shouldShowMenuForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView shouldShowMenuForRowAtIndexPath:indexPath];
    }
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    if ([self.delegate respondsToSelector:@selector(tableView:canPerformAction:forRowAtIndexPath:withSender:)]) {
        return [self.delegate tableView:tableView canPerformAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    if ([self.delegate respondsToSelector:@selector(tableView:performAction:forRowAtIndexPath:withSender:)]) {
        [self.delegate tableView:tableView performAction:action forRowAtIndexPath:indexPath withSender:sender];
        return;
    }
}

- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0) {
    if ([self.delegate respondsToSelector:@selector(tableView:canFocusRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView canFocusRowAtIndexPath:indexPath];
    }
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context NS_AVAILABLE_IOS(9_0) {
    if ([self.delegate respondsToSelector:@selector(tableView:shouldUpdateFocusInContext:)]) {
        return [self.delegate tableView:tableView shouldUpdateFocusInContext:context];
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator NS_AVAILABLE_IOS(9_0) {
    if ([self.delegate respondsToSelector:@selector(tableView:didUpdateFocusInContext:withAnimationCoordinator:)]) {
        [self.delegate tableView:tableView didUpdateFocusInContext:context withAnimationCoordinator:coordinator];
        return;
    }
}

- (NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView NS_AVAILABLE_IOS(9_0) {
    if ([self.delegate respondsToSelector:@selector(indexPathForPreferredFocusedViewInTableView:)]) {
        return [self.delegate indexPathForPreferredFocusedViewInTableView:tableView];
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView shouldSpringLoadRowAtIndexPath:(NSIndexPath *)indexPath withContext:(id<UISpringLoadedInteractionContext>)context API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos, watchos) {
    if ([self.delegate respondsToSelector:@selector(tableView:shouldSpringLoadRowAtIndexPath:withContext:)]) {
        return [self.delegate tableView:tableView shouldSpringLoadRowAtIndexPath:indexPath withContext:context];
    }
    return YES;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.scrollDelegate scrollViewDidScroll:scrollView];
        return;
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [self.scrollDelegate scrollViewDidZoom:scrollView];
        return;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.scrollDelegate scrollViewWillBeginDragging:scrollView];
        return;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.scrollDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
        return;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.scrollDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
        return;
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.scrollDelegate scrollViewWillBeginDecelerating:scrollView];
        return;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.scrollDelegate scrollViewDidEndDecelerating:scrollView];
        return;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.scrollDelegate scrollViewDidEndScrollingAnimation:scrollView];
        return;
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if ([self.scrollDelegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        return [self.scrollDelegate viewForZoomingInScrollView:scrollView];
    }
    return nil;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [self.scrollDelegate scrollViewWillBeginZooming:scrollView withView:view];
        return;
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [self.scrollDelegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
        return;
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        return [self.scrollDelegate scrollViewShouldScrollToTop:scrollView];
    }
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.scrollDelegate scrollViewDidScrollToTop:scrollView];
        return;
    }
}

- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView API_AVAILABLE(ios(11.0), tvos(11.0)) {
    if ([self.scrollDelegate respondsToSelector:@selector(scrollViewDidChangeAdjustedContentInset:)]) {
        [self.scrollDelegate scrollViewDidChangeAdjustedContentInset:scrollView];
        return;
    }
}

#pragma mark - getter
- (HoloTableViewProxyData *)proxyData {
    if (!_proxyData) {
        _proxyData = [HoloTableViewProxyData new];
    }
    return _proxyData;
}

- (NSArray<HoloTableSection *> *)holoSections {
    return self.proxyData.sections;
}

- (NSDictionary<NSString *, Class> *)holoRowsMap {
    return self.proxyData.rowsMap;
}

- (NSDictionary<NSString *,Class> *)holoHeadersMap {
    return self.proxyData.headersMap;
}

- (NSDictionary<NSString *,Class> *)holoFootersMap {
    return self.proxyData.footersMap;
}

@end
