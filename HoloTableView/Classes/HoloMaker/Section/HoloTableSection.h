//
//  HoloTableSection.h
//  HoloTableView
//
//  Created by 与佳期 on 2020/6/2.
//

#import <Foundation/Foundation.h>
@class HoloTableRow;

NS_ASSUME_NONNULL_BEGIN

@interface HoloTableSection : NSObject

@property (nonatomic, copy, nullable) NSArray<HoloTableRow *> *rows;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *header;

@property (nonatomic, copy) NSString *footer;

#pragma mark - priority low
@property (nonatomic, strong) id headerModel;

@property (nonatomic, strong) id footerModel;

@property (nonatomic, copy) NSString *headerReuseId;

@property (nonatomic, copy) NSString *footerReuseId;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) CGFloat footerHeight;

@property (nonatomic, assign) CGFloat headerEstimatedHeight;

@property (nonatomic, assign) CGFloat footerEstimatedHeight;

#pragma mark - priority middle
@property (nonatomic, copy) id (^headerModelHandler)(void);

@property (nonatomic, copy) id (^footerModelHandler)(void);

@property (nonatomic, copy) NSString *(^headerReuseIdHandler)(id _Nullable model);

@property (nonatomic, copy) NSString *(^footerReuseIdHandler)(id _Nullable model);

@property (nonatomic, copy) CGFloat (^headerHeightHandler)(id _Nullable model);

@property (nonatomic, copy) CGFloat (^footerHeightHandler)(id _Nullable model);

@property (nonatomic, copy) CGFloat (^headerEstimatedHeightHandler)(id _Nullable model);

@property (nonatomic, copy) CGFloat (^footerEstimatedHeightHandler)(id _Nullable model);

@property (nonatomic, copy) void (^willDisplayHeaderHandler)(UIView *header, id _Nullable model);

@property (nonatomic, copy) void (^willDisplayFooterHandler)(UIView *footer, id _Nullable model);

@property (nonatomic, copy) void (^didEndDisplayingHeaderHandler)(UIView *header, id _Nullable model);

@property (nonatomic, copy) void (^didEndDisplayingFooterHandler)(UIView *footer, id _Nullable model);

#pragma mark - priority high
@property (nonatomic, assign) SEL headerConfigSEL;

@property (nonatomic, assign) SEL footerConfigSEL;

@property (nonatomic, assign) SEL headerHeightSEL;

@property (nonatomic, assign) SEL footerHeightSEL;

@property (nonatomic, assign) SEL headerEstimatedHeightSEL;

@property (nonatomic, assign) SEL footerEstimatedHeightSEL;

@property (nonatomic, assign) SEL headerFooterConfigSEL;
@property (nonatomic, assign) SEL headerFooterHeightSEL;
@property (nonatomic, assign) SEL headerFooterEstimatedHeightSEL;

@property (nonatomic, assign) SEL willDisplayHeaderSEL;

@property (nonatomic, assign) SEL willDisplayFooterSEL;

@property (nonatomic, assign) SEL didEndDisplayingHeaderSEL;

@property (nonatomic, assign) SEL didEndDisplayingFooterSEL;


- (NSIndexSet *)insertRows:(NSArray<HoloTableRow *> *)rows atIndex:(NSInteger)index;

- (void)removeRow:(HoloTableRow *)row;

- (void)removeAllRows;

@end


NS_ASSUME_NONNULL_END
