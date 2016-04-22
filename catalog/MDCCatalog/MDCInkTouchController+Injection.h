/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

#import "MaterialInk.h"

@interface MDCInkTouchController (ManyInkViews)

/**
 Enumerates the given view's subviews for an instance of MDCInkView and returns it if found, or
 creates and adds a new instance of MDCInkView if not.

 This method is a convenience method for adding ink to an arbitrary view without needing to subclass
 the target view. Use this method in situations where you expect there to be many distinct ink views
 in existence for a single ink touch controller. Example scenarios include:

 - Adding ink to individual collection view/table view cells

 This method can be used in your MDCInkTouchController delegate's
 -inkTouchController:inkViewAtTouchLocation; implementation.
 */
+ (nonnull MDCInkView *)injectedInkViewForView:(nonnull UIView *)view;

@end
