/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <UIKit/UIKit.h>

#import "MaterialRobotoFontLoader.h"

@interface RobotoVsSystemExampleViewController : UIViewController
@property(weak, nonatomic) IBOutlet UILabel *robotoLabel;
@end

@implementation RobotoVsSystemExampleViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.view.backgroundColor = [UIColor whiteColor];

  _robotoLabel.font =
      [[MDCRobotoFontLoader sharedInstance] regularFontOfSize:_robotoLabel.font.pointSize];
}

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Typography and Fonts", @"Roboto Font Loader" ];
}

+ (NSString *)catalogStoryboardName {
  return @"RobotoVsSystem";
}

@end
