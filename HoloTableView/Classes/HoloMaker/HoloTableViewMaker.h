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
@interface HoloTableViewRowMapMaker : NSObject

@property (nonatomic, copy, readonly) HoloTableViewRowMapMaker *(^row)(NSString *row);

@property (nonatomic, copy, readonly) HoloTableViewRowMapMaker *(^map)(Class cls);

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewHeaderMapMaker : NSObject

@property (nonatomic, copy, readonly) HoloTableViewRowMapMaker *(^header)(NSString *header);

@property (nonatomic, copy, readonly) HoloTableViewRowMapMaker *(^map)(Class cls);

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewFooterMapMaker : NSObject

@property (nonatomic, copy, readonly) HoloTableViewRowMapMaker *(^footer)(NSString *footer);

@property (nonatomic, copy, readonly) HoloTableViewRowMapMaker *(^map)(Class cls);

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewModel : NSObject

@property (nonatomic, copy) NSArray *indexTitles;

@property (nonatomic, copy) HoloTableViewSectionForSectionIndexTitleHandler indexTitlesHandler;

@property (nonatomic, strong) id<HoloTableViewDelegate> delegate;

@property (nonatomic, strong) id<HoloTableViewDataSource> dataSource;

@property (nonatomic, strong) id<UIScrollViewDelegate> scrollDelegate;

@property (nonatomic, copy) NSArray<NSDictionary<NSString *, Class> *> *rowsMap;

@property (nonatomic, copy) NSArray<NSDictionary<NSString *, Class> *> *headersMap;

@property (nonatomic, copy) NSArray<NSDictionary<NSString *, Class> *> *footersMap;

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
