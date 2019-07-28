//
//  HoloTableViewOneCell.m
//  HoloTableView_Example
//
//  Created by 与佳期 on 2019/7/28.
//  Copyright © 2019 gonghonglou. All rights reserved.
//

#import "HoloTableViewOneCell.h"

@implementation HoloTableViewOneCell

- (void)cellForRow:(NSDictionary *)model {
    self.backgroundColor = model[@"bgColor"];
    self.textLabel.text = model[@"text"];
}

+ (CGFloat)heightForRow:(NSDictionary *)model {
    return [model[@"height"] floatValue];
}

@end
