# HoloTableView

[![CI Status](https://img.shields.io/travis/gonghonglou/HoloTableView.svg?style=flat)](https://travis-ci.org/gonghonglou/HoloTableView)
[![Version](https://img.shields.io/cocoapods/v/HoloTableView.svg?style=flat)](https://cocoapods.org/pods/HoloTableView)
[![License](https://img.shields.io/cocoapods/l/HoloTableView.svg?style=flat)](https://cocoapods.org/pods/HoloTableView)
[![Platform](https://img.shields.io/cocoapods/p/HoloTableView.svg?style=flat)](https://cocoapods.org/pods/HoloTableView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

If you want to set the model to your UITableViewCell or change it's height according to the model, the UITableViewCell could conform to protocol: `HoloTableViewCellProtocol` and implement their selectors: 

```objective-c
- (void)holo_configureCellWithModel:(id)model;

+ (CGFloat)holo_heightForCellWithModel:(id)model;
```

## Usage

```objective-c
UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
[self.view addSubview:tableView];

[tableView holo_makeRows:^(HoloTableViewRowMaker * _Nonnull make) {
   // one cell
   make.row(OneTableViewCell.class).model(@{@"key":@"value1"});
   make.row(OneTableViewCell.class).model(@{@"key":@"value2"});
   
   // two cell
   make.row(TwoTableViewCell.class).model(@{@"key":@"value"}).height(44);
   
   // three cell
   make.row(ThreeTableViewCell.class).didSelectHandler(^(id  _Nonnull model) {
       NSLog(@"did select row, model: %@", model);
   });
}];

[self.tableView reloadData];

// etc...
```

## Installation

HoloTableView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HoloTableView'
```

## Author

gonghonglou, gonghonglou@icloud.com

## License

HoloTableView is available under the MIT license. See the LICENSE file for more info.


