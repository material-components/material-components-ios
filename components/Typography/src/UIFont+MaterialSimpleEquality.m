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

#import "UIFont+MaterialSimpleEquality.h"

#import "MaterialMath.h"

BOOL MDCFontIsSimplyEqualToFont(UIFont *font1, UIFont *font2) {
  NSLog(@"%@", font1.fontName);
  NSLog(@"%@", font2.fontName);

  NSLog(@"%f", font1.pointSize);
  NSLog(@"%f", font2.pointSize);

  NSLog(@"%@", font1.fontDescriptor);
  NSLog(@"%@", font2.fontDescriptor);

  return [font1.fontName isEqualToString:font2.fontName] &&
  MDCCGFloatEqual(font1.pointSize, font2.pointSize) &&
  [[font1.fontDescriptor objectForKey:UIFontDescriptorFaceAttribute] isEqual:
   [font2.fontDescriptor objectForKey:UIFontDescriptorFaceAttribute]] &&
  [[font1.fontDescriptor objectForKey:UIFontDescriptorTraitsAttribute] isEqual:
   [font2.fontDescriptor objectForKey:UIFontDescriptorTraitsAttribute]];
}
