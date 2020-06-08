//
//  HoloTableViewCellProtocol.h
//  HoloTableView
//
//  Created by 与佳期 on 2020/6/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HoloTableViewCellProtocol <NSObject>

@required;

- (void)holo_configureCellWithModel:(id)model;


@optional

+ (CGFloat)holo_heightForCellWithModel:(id)model;

+ (CGFloat)holo_estimatedHeightForCellWithModel:(id)model;

- (BOOL)holo_shouldHighlightForCellWithModel:(id)model;

- (void)holo_willSelectCellWithModel:(id)model;

- (void)holo_willDeselectCellWithModel:(id)model;

- (void)holo_didDeselectCellWithModel:(id)model;

- (void)holo_didSelectCellWithModel:(id)model;

- (void)holo_willDisplayCellWithModel:(id)model;

- (void)holo_didEndDisplayingCellWithModel:(id)model;

- (void)holo_didHighlightCellWithModel:(id)model;

- (void)holo_didUnHighlightCellWithModel:(id)model;

- (void)holo_accessoryButtonTappedCellWithModel:(id)model;

- (void)holo_willBeginEditingCellWithModel:(id)model;

- (void)holo_didEndEditingCellWithModel:(id)model;

@end

NS_ASSUME_NONNULL_END
