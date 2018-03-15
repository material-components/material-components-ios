#import <Foundation/Foundation.h>

#import "MaterialThemes.h"
#import "MDCBottomAppBarView.h"
@class MDCBottomAppBarView;
@interface MDCBottomAppBarExperimentalColorThemer : NSObject

+ (void)applyExperimentalColorScheme:(MDCExperimentalColorScheme *)colorScheme
                               toBar:(MDCBottomAppBarView *)appBar;

@end
