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

const {danger, warn, fail} = require('danger')

// Danger.js documentation: http://danger.systems/js/

// Check for PRs having a [ ] at the beginning of their title.

if (!danger.github.pr.title.startsWith("[")) {
  warn('This PR title does not include an affected component.'
    + ' For example: "[SomeComponent] Title. If something is affecting multiple components and the'
    + ' change can\'t be broken up into multiple PRs, then the common trait of the change could be'
    + ' used in the PR title. E.g. `[documentation]`.');
}

// Check for PRs that modify multiple components.

let all_files = danger.git.modified_files
  .concat(danger.git.deleted_files)
  .concat(danger.git.created_files);

// Extract any component source modifications.
let component_files = all_files.filter(function(path) {
  return path.startsWith('components/') && path.indexOf('/src') >= 0;
});

// Generate a list of unique components that have been modified.
let components = Array.from(new Set(component_files.map(function(path) {
  var path_parts = path.split('/');
  path_parts.splice(0, 1); // Drop the components/ prefix.
  
  var component_path = [];
  // Convention: all-lower-case names are directories, e.g. `components/private/`.
  // Capitalized names are components, e.g. `BottomNavigation`.
  // We want to get the full path up to and including the first component folder.
  while (path_parts[0][0] == path_parts[0][0].toLowerCase()) {
    component_path.push(path_parts.splice(0, 1));
  }
  // Only return a string if we actually found a component folder
  // (the string starts with an uppercase character).
  var first_character = path_parts[0][0];
  if (first_character == first_character.toUpperCase()) {
    component_path.push(path_parts.splice(0, 1));
    return component_path.join('/');
  }
  return null;
}).filter(function(path) { return path !== null; })));

if (components.length > 1) {
  warn('This PR affects more than one component. Consider splitting it up into smaller PRs if'
  + ' possible. Components found in this PR: '+components.join(", ")+'.');
}
