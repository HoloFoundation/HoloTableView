//
//  HoloTableViewMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2020/1/30.
//

#import <Foundation/Foundation.h>
#import "HoloTableViewProxy.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSInteger (^HoloSectionForSectionIndexTitleHandler)(NSString *title, NSInteger index);

////////////////////////////////////////////////////////////
@interface HoloTableViewModel : NSObject

@property (nonatomic, copy) NSArray *indexTitles;

@property (nonatomic, copy) HoloSectionForSectionIndexTitleHandler indexTitlesHandler;

@property (nonatomic, strong) id<HoloTableViewDelegate> delegate;

@property (nonatomic, strong) id<HoloTableViewDataSource> dataSource;

@property (nonatomic, strong) id<UIScrollViewDelegate> scrollDelegate;

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewMaker : NSObject

@property (nonatomic, copy, readonly) HoloTableViewMaker *(^sectionIndexTitles)(NSArray<NSString *> *sectionIndexTitles);

@property (nonatomic, copy, readonly) HoloTableViewMaker *(^sectionForSectionIndexTitleHandler)(NSInteger (^handler)(NSString *title, NSInteger index));

@property (nonatomic, copy, readonly) HoloTableViewMaker *(^delegate)(id<HoloTableViewDelegate> delegate);

@property (nonatomic, copy, readonly) HoloTableViewMaker *(^dataSource)(id<HoloTableViewDataSource> dataSource);

@property (nonatomic, copy, readonly) HoloTableViewMaker *(^scrollDelegate)(id<UIScrollViewDelegate> scrollDelegate);

- (HoloTableViewModel *)install;

@end

NS_ASSUME_NONNULL_END
