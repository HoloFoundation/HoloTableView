//
//  HoloTableViewProxy.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import "HoloTableViewProxy.h"
#import "HoloTableViewDataSource.h"
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

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HoloSection *holoSection = self.holoSections[indexPath.section];
    HoloRow *holoRow = holoSection.rows[indexPath.row];
    
    NSString *clsName = self.holoCellClsMap[holoRow.cell];
    Class cls = clsName ? NSClassFromString(clsName) : NSClassFromString(holoRow.cell);
    if ([cls conformsToProtocol:@protocol(HoloTableViewProtocol)] && holoRow.heightSEL && [cls respondsToSelector:holoRow.heightSEL]) {
        CGFloat cellHeight = [cls heightForRow:holoRow.model];
        return cellHeight;
    }
    
    return holoRow.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HoloSection *holoSection = self.holoSections[indexPath.section];
    HoloRow *holoRow = holoSection.rows[indexPath.row];
    if (holoRow.didSelectHandler) holoRow.didSelectHandler(holoRow.model);
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

#pragma mark - UITableViewDelegate (header and footer)
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HoloSection *holoSection = self.holoSections[section];
    return holoSection.headerView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    HoloSection *holoSection = self.holoSections[section];
    return holoSection.footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    HoloSection *holoSection = self.holoSections[section];
    return holoSection.headerViewHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    HoloSection *holoSection = self.holoSections[section];
    return holoSection.footerViewHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    HoloSection *holoSection = self.holoSections[section];
    if (holoSection.willDisplayHeaderViewHandler) holoSection.willDisplayHeaderViewHandler(view);
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    HoloSection *holoSection = self.holoSections[section];
    if (holoSection.willDisplayFooterViewHandler) holoSection.willDisplayFooterViewHandler(view);
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    HoloSection *holoSection = self.holoSections[section];
    if (holoSection.didEndDisplayingHeaderViewHandler) holoSection.didEndDisplayingHeaderViewHandler(view);
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    HoloSection *holoSection = self.holoSections[section];
    if (holoSection.didEndDisplayingFooterViewHandler) holoSection.didEndDisplayingFooterViewHandler(view);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.holo_tableScrollDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.holo_tableScrollDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if ([self.holo_tableScrollDelegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [self.holo_tableScrollDelegate scrollViewDidZoom:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.holo_tableScrollDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.holo_tableScrollDelegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ([self.holo_tableScrollDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.holo_tableScrollDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.holo_tableScrollDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.holo_tableScrollDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if ([self.holo_tableScrollDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.holo_tableScrollDelegate scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.holo_tableScrollDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.holo_tableScrollDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if ([self.holo_tableScrollDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.holo_tableScrollDelegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if ([self.holo_tableScrollDelegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        return [self.holo_tableScrollDelegate viewForZoomingInScrollView:scrollView];
    }
    return nil;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view {
    if ([self.holo_tableScrollDelegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [self.holo_tableScrollDelegate scrollViewWillBeginZooming:scrollView withView:view];
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
    if ([self.holo_tableScrollDelegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [self.holo_tableScrollDelegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    if ([self.holo_tableScrollDelegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        return [self.holo_tableScrollDelegate scrollViewShouldScrollToTop:scrollView];
    }
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if ([self.holo_tableScrollDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.holo_tableScrollDelegate scrollViewDidScrollToTop:scrollView];
    }
}

- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView {
    if ([self.holo_tableScrollDelegate respondsToSelector:@selector(scrollViewDidChangeAdjustedContentInset:)]) {
        if (@available(iOS 11.0, *)) {
            [self.holo_tableScrollDelegate scrollViewDidChangeAdjustedContentInset:scrollView];
        } else {
            // Fallback on earlier versions
        }
    }
}

#pragma mark - getter
- (HoloTableViewDataSource *)holo_tableDataSource {
    if (!_holo_tableDataSource) {
        _holo_tableDataSource = [HoloTableViewDataSource new];
    }
    return _holo_tableDataSource;
}

- (NSArray<HoloSection *> *)holoSections {
    return self.holo_tableDataSource.holo_sections;
}

- (NSDictionary *)holoCellClsMap {
    return self.holo_tableDataSource.holo_cellClsMap;
}

@end
