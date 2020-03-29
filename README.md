# HoloTableView

[![CI Status](https://img.shields.io/travis/gonghonglou/HoloTableView.svg?style=flat)](https://travis-ci.org/gonghonglou/HoloTableView)
[![Version](https://img.shields.io/cocoapods/v/HoloTableView.svg?style=flat)](https://cocoapods.org/pods/HoloTableView)
[![License](https://img.shields.io/cocoapods/l/HoloTableView.svg?style=flat)](https://cocoapods.org/pods/HoloTableView)
[![Platform](https://img.shields.io/cocoapods/p/HoloTableView.svg?style=flat)](https://cocoapods.org/pods/HoloTableView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Integration with 3rd party libraries

- [HoloTableViewMGPlugin](https://github.com/gonghonglou/HoloTableViewMGPlugin) - plugin to support [MGSwipeTableCell](https://github.com/MortimerGoro/MGSwipeTableCell), add swip actions for cell.


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
   // make a cell
   make.row(ExampleTableViewCell.class).model(NSDictionary.new).height(44);
   
   // make a list
   for (NSObject *obj in NSArray.new) {
       make.row(ExampleTableViewCell.class).model(obj).didSelectHandler(^(id  _Nullable model) {
           NSLog(@"did select row : %@", model);
       });
   }
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


