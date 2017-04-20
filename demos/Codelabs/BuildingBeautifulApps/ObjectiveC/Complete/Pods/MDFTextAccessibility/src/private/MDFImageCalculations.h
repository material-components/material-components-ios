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

#if defined(__cplusplus)
extern "C" {
#endif

/**
 Return the average color of an image in a particular region.

 The region will be intersected with the image's bounds. If the resulting region is empty (or the
 input region was null) then this function returns nil.

 @param image The image to examine.
 @param region The region of the image to average, or CGRectInfinite for the entire image.
 @return The average color, or nil if the region was invalid.
 */
UIColor *MDFAverageColorOfOpaqueImage(UIImage *image, CGRect region);

#if defined __cplusplus
}  // extern "C"
#endif
