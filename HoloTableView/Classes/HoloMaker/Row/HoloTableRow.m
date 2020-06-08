//
//  HoloTableRow.m
//  HoloTableView
//
//  Created by 与佳期 on 2020/6/1.
//

#import "HoloTableRow.h"

@implementation HoloTableRow

- (instancetype)init {
    self = [super init];
    if (self) {
        _height = CGFLOAT_MIN;
        _estimatedHeight = CGFLOAT_MIN;
        _shouldHighlight = YES;
        _style = UITableViewCellStyleDefault;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        _configSEL                  = @selector(holo_configureCellWithModel:);
        _heightSEL                  = @selector(holo_heightForCellWithModel:);
        _estimatedHeightSEL         = @selector(holo_estimatedHeightForCellWithModel:);
        _willSelectSEL              = @selector(holo_willSelectCellWithModel:);
        _willDeselectSEL            = @selector(holo_willDeselectCellWithModel:);
        _didDeselectSEL             = @selector(holo_didDeselectCellWithModel:);
        _didSelectSEL               = @selector(holo_didSelectCellWithModel:);
        _willDisplaySEL             = @selector(holo_willDisplayCellWithModel:);
        _didEndDisplayingSEL        = @selector(holo_didEndDisplayingCellWithModel:);
        _didHighlightSEL            = @selector(holo_didHighlightCellWithModel:);
        _didUnHighlightSEL          = @selector(holo_didUnHighlightCellWithModel:);
        _accessoryButtonTappedSEL   = @selector(holo_accessoryButtonTappedCellWithModel:);
        _willBeginEditingSEL        = @selector(holo_willBeginEditingCellWithModel:);
        _didEndEditingSEL           = @selector(holo_didEndEditingCellWithModel:);
        
        // support set a delegate for cell
        _delegateSEL                = @selector(holo_configureCellDelegate:);
#pragma clang diagnostic pop
        _canEdit = NO;
        _canMove = NO;
        _editingStyle = UITableViewCellEditingStyleNone;
    }
    
    return self;
}

@end
