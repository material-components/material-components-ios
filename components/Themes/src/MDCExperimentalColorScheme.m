#import "MDCExperimentalColorScheme.h"

@implementation MDCExperimentalColorScheme

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    _primaryColor = [aDecoder decodeObjectForKey:@"pc"];
    _backgroundColor = [aDecoder decodeObjectForKey:@"bac"];
    _inkColor = [aDecoder decodeObjectForKey:@"ic"];
    _textColor = [aDecoder decodeObjectForKey:@"tc"];
    _borderColor = [aDecoder decodeObjectForKey:@"boc"];
    _shadowColor = [aDecoder decodeObjectForKey:@"shc"];
    _selectionColor = [aDecoder decodeObjectForKey:@"sec"];
    _disabledBackgroundColor = [aDecoder decodeObjectForKey:@"dbc"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.primaryColor forKey:@"pc"];
  [aCoder encodeObject:self.backgroundColor forKey:@"bac"];
  [aCoder encodeObject:self.inkColor forKey:@"ic"];
  [aCoder encodeObject:self.textColor forKey:@"tc"];
  [aCoder encodeObject:self.borderColor forKey:@"boc"];
  [aCoder encodeObject:self.shadowColor forKey:@"shc"];
  [aCoder encodeObject:self.selectionColor forKey:@"sec"];
  [aCoder encodeObject:self.disabledBackgroundColor forKey:@"dbc"];
}

@end
