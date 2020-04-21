//
//  HoloExampleFooterView.m
//  HoloTableView_Example
//
//  Created by 与佳期 on 2019/8/3.
//  Copyright © 2019 gonghonglou. All rights reserved.
//

#import "HoloExampleFooterView.h"

@implementation HoloExampleFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor lightGrayColor];
        // self.textLabel.text will became nil when the footer is reused
        // self.textLabel.text = @"footer";
    }
    return self;
}

- (void)holo_configureFooterWithModel:(NSDictionary *)model {
    self.textLabel.text = model[@"title"];
}

@end
