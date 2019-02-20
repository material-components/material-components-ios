// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import <MaterialComponents/MDCCardCollectionCell+Private.h>
#import <MaterialComponents/MaterialCards.h>

/**
 This category implements the MDCCardCollectionCellRippleDelegate protocol to integrate Ripple
 and the states implementation that Ripple provides into the Card component.
 The reason for not implementing this code directly into the MDCCardCollectionCell implementation
 file is because Ripple is still a Beta component and therefore shouldn't be directly integrated
 into Cards, a ready component.
 */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@interface MDCCardCollectionCell (Ripple) <MDCCardCollectionCellRippleDelegate>
@end
#pragma clang diagnostic pop
