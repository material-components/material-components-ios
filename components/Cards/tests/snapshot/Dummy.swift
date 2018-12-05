// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

/** This is a dummy swift file to ensure Snapshot tests compile. It can be removed once a snapshot
 *  test class exists that is written in Swift. The issue I ran into was the following linker error:
 *      library not found for -lswiftSwiftOnoneSupport
 *
 *  I arrived at this solution from the following links:
 *    https://forums.developer.apple.com/thread/88451
 *    https://github.com/CocoaPods/CocoaPods/issues/7170
 *
 *  It appears that Xcode test targets require at least one Swift file in order to include the
 *  swift runtime.
 */

import Foundation
