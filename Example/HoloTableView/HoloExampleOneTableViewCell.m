//
//  HoloExampleOneTableViewCell.m
//  HoloTableView_Example
//
//  Created by 与佳期 on 2019/7/28.
//  Copyright © 2019 gonghonglou. All rights reserved.
//

#import "HoloExampleOneTableViewCell.h"

@implementation HoloExampleOneTableViewCell

- (void)configureCellWithModel:(NSDictionary *)model {
    self.backgroundColor = model[@"bgColor"];
    self.textLabel.text = model[@"text"];
}

+ (CGFloat)heightForRowWithModel:(NSDictionary *)model {
    return [model[@"height"] floatValue];
}

@end
