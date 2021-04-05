# Change Log

All notable changes to this project will be documented in this file.


## 3.0.0 (05/04/2021)

### Added

- Support to reload a table view by setting datasource with `HoloTableSection` and `HoloTableRow`. Add `holo_sections` for `UITableView`.
- Add `holo_sectionIndexTitles` for `UITableView`.
- Add `holo_sectionForSectionIndexTitleHandler` for `UITableView`.
- Add `holo_scrollDelegate` for `UITableView`.

### Updated

- Reuse header and footer. And if has no header and header title, return nil for header, if has no footer and footer title, return nil for footer.

### Removed

- No longer support `headerFooterConfigSEL`, `headerFooterHeightSEL` and `headerFooterEstimatedHeightSEL` properties.
- No longer support `rowS`, `headerS` and `footerS` properties. And no longer support to regist key-Class map (`rowsMap`, `headersMap` and `footersMap`).


## 2.4.0 (16/02/2021)

- Update `HoloTableView.h`, use angle-bracketed instead of double-quoted.
- Update `HoloTableViewMacro`, add `#if !defined()`.
- Update `leadingSwipeActions` and `trailingSwipeActions`, only accept `HoloTableViewRowSwipeAction` type.

## 2.3.0 (09/12/2020)

- Add `nullable` to property.
- Delete the judgment that rows of section are greater than 0, in order to get the right section data.

## 2.2.0 (12/11/2020)

- Add `beforeConfigureHandler` and `afterConfigureHandler`, performed before and after `configSEL`.


## 2.1.0 (13/08/2020)

- Add `_Nullable` to method parameters in cell protocol, header protocol and footer protocol.


## 2.0.0 (23/07/2020)

- Refactor the update, remake and insert methods for `UITableView` and optimize the code logic.
- Provide more properties of section and row maker to handle proxy events of `UITableVIew`.
- Provide more protocols, implemented in cells, headers and footers to handle proxy events of `UITableVIew`.
- Support to regist maps (key-Class) for row, header and footer.
- Check the index in `HoloTableViewProxy` for safety.


## 1.x (2019 ~ 2020)

`HoloTableView` provides chained syntax calls that encapsulate delegate methods for `UITableView`. The delegate methods for `UITableView` is distributed to each `cell`, each `cell` having its own method for setting Class, model, height, and click event, etc.


