/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "UIView+MaterialRTL.h"

#import <objc/runtime.h>

#define MDC_BASE_SDK_EQUAL_OR_ABOVE(x) \
  (defined(__IPHONE_##x) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_##x))

static inline UIUserInterfaceLayoutDirection
    MDCUserInterfaceLayoutDirectionForSemanticContentAttributeRelativeToLayoutDirection(
        UISemanticContentAttribute semanticContentAttribute,
        UIUserInterfaceLayoutDirection userInterfaceLayoutDirection) {
  switch (semanticContentAttribute) {
    case UISemanticContentAttributeUnspecified:
      return userInterfaceLayoutDirection;
    case UISemanticContentAttributePlayback:
    case UISemanticContentAttributeSpatial:
    case UISemanticContentAttributeForceLeftToRight:
      return UIUserInterfaceLayoutDirectionLeftToRight;
    case UISemanticContentAttributeForceRightToLeft:
      return UIUserInterfaceLayoutDirectionRightToLeft;
  }
  NSCAssert(NO, @"Invalid enumeration value %i.", (int)semanticContentAttribute);
  return userInterfaceLayoutDirection;
}

@interface UIView (MaterialRTLPrivate)

// On iOS 9 and above, mdc_semanticContentAttribute is backed by UIKit's semanticContentAttribute.
// On iOS 8 and below, mdc_semanticContentAttribute is backed by an associated object.
@property(nonatomic, setter=mdc_setAssociatedSemanticContentAttribute:)
    UISemanticContentAttribute mdc_associatedSemanticContentAttribute;

@end

@implementation UIView (MaterialRTL)

- (UISemanticContentAttribute)mdc_semanticContentAttribute {
#if MDC_BASE_SDK_EQUAL_OR_ABOVE(9_0)
  if ([self respondsToSelector:@selector(semanticContentAttribute)]) {
    return self.semanticContentAttribute;
  } else
#endif  // MDC_BASE_SDK_EQUAL_OR_ABOVE(9_0)
  {
    return self.mdc_associatedSemanticContentAttribute;
  }
}

- (void)mdc_setSemanticContentAttribute:(UISemanticContentAttribute)semanticContentAttribute {
#if MDC_BASE_SDK_EQUAL_OR_ABOVE(9_0)
  if ([self respondsToSelector:@selector(semanticContentAttribute)]) {
    self.semanticContentAttribute = semanticContentAttribute;
  } else
#endif  // MDC_BASE_SDK_EQUAL_OR_ABOVE(9_0)
  {
    self.mdc_associatedSemanticContentAttribute = semanticContentAttribute;
  }

  // Invalidate the layout.
  [self setNeedsLayout];
}

- (UIUserInterfaceLayoutDirection)mdc_effectiveUserInterfaceLayoutDirection {
#if MDC_BASE_SDK_EQUAL_OR_ABOVE(10_0)
  if ([self respondsToSelector:@selector(effectiveUserInterfaceLayoutDirection)]) {
    return self.effectiveUserInterfaceLayoutDirection;
  } else {
    return [UIView mdc_userInterfaceLayoutDirectionForSemanticContentAttribute:
                       self.mdc_semanticContentAttribute];
  }
#else
  return [UIView mdc_userInterfaceLayoutDirectionForSemanticContentAttribute:
                     self.mdc_semanticContentAttribute];
#endif  // MDC_BASE_SDK_EQUAL_OR_ABOVE(10_0)
}

+ (UIUserInterfaceLayoutDirection)mdc_userInterfaceLayoutDirectionForSemanticContentAttribute:
        (UISemanticContentAttribute)attribute {
#if MDC_BASE_SDK_EQUAL_OR_ABOVE(9_0)
  if ([self
          respondsToSelector:@selector(userInterfaceLayoutDirectionForSemanticContentAttribute:)]) {
    return [self userInterfaceLayoutDirectionForSemanticContentAttribute:attribute];
  } else
#endif  // MDC_BASE_SDK_EQUAL_OR_ABOVE(9_0)
  {
    // Use a default of Left-to-Right, as UIKit in iOS 8 and below doesn't support native RTL
    // layout.
    UIUserInterfaceLayoutDirection applicationLayoutDirection =
        UIUserInterfaceLayoutDirectionLeftToRight;
    return [self
        mdc_userInterfaceLayoutDirectionForSemanticContentAttribute:attribute
                                          relativeToLayoutDirection:applicationLayoutDirection];
  }
}

+ (UIUserInterfaceLayoutDirection)
    mdc_userInterfaceLayoutDirectionForSemanticContentAttribute:
        (UISemanticContentAttribute)semanticContentAttribute
                                      relativeToLayoutDirection:
                                          (UIUserInterfaceLayoutDirection)layoutDirection {
#if MDC_BASE_SDK_EQUAL_OR_ABOVE(10_0)
  if ([self
          respondsToSelector:@selector(userInterfaceLayoutDirectionForSemanticContentAttribute:
                                                                     relativeToLayoutDirection:)]) {
    return [self userInterfaceLayoutDirectionForSemanticContentAttribute:semanticContentAttribute
                                               relativeToLayoutDirection:layoutDirection];
  } else {
    return MDCUserInterfaceLayoutDirectionForSemanticContentAttributeRelativeToLayoutDirection(
        semanticContentAttribute, layoutDirection);
  }
#else
  return MDCUserInterfaceLayoutDirectionForSemanticContentAttributeRelativeToLayoutDirection(
      semanticContentAttribute, layoutDirection);
#endif  // MDC_BASE_SDK_EQUAL_OR_ABOVE(10_0)
}

@end

@implementation UIView (MaterialRTLPrivate)

- (UISemanticContentAttribute)mdc_associatedSemanticContentAttribute {
  NSNumber *semanticContentAttributeNumber =
      objc_getAssociatedObject(self, @selector(mdc_semanticContentAttribute));
  if (semanticContentAttributeNumber) {
    return [semanticContentAttributeNumber integerValue];
  }
  return UISemanticContentAttributeUnspecified;
}

- (void)mdc_setAssociatedSemanticContentAttribute:
        (UISemanticContentAttribute)semanticContentAttribute {
  objc_setAssociatedObject(self, @selector(mdc_semanticContentAttribute),
                           @(semanticContentAttribute), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
