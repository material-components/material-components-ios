/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

/**
 The Typography component provides methods for getting sized fonts and opacities following Material
 style guidelines.

 This header is the umbrella header for the component and should be imported by consumers of the
 Typography component. Please do not directly import other headers. This will allow the componet to
 expand or contract the header file space without consumer modifications.
 */

#import "UIFont+MaterialSimpleEquality.h"

#import "MaterialMath.h"

@implementation UIFont (MaterialSimpleEquality)

BOOL MDCFontIsSimplyEqualToFont(UIFont *font1, UIFont *font2) {
  return [font1.fontName isEqualToString:font2.fontName] &&
  MDCCGFloatEqual(font1.pointSize, font2.pointSize) &&
  [[font1.fontDescriptor objectForKey:UIFontDescriptorFaceAttribute] isEqual:
   [font2.fontDescriptor objectForKey:UIFontDescriptorFaceAttribute]] &&
  [[font1.fontDescriptor objectForKey:UIFontDescriptorTraitsAttribute] isEqual:
   [font2.fontDescriptor objectForKey:UIFontDescriptorTraitsAttribute]];
}

@end
