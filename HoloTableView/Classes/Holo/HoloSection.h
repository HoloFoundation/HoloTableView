//
//  HoloSection.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import <Foundation/Foundation.h>
@class HoloRow;

NS_ASSUME_NONNULL_BEGIN

@interface HoloSection : NSObject

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy, nullable) NSArray<HoloRow *> *holoRows;

#pragma mark - header and footer
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, assign) CGFloat headerViewHeight;

@property (nonatomic, assign) CGFloat footerViewHeight;


- (void)holo_appendRows:(NSArray<HoloRow *> *)holoRows;

- (void)holo_deleteAllRows;

@end

NS_ASSUME_NONNULL_END
