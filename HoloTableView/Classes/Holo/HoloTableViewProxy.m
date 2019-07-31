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
#import "HoloTableViewProtocol.h"

@interface HoloTableViewProxy ()

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, copy, readonly) NSArray<HoloSection *> *holoSections;

@property (nonatomic, copy, readonly) NSDictionary *holoCellClsMap;

@end

@implementation HoloTableViewProxy

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        _tableView = tableView;
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.holoSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section >= self.holoSections.count) return 0;
    
    HoloSection *holoSection = self.holoSections[section];
    return holoSection.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HoloSection *holoSection = self.holoSections[indexPath.section];
    HoloRow *holoRow = holoSection.rows[indexPath.row];
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:holoRow.tag forIndexPath:indexPath];
    NSString *clsName = self.holoCellClsMap[holoRow.cell] ?: holoRow.cell;
    NSString *reuseIdentifier = [NSString stringWithFormat:@"HoloTableViewCellReuseIdentifier_%@", clsName];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[NSClassFromString(clsName) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    if (holoRow.configSEL && [cell respondsToSelector:holoRow.configSEL]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [cell performSelector:holoRow.configSEL withObject:holoRow.model];
#pragma clang diagnostic pop
    }
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.holo_proxyData.holo_sectionIndexTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    NSInteger (^ sectionForSectionIndexTitleHandler)(NSArray<NSString *> *, NSString *, NSInteger) = self.holo_proxyData.holo_sectionForSectionIndexTitleHandler;
    if (sectionForSectionIndexTitleHandler) {
        NSInteger targetIndex = sectionForSectionIndexTitleHandler(self.holo_proxyData.holo_sectionIndexTitles, title, index);
        return targetIndex;
    } else {
        return index;
    }
}



//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
//- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_dataSource respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
        return [self.holo_dataSource tableView:tableView canEditRowAtIndexPath:indexPath];
    }
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_dataSource respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)]) {
        return [self.holo_dataSource tableView:tableView canMoveRowAtIndexPath:indexPath];
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_dataSource respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        [self.holo_dataSource tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if ([self.holo_dataSource respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)]) {
        [self.holo_dataSource tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HoloSection *holoSection = self.holoSections[indexPath.section];
    HoloRow *holoRow = holoSection.rows[indexPath.row];
    
    NSString *clsName = self.holoCellClsMap[holoRow.cell] ?: holoRow.cell;
    Class cls = NSClassFromString(clsName);
    if (holoRow.heightSEL && [cls respondsToSelector:holoRow.heightSEL]) {
        return [self _heightWithMethodSignatureCls:cls selector:holoRow.heightSEL model:holoRow.model];
    }
    return holoRow.height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HoloSection *holoSection = self.holoSections[indexPath.section];
    HoloRow *holoRow = holoSection.rows[indexPath.row];

    NSString *clsName = self.holoCellClsMap[holoRow.cell] ?: holoRow.cell;
    Class cls = NSClassFromString(clsName);
    if (holoRow.estimatedHeightSEL && [cls respondsToSelector:holoRow.estimatedHeightSEL]) {
        return [self _heightWithMethodSignatureCls:cls selector:holoRow.estimatedHeightSEL model:holoRow.model];
    }
    return holoRow.estimatedHeight;
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
    HoloSection *holoSection = self.holoSections[indexPath.section];
    HoloRow *holoRow = holoSection.rows[indexPath.row];
    if (holoRow.willDisplayHandler) holoRow.willDisplayHandler(cell);
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section >= self.holoSections.count) return;
    HoloSection *holoSection = self.holoSections[indexPath.section];
    
    if (indexPath.row >= holoSection.rows.count) return;
    HoloRow *holoRow = holoSection.rows[indexPath.row];
    if (holoRow.didEndDisplayingHandler) holoRow.didEndDisplayingHandler(cell);
}

- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HoloSection *holoSection = self.holoSections[indexPath.section];
    HoloRow *holoRow = holoSection.rows[indexPath.row];
    if (holoRow.willSelectHandler) holoRow.willSelectHandler(holoRow.model);
    return indexPath;
}

- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    HoloSection *holoSection = self.holoSections[indexPath.section];
    HoloRow *holoRow = holoSection.rows[indexPath.row];
    if (holoRow.willDeselectHandler) holoRow.willDeselectHandler(holoRow.model);
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    HoloSection *holoSection = self.holoSections[indexPath.section];
    HoloRow *holoRow = holoSection.rows[indexPath.row];
    if (holoRow.didDeselectHandler) holoRow.didDeselectHandler(holoRow.model);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HoloSection *holoSection = self.holoSections[indexPath.section];
    HoloRow *holoRow = holoSection.rows[indexPath.row];
    if (holoRow.didSelectHandler) holoRow.didSelectHandler(holoRow.model);
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:estimatedHeightForHeaderInSection:)]) {
        return [self.holo_delegate tableView:tableView estimatedHeightForHeaderInSection:section];
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:estimatedHeightForFooterInSection:)]) {
        return [self.holo_delegate tableView:tableView estimatedHeightForFooterInSection:section];
    }
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if ([self.holo_delegate respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)]) {
        [self.holo_delegate tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    HoloSection *holoSection = self.holoSections[indexPath.section];
    HoloRow *holoRow = holoSection.rows[indexPath.row];
    return holoRow.shouldHighlight;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    HoloSection *holoSection = self.holoSections[indexPath.section];
    HoloRow *holoRow = holoSection.rows[indexPath.row];
    if (holoRow.didHighlightHandler) holoRow.didHighlightHandler(holoRow.model);
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    HoloSection *holoSection = self.holoSections[indexPath.section];
    HoloRow *holoRow = holoSection.rows[indexPath.row];
    if (holoRow.didUnHighlightHandler) holoRow.didUnHighlightHandler(holoRow.model);
}


#pragma mark - UITableViewDelegate (header and footer)
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HoloSection *holoSection = self.holoSections[section];
    return holoSection.header;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    HoloSection *holoSection = self.holoSections[section];
    return holoSection.footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section >= self.holoSections.count) return 0;
    
    HoloSection *holoSection = self.holoSections[section];
    return holoSection.headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section >= self.holoSections.count) return 0;
    
    HoloSection *holoSection = self.holoSections[section];
    return holoSection.footerHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    HoloSection *holoSection = self.holoSections[section];
    if (holoSection.willDisplayHeaderHandler) holoSection.willDisplayHeaderHandler(view);
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    HoloSection *holoSection = self.holoSections[section];
    if (holoSection.willDisplayFooterHandler) holoSection.willDisplayFooterHandler(view);
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    HoloSection *holoSection = self.holoSections[section];
    if (holoSection.didEndDisplayingHeaderHandler) holoSection.didEndDisplayingHeaderHandler(view);
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    HoloSection *holoSection = self.holoSections[section];
    if (holoSection.didEndDisplayingFooterHandler) holoSection.didEndDisplayingFooterHandler(view);
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

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if ([self.holo_scrollDelegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        return [self.holo_scrollDelegate viewForZoomingInScrollView:scrollView];
    }
    return nil;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view {
    if ([self.holo_scrollDelegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [self.holo_scrollDelegate scrollViewWillBeginZooming:scrollView withView:view];
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
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

- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView {
    if ([self.holo_scrollDelegate respondsToSelector:@selector(scrollViewDidChangeAdjustedContentInset:)]) {
        if (@available(iOS 11.0, *)) {
            [self.holo_scrollDelegate scrollViewDidChangeAdjustedContentInset:scrollView];
        } else {
            // Fallback on earlier versions
        }
    }
}

#pragma mark - getter
- (HoloTableViewProxyData *)holo_proxyData {
    if (!_holo_proxyData) {
        _holo_proxyData = [HoloTableViewProxyData new];
    }
    return _holo_proxyData;
}

- (NSArray<HoloSection *> *)holoSections {
    return self.holo_proxyData.holo_sections;
}

- (NSDictionary *)holoCellClsMap {
    return self.holo_proxyData.holo_cellClsMap;
}

@end
