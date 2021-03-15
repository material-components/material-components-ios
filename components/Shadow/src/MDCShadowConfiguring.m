// Copyright 2021-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCShadowConfiguring.h"

#import "MaterialAvailability.h"
#import "MDCShadow.h"

void MDCConfigureShadowForViewWithElevation(UIView *view, UIColor *shadowColor, CGFloat elevation) {
  MDCShadow *shadow = MDCShadowForElevation(elevation);
  if (!shadow) {
    view.layer.shadowColor = nil;
    view.layer.shadowOpacity = 0;
    view.layer.shadowRadius = 0;
    view.layer.shadowOffset = CGSizeZero;
    view.layer.shadowPath = nil;
    return;
  }
  MDCConfigureShadowForViewWithShadow(view, shadowColor, shadow);
}

void MDCConfigureShadowForViewWithShadow(UIView *view, UIColor *shadowColor, MDCShadow *shadow) {
  // Support views both with and without cornerRadius set.
  UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                  cornerRadius:view.layer.cornerRadius];
  MDCConfigureShadowForViewWithShadowAndPath(view, shadowColor, shadow, path.CGPath);
}

void MDCConfigureShadowForViewWithShadowAndPath(UIView *view, UIColor *shadowColor,
                                                MDCShadow *shadow, CGPathRef path) {
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(ios 13.0, *)) {
    shadowColor = [shadowColor resolvedColorWithTraitCollection:view.traitCollection];
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
  view.layer.shadowColor = shadowColor.CGColor;
  view.layer.shadowOpacity = shadow.opacity;
  view.layer.shadowRadius = shadow.radius;
  view.layer.shadowOffset = shadow.offset;
  view.layer.shadowPath = path;
}
