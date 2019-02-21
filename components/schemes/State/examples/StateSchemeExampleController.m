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

#import "StateSchemeExampleController.h"
#import "MaterialPalettes.h"
#import "MaterialStates.h"

@interface StateSchemeExampleController ()

@property(nullable, strong, nonatomic) MDCStateExampleColorScheme *exampleColorScheme;
@property(nullable, strong, nonatomic) MDCStateScheme *stateScheme;

@end

@implementation StateSchemeExampleController

- (void)viewDidLoad {
  [super viewDidLoad];

  // Note: State and Color schemes should be initialized with the same defaults, to ensure
  //       State overrides match the colors in the color scheme.
  if (self.exampleColorScheme == nil) {
    self.exampleColorScheme =
        [[MDCStateExampleColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  if (self.stateScheme == nil) {
    self.stateScheme =
        [[MDCStateScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }

  self.view.backgroundColor = self.exampleColorScheme.backgroundColor;

  // Note: There is no UI for this example.
  [self runStateSchemeExperiment];
}

/**
 The following retrieves various state colors for the OnWhite theme.

 The console output after running this experiment example is:

 State Example> onWhiteNormalOverlayColor should be: [null]. Is it? [YES]
 State Example> onWhiteSelectedOverlayColor should be: [overlay-12%]. Is it? [YES]
 State Example> overlay for state: [NORMAL] is: [(null)]. It should be: [null]
 State Example> overlay for state: [PRESSED] is:
                [semantic: overlay | palette: --, tint: --, hex: --, opacity: 0.10, dim: 1.00].
                It should be: [overlay]
 State Example> content for state: [DISABLED] is:
                [semantic: -- | palette: grey, tint: 800, hex: --, opacity: 0.38, dim: 1.00]
                It should be: [Palette.grey.tint800 at 38%]. Is it? [YES]
 State Example> content for state: [PRESSED] is:
                [semantic: on-surface | palette: --, tint: --, hex: --, opacity: 1.00, dim: 0.20].
                It should be: [on-surface 20% dim]
 State Example> overriding the content color for the PRESSED state to: Primary Color
 State Example> modified content for state: [PRESSED] is:
                [semantic: primary | palette: --, tint: --, hex: --, opacity: 0.60, dim: 1.00].
                It should be: [PrimaryColor 60%]

*/
- (void)runStateSchemeExperiment {
  UIColor *onWhiteNormalOverlayColor =
      [[self.stateScheme overlayColorResourceForState:MDCControlStateNormal
                                                theme:MDCStateSchemeThemeOnWhite]
          colorWithColorScheme:self.exampleColorScheme];
  NSLog(@"State Example> onWhiteNormalOverlayColor should be: [null]. Is it? [%@]",
        onWhiteNormalOverlayColor == nil ? @"YES" : @"NO");

  UIColor *onWhiteSelectedOverlayColor =
      [[self.stateScheme overlayColorResourceForState:MDCControlStateSelected
                                                theme:MDCStateSchemeThemeOnWhite]
          colorWithColorScheme:self.exampleColorScheme];

  NSLog(@"State Example> onWhiteSelectedOverlayColor should be: [overlay-12%%]. Is it? [%@]",
        [onWhiteSelectedOverlayColor
            isEqual:[self.exampleColorScheme.overlayColor colorWithAlphaComponent:0.12]]
            ? @"YES"
            : @"NO");

  MDCColorResource *normalOverlay =
      [self.stateScheme overlayColorResourceForState:MDCControlStateNormal
                                               theme:MDCStateSchemeThemeOnWhite];
  NSLog(@"State Example> overlay for state: [NORMAL] is: [%@]. It should be: [null]",
        normalOverlay);

  MDCColorResource *pressedOverlay =
      [self.stateScheme overlayColorResourceForState:MDCControlStateHighlighted
                                               theme:MDCStateSchemeThemeOnWhite];
  NSLog(@"State Example> overlay for state: [PRESSED] is: [%@]. It should be: [overlay]",
        pressedOverlay);

  MDCColorResource *disabledContent =
      [self.stateScheme contentColorResourceForState:MDCControlStateDisabled
                                               theme:MDCStateSchemeThemeOnWhite];
  NSLog(@"State Example> content for state: [DISABLED] is: [%@]", disabledContent);
  if (disabledContent != nil) {
    UIColor *disabledColor = [disabledContent colorWithColorScheme:self.exampleColorScheme];
    UIColor *intendedDisabledColor = [MDCPalette.greyPalette.tint800 colorWithAlphaComponent:0.38];
    NSLog(@"State Example> It should be: [Palette.grey.tint800 at 38%%]. Is it? [%@]",
          [disabledColor isEqual:intendedDisabledColor] ? @"YES" : @"NO");
  }

  MDCColorResource *pressedContent =
      [self.stateScheme contentColorResourceForState:MDCControlStateHighlighted
                                               theme:MDCStateSchemeThemeOnWhite];
  NSLog(
      @"State Example> content for state: [PRESSED] is: [%@]. It should be: [on-surface 20%% dim]",
      pressedContent);

  // override the content color for the pressed state
  [self.stateScheme setContentColorWithSemanticColor:MDCColorResourceSemanticPrimary
                                             opacity:0.6
                                            forState:MDCControlStateInteractive
                                             inTheme:MDCStateSchemeThemeOnWhite];
  NSLog(@"State Example> overriding the content color for the PRESSED state to: Primary Color");
  MDCColorResource *newPressedContent =
      [self.stateScheme contentColorResourceForState:MDCControlStateHighlighted
                                               theme:MDCStateSchemeThemeOnWhite];
  NSLog(@"State Example> modified content for state: [PRESSED] is: [%@].", newPressedContent);
  NSLog(@"It should be: [PrimaryColor 60%%]");
}

@end

// MARK: Catalog by Convention

@implementation StateSchemeExampleController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Schemes", @"States Prototype (Alpha)" ],
    @"description" : @"Prototype of States Theming.",
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
