/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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
#import "MaterialSwitch.h"
#import "MaterialTypography.h"

@interface TypographySystemFontLoaderExampleViewController : UIViewController
@property(weak, nonatomic) IBOutlet MDCSwitch *mdcSwitch;
@property(weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation TypographySystemFontLoaderExampleViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.view.backgroundColor = [UIColor whiteColor];

  // Load your Material Component here.
  _mdcSwitch.on = [[MDCRobotoFontLoader sharedInstance] isEqual:[MDCTypography fontLoader]];

  _label.font = [MDCTypography body1Font];
  _label.alpha = [MDCTypography body1FontOpacity];
  [_label sizeToFit];
}

- (IBAction)didChangeSwitchValue:(id)sender {
  MDCSwitch *switchSender = sender;

  // For the purposes of this example we are setting this at run time. Usually an app will set this
  // once, during the initalization of the app before any UI is called so that any Material
  // Components will have the correct consistent fonts.
  if (switchSender.isOn) {
    [MDCTypography setFontLoader:[MDCRobotoFontLoader sharedInstance]];
  } else {
    [MDCTypography setFontLoader:[[MDCSystemFontLoader alloc] init]];
  }

  [self.view setNeedsDisplay];
  _label.font = [MDCTypography body1Font];
  [_label sizeToFit];
}

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Typography", @"Set Font Loader" ];
}

+ (NSString *)catalogStoryboardName {
  return @"TypographySetFontLoader";
}

@end
