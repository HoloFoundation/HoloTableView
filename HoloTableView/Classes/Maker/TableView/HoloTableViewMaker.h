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

/**
 *  Return list of section titles to display in section index view (e.g. "ABCD...Z#").
 */
@property (nonatomic, copy, readonly) HoloTableViewMaker *(^sectionIndexTitles)(NSArray<NSString *> *sectionIndexTitles);

/**
 *  Tell table which section corresponds to section title/index (e.g. "B",1)).
 */
@property (nonatomic, copy, readonly) HoloTableViewMaker *(^sectionForSectionIndexTitleHandler)(NSInteger (^handler)(NSString *title, NSInteger index));

/**
 *  The delegate of the scroll-view object.
 */
@property (nonatomic, copy, readonly) HoloTableViewMaker *(^scrollDelegate)(id<UIScrollViewDelegate> scrollDelegate);

@property (nonatomic, copy, readonly) HoloTableViewMaker *(^delegate)(id<HoloTableViewDelegate> delegate);

@property (nonatomic, copy, readonly) HoloTableViewMaker *(^dataSource)(id<HoloTableViewDataSource> dataSource);

- (HoloTableViewModel *)install;

@end

NS_ASSUME_NONNULL_END
