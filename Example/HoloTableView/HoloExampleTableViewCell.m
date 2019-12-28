//
//  HoloExampleTableViewCell.m
//  HoloTableView_Example
//
//  Created by 与佳期 on 2019/7/28.
//  Copyright © 2019 gonghonglou. All rights reserved.
//

#import "HoloExampleTableViewCell.h"

@implementation HoloExampleTableViewCell

- (void)holo_configureCellWithModel:(NSDictionary *)model {
    self.backgroundColor = model[@"bgColor"];
    self.textLabel.text = model[@"text"];
}

+ (CGFloat)holo_heightForCellWithModel:(NSDictionary *)model {
    return [model[@"height"] floatValue];
}

@end
