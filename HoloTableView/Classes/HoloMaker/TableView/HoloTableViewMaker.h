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


@interface HoloTableViewModel : NSObject

@property (nonatomic, copy, nullable) NSArray *indexTitles;

@property (nonatomic, copy, nullable) HoloTableViewSectionForSectionIndexTitleHandler indexTitlesHandler;

@property (nonatomic, weak, nullable) id<HoloTableViewDelegate> delegate;

@property (nonatomic, weak, nullable) id<HoloTableViewDataSource> dataSource;

@property (nonatomic, weak, nullable) id<UIScrollViewDelegate> scrollDelegate;

@end


@interface HoloTableViewMaker : NSObject

@property (nonatomic, copy, readonly) HoloTableViewMaker *(^sectionIndexTitles)(NSArray<NSString *> *sectionIndexTitles);

@property (nonatomic, copy, readonly) HoloTableViewMaker *(^sectionForSectionIndexTitleHandler)(NSInteger (^handler)(NSString *title, NSInteger index));

@property (nonatomic, copy, readonly) HoloTableViewMaker *(^delegate)(id<HoloTableViewDelegate> delegate);

@property (nonatomic, copy, readonly) HoloTableViewMaker *(^dataSource)(id<HoloTableViewDataSource> dataSource);

@property (nonatomic, copy, readonly) HoloTableViewMaker *(^scrollDelegate)(id<UIScrollViewDelegate> scrollDelegate);

- (HoloTableViewModel *)install;

@end

NS_ASSUME_NONNULL_END
