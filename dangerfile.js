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

if (!danger.github.pr.title.startsWith("[")) {
  warn('This PR title does not include an affected component.'
    + ' For example: "[SomeComponent] Title. If something is affecting multiple components and the'
    + ' change can\'t be broken up into multiple PRs, then the common trait of the change could be'
    + ' used in the PR title. E.g. `[documentation]`.');
}

let all_files = danger.git.modified_files
  .concat(danger.git.deleted_files)
  .concat(danger.git.created_files);

let component_files = all_files.filter(function(path) {
  path.startsWith('component/')
});
let components = new Set(component_files.map(function(path) {
  var path_parts = path.split('/');
  path_parts.splice(0, 1); // Drop the components/ prefix.
  
  var component_path = [];
  // Convention: lower-case names are directories. Upper-case names are components.
  while (path_parts[0][0] == path_parts[0][0].toLowerCase())) {
    component_path.push(path_parts.splice(0, 1));
  }
  if (path_parts[0][0] == path_parts[0][0].toUpperCase())) {
    component_path.push(path_parts.splice(0, 1));
    return component_path;
  }
  return null;
})).filter(function(path) { return path !== null; });

if (components.length > 1) {
  warn('This PR affects more than one component. Consider splitting it up into smaller PRs if'
  + ' possible. Components found in this PR: '+components.join(", "));
}
