//
//  HoloTableViewCellProtocol.h
//  HoloTableView
//
//  Created by 与佳期 on 2020/6/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HoloTableViewCellProtocol <NSObject>

@required

- (void)holo_configureCellWithModel:(id _Nullable)model;


@optional

+ (CGFloat)holo_heightForCellWithModel:(id _Nullable)model;

+ (CGFloat)holo_estimatedHeightForCellWithModel:(id _Nullable)model;

- (BOOL)holo_shouldHighlightForCellWithModel:(id _Nullable)model;

- (void)holo_willSelectCellWithModel:(id _Nullable)model;

- (void)holo_willDeselectCellWithModel:(id _Nullable)model;

- (void)holo_didDeselectCellWithModel:(id _Nullable)model;

- (void)holo_didSelectCellWithModel:(id _Nullable)model;

- (void)holo_willDisplayCellWithModel:(id _Nullable)model;

- (void)holo_didEndDisplayingCellWithModel:(id _Nullable)model;

- (void)holo_didHighlightCellWithModel:(id _Nullable)model;

- (void)holo_didUnHighlightCellWithModel:(id _Nullable)model;

- (void)holo_accessoryButtonTappedCellWithModel:(id _Nullable)model;

- (void)holo_willBeginEditingCellWithModel:(id _Nullable)model;

- (void)holo_didEndEditingCellWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
