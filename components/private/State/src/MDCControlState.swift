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

import Foundation

/**
 MDCControlState represents all Material states, including the special interactive
 state, which is any state that is not normal, disabled or error.
 * Eight distinctive states are supported.
 * Material's enabled and pressed states are renamed as their UIControlState state names (which
   is normal and highlighted).
 * We are still experimenting with state combinations. Whther adding names for state combinations
   (like: selectedHighlighted) is needed, is stil in debate.
 */
struct MDCControlState: OptionSet, CustomStringConvertible {

  /// Material names of states
  var name: String {
    switch self {
    case .normal:      return "enabled"
    case .highlighted: return "pressed"
    case .selected:    return "selected"
    case .active:      return "active"
    case .focused:     return "focused"
    case .dragged:     return "dragged"
    case .disabled:    return "disabled"
    case .error:       return "error"

    case .interactive: return "interactive"

    case .selectedHighlighted: return "selected+pressed"
    case .selectedFocused:     return "selected+focused"
    case .selectedDragged:     return "selected+dragged"

    case .activeHighlighted: return "active+pressed"
    case .activeFocused:     return "active+focused"
    case .activeDragged:     return "active+dragged"

    default: return "<undefined>"
    }
  }

  var description: String {
    var state = ""
    if self.contains(.normal) {state += " enabled"}
    if self.contains(.highlighted) {state += " pressed"}
    if self.contains(.selected) {state += " selected"}
    if self.contains(.active) {state += " active"}
    if self.contains(.focused) {state += " focused"}
    if self.contains(.dragged) {state += " dragged"}
    if self.contains(.disabled) {state += " disabled"}
    if self.contains(.error) {state += " error"}
    return String(state.dropFirst())
  }

  /// Converting material states to UIControlStates
  var controlState: UIControlState? {
    switch self {
    case .normal: return .normal
    case .selected: return .selected
    case .disabled: return .disabled
    case .highlighted: return .highlighted
    case .focused:
      if #available(iOSApplicationExtension 9.0, *) {
        return .focused
      } else {
        return nil
      }
    default: return nil
    }
  }

  let rawValue: UInt

  // States enumberations
  static let normal      = MDCControlState(rawValue: 1 << 0)  // Material: Enabled
  static let highlighted = MDCControlState(rawValue: 1 << 1)  // Material: Pressed
  static let selected    = MDCControlState(rawValue: 1 << 2)  // Material: Selected
  static let active      = MDCControlState(rawValue: 1 << 3)  // Material: Active
  static let focused     = MDCControlState(rawValue: 1 << 4)  // Material: Focused
  static let dragged     = MDCControlState(rawValue: 1 << 5)  // Material: Dragged
  static let disabled    = MDCControlState(rawValue: 1 << 6)  // Material: Disabled
  static let error       = MDCControlState(rawValue: 1 << 7)  // Material: Error

  // Grouping all interactive material states (all states excluding normal, disabled & error)
  static let interactive = MDCControlState(rawValue: 1 << 8)

  // "On/Off" state combinations (selected and active are the "On/Off" states).
  static let selectedHighlighted: MDCControlState = [.selected, .highlighted]
  static let selectedFocused: MDCControlState = [.selected, .focused]
  static let selectedDragged: MDCControlState = [.selected, .dragged]

  static let activeHighlighted: MDCControlState = [.active, .highlighted]
  static let activeFocused: MDCControlState = [.active, .focused]
  static let activeDragged: MDCControlState = [.active, .dragged]

  // These are used by the state system to determine which theming to apply for requested states.
  var isSelected: Bool { return self.contains(.selected) }
  var isActive:   Bool { return self.contains(.active) }
  var isHighlighted: Bool { return self.contains(.highlighted) }
  var isFocused:  Bool { return self.contains(.focused) }
  var isDragged:  Bool { return self.contains(.dragged) }

  // Returns true if self is an interactive state (a member of interactiveSet)
  var isInteractive: Bool {
    // TODO: if at least 1 bit in self appears in the interactiveSet - we should return true.
    //       currently it returns true only if all bits appear in interactiveSet.
    let interactiveSet: MDCControlState =
        [.selected, .active, .highlighted, .focused, .dragged]
    return interactiveSet.contains(self)
  }
}
