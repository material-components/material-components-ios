#import "MDCBottomAppBarExperimentalColorThemer.h"
#import "MDCBottomAppBarView.h"
#import "MDCButtonColorThemer.h"
@implementation MDCBottomAppBarExperimentalColorThemer
+ (void)applyExperimentalColorScheme:(MDCExperimentalColorScheme *)colorScheme
                               toBar:(MDCBottomAppBarView *)appBar {
  appBar.backgroundColor = colorScheme.backgroundColor;
  appBar.tintColor = colorScheme.textColor;
  if (appBar.floatingButton) {
    [MDCButtonColorThemer applyExperimentalColorScheme:colorScheme toButton:appBar.floatingButton];
  }
}
@end
