//
//  HoloTableViewMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2020/1/30.
//

#import <Foundation/Foundation.h>
#import "HoloTableViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSInteger (^HoloTableViewSectionForSectionIndexTitleHandler)(NSString *title, NSInteger index);

/// RHFMap: RowHeaderFooterMap
@interface HoloTableViewRHFMap : NSObject

@property (nonatomic, copy, readonly) void (^map)(Class cls);

@end

/// RHFMapMaker: RowHeaderFooterMaker
@interface HoloTableViewRHFMapMaker : NSObject

@end


@interface HoloTableViewRowMapMaker : HoloTableViewRHFMapMaker

@property (nonatomic, copy, readonly) HoloTableViewRHFMap *(^row)(NSString *row);

@end


@interface HoloTableViewHeaderMapMaker : HoloTableViewRHFMapMaker

@property (nonatomic, copy, readonly) HoloTableViewRHFMap *(^header)(NSString *header);

@end


@interface HoloTableViewFooterMapMaker : HoloTableViewRHFMapMaker

@property (nonatomic, copy, readonly) HoloTableViewRHFMap *(^footer)(NSString *footer);

@end


@interface HoloTableViewModel : NSObject

@property (nonatomic, copy, nullable) NSArray *indexTitles;

@property (nonatomic, copy, nullable) HoloTableViewSectionForSectionIndexTitleHandler indexTitlesHandler;

@property (nonatomic, weak, nullable) id<HoloTableViewDelegate> delegate;

@property (nonatomic, weak, nullable) id<HoloTableViewDataSource> dataSource;

@property (nonatomic, weak, nullable) id<UIScrollViewDelegate> scrollDelegate;

@property (nonatomic, copy, nullable) NSDictionary<NSString *, Class> *rowsMap;

@property (nonatomic, copy, nullable) NSDictionary<NSString *, Class> *headersMap;

@property (nonatomic, copy, nullable) NSDictionary<NSString *, Class> *footersMap;

@end


@interface HoloTableViewMaker : NSObject

@property (nonatomic, copy, readonly) HoloTableViewMaker *(^sectionIndexTitles)(NSArray<NSString *> *sectionIndexTitles);

@property (nonatomic, copy, readonly) HoloTableViewMaker *(^sectionForSectionIndexTitleHandler)(NSInteger (^handler)(NSString *title, NSInteger index));

@property (nonatomic, copy, readonly) HoloTableViewMaker *(^delegate)(id<HoloTableViewDelegate> delegate);

@property (nonatomic, copy, readonly) HoloTableViewMaker *(^dataSource)(id<HoloTableViewDataSource> dataSource);

@property (nonatomic, copy, readonly) HoloTableViewMaker *(^scrollDelegate)(id<UIScrollViewDelegate> scrollDelegate);

@property (nonatomic, copy, readonly) HoloTableViewMaker *(^makeRowsMap)(void(NS_NOESCAPE ^)(HoloTableViewRowMapMaker *make));

@property (nonatomic, copy, readonly) HoloTableViewMaker *(^makeHeadersMap)(void(NS_NOESCAPE ^)(HoloTableViewHeaderMapMaker *make));

@property (nonatomic, copy, readonly) HoloTableViewMaker *(^makeFootersMap)(void(NS_NOESCAPE ^)(HoloTableViewFooterMapMaker *make));

- (HoloTableViewModel *)install;

@end

NS_ASSUME_NONNULL_END
