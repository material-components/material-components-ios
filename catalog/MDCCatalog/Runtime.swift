/*
Copyright 2015-present Google Inc. All Rights Reserved.

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

import Foundation

/** Returns a list of all classes available to the runtime. */
func getAllClasses() -> [AnyClass] {
  let numberOfClasses = Int(objc_getClassList(nil, 0))
  let allClasses = UnsafeMutablePointer<AnyClass?>.alloc(numberOfClasses)
  let autoreleasingAllClasses = AutoreleasingUnsafeMutablePointer<AnyClass?>(allClasses)
  let actualNumberOfClasses = Int(objc_getClassList(autoreleasingAllClasses, Int32(numberOfClasses)))

  var classes = [AnyClass]()
  for i in 0 ..< actualNumberOfClasses {
    if let currentClass = allClasses[i] {
      classes.append(currentClass)
    }
  }

  allClasses.dealloc(numberOfClasses)

  return classes
}

func classesRespondingToSelector(selector: Selector) -> [AnyClass] {
  return getAllClasses().filter {
    let className = NSStringFromClass($0)
    if className == "SwiftObject" || className == "Object" || className.hasPrefix("Swift.") ||
          className.hasPrefix("_") || className.hasPrefix("JS") || className == "NSLeafProxy" ||
          className == "FigIrisAutoTrimmerMotionSampleExport" {
      return false
    }
    return $0.respondsToSelector(selector)
  }
}
