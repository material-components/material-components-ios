// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "MaterialTextFields.h"

static NSString *const TSTTextFieldTableViewCellIdentifier = @"TSTTextFieldsTableViewExampleCell";

@interface TextFieldTableViewCell : UITableViewCell

@property(nonatomic, strong) MDCTextField *textField;
@property(nonatomic, strong) MDCTextInputControllerFilled *textFieldController;

@end

@interface TextFieldsTableViewExample
    : UIViewController <UITableViewDataSource, UITextFieldDelegate>

@property(nonatomic, strong) NSMutableArray<NSString *> *strings;
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation TextFieldsTableViewExample

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 82;
  self.tableView.dataSource = self;
  [self.tableView registerClass:[TextFieldTableViewCell class]
         forCellReuseIdentifier:TSTTextFieldTableViewCellIdentifier];

  self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:self.tableView];

  [self.tableView setContentInset:UIEdgeInsetsMake(20, 0, 0, -20)];
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

  [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor]
      .active = YES;

  [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;

  [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
  [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;

  [self setupDataModel];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:TSTTextFieldTableViewCellIdentifier];
  if ([cell isKindOfClass:[TextFieldTableViewCell class]]) {
    TextFieldTableViewCell *textFieldCell = (TextFieldTableViewCell *)cell;

    textFieldCell.textField.tag = indexPath.row;
    textFieldCell.textField.delegate = self;

    if (indexPath.row < (NSInteger)self.strings.count) {
      NSString *string = self.strings[indexPath.row];
      textFieldCell.textFieldController.textInput.text = string;
    }
    textFieldCell.textFieldController.placeholderText =
        [NSString stringWithFormat:@"TextField #%lu", (long)indexPath.row];
  }

  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 20;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];

  return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  self.strings[textField.tag] = textField.text ?: @"";
}

#pragma mark - Example Data

- (void)setupDataModel {
  self.strings = [NSMutableArray array];
  for (int i = 0; i < 20; ++i) {
    [self.strings addObject:@""];
  }
}

@end

@implementation TextFieldsTableViewExample (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Text Field", @"Table View" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end

@implementation TextFieldTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.textField = [[MDCTextField alloc] initWithFrame:CGRectZero];
    self.textField.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.textField];

    [self.textField.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [self.textField.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [self.textField.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:8].active =
        YES;
    [self.textField.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-8].active =
        YES;

    _textFieldController = [[MDCTextInputControllerFilled alloc] initWithTextInput:self.textField];
  }
  return self;
}

@end
