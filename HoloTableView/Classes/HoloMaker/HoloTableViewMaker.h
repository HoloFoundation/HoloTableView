//
//  HoloTableViewMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2020/1/30.
//

#import <Foundation/Foundation.h>
#import "HoloTableViewProxy.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSInteger (^HoloTableViewSectionForSectionIndexTitleHandler)(NSString *title, NSInteger index);

////////////////////////////////////////////////////////////
@interface HoloTableViewRHFMap : NSObject // RHFMap: RowHeaderFooterMap

@property (nonatomic, copy, readonly) void (^map)(Class cls);

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewRHFMapMaker : NSObject // RHFMapMaker: RowHeaderFooterMaker

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewRowMapMaker : HoloTableViewRHFMapMaker

@property (nonatomic, copy, readonly) HoloTableViewRHFMap *(^row)(NSString *row);

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewHeaderMapMaker : HoloTableViewRHFMapMaker

@property (nonatomic, copy, readonly) HoloTableViewRHFMap *(^header)(NSString *header);

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewFooterMapMaker : HoloTableViewRHFMapMaker

@property (nonatomic, copy, readonly) HoloTableViewRHFMap *(^footer)(NSString *footer);

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewModel : NSObject

@property (nonatomic, copy) NSArray *indexTitles;

@property (nonatomic, copy) HoloTableViewSectionForSectionIndexTitleHandler indexTitlesHandler;

@property (nonatomic, weak) id<HoloTableViewDelegate> delegate;

@property (nonatomic, weak) id<HoloTableViewDataSource> dataSource;

@property (nonatomic, weak) id<UIScrollViewDelegate> scrollDelegate;

@property (nonatomic, copy) NSDictionary<NSString *, Class> *rowsMap;

@property (nonatomic, copy) NSDictionary<NSString *, Class> *headersMap;

@property (nonatomic, copy) NSDictionary<NSString *, Class> *footersMap;

@end

////////////////////////////////////////////////////////////
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
