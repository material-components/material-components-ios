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

#import <UIKit/UIKit.h>

/**
 Shorthand for returning a resource of any type from MDCCollectionCellResources's singleton.
 */
#define MDCCollectionCellResources(sel) [[MDCCollectionCellResources sharedInstance] sel]

/** Resources that are used for collection views. */
@interface MDCCollectionCellResources : NSObject

/** Returns the shared resources singleton instance. */
+ (nonnull instancetype)sharedInstance;

/** Returns cell accessory check image. */
- (nonnull UIImage *)imageForCellAccessoryCheck;

/** Returns cell accessory chevron right image. */
- (nonnull UIImage *)imageForCellAccessoryChevronRight;

/** Returns cell accessory info image. */
- (nonnull UIImage *)imageForCellAccessoryInfo;

/** Returns cell editing delete image. */
- (nonnull UIImage *)imageForCellEditingDelete;

/** Returns cell editing reorder image. */
- (nonnull UIImage *)imageForCellEditingReorder;

/** Returns cell editing selected image. */
- (nonnull UIImage *)imageForCellEditingSelected;

/** Returns cell editing unselected image. */
- (nonnull UIImage *)imageForCellEditingUnselected;

@end
