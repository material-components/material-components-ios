#import <Foundation/Foundation.h>

@interface MDCExperimentalColorScheme : NSObject <NSCoding>

@property(nonatomic, strong) UIColor *primaryColor;
@property(nonatomic, strong) UIColor *backgroundColor;
@property(nonatomic, strong) UIColor *disabledBackgroundColor;
@property(nonatomic, strong) UIColor *textColor;
@property(nonatomic, strong) UIColor *selectionColor;
@property(nonatomic, strong) UIColor *borderColor;
@property(nonatomic, strong) UIColor *inkColor;
@property(nonatomic, strong) UIColor *shadowColor;

@end
