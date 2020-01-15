#!/bin/bash
#
# Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Returns a list of private component directories.
private_components() {
  echo "Application"
  echo "Beta"
  echo "Color"
  echo "Dragons"
  echo "Icons"
  echo "KeyboardWatcher"
  echo "Math"
  echo "Overlay"
  echo "Snapshot"
  echo "ThumbTrack"
  echo "UIMetrics"
}

NUMBER_OF_FILES=$(($# / 2))
for i in $(seq 1 $NUMBER_OF_FILES); do
  src_index=$i
  dst_index=$(($i + $NUMBER_OF_FILES))
  src_path=${!src_index}
  dst_path=${!dst_index}

  # Copy the file over, making adjustments along the way.
  cat "$src_path" > "$dst_path"

  #
  # Note: Swift imports need to be rewritten using the bazel module naming convention.
  # In essence, each target maps to its bazel target path with / and : symbols replaced by _
  # symbols.
  # E.g. //components/AppBar:AppBar becomes components_AppBar_AppBar
  #

  # First, rewrite all imports with an unambiguous suffix:
  perl -pi -e "s/import MaterialComponents.MaterialIcons_(.+)/import components_private_Icons_icons_\1_\1/" "$dst_path"
  perl -pi -e "s/import MaterialComponents.Material(.+)_Private/import components_\1_Private/" "$dst_path"
  perl -pi -e "s/import MaterialComponents.Material(.+)_(.+)/import components_\1_\2/" "$dst_path"
  perl -pi -e "s/import MaterialComponentsBeta.Material(.+)Beta/import components_\1_\1Beta \/\/ BetaSplit/" "$dst_path"
  perl -pi -e "s/import MaterialComponents.Material(.+)Scheme/import components_schemes_\1_\1/" "$dst_path"
  perl -pi -e "s/import CatalogByConvention/import catalog_by_convention_CatalogByConvention/" "$dst_path"
  perl -pi -e "s/import MDFInternationalization/import material_internationalization_ios_MDFInternationalization/" "$dst_path"
  perl -pi -e "s/import MDFTextAccessibility/import material_text_accessibility_ios_MDFTextAccessibility/" "$dst_path"

  # Then, because our private component headers can't be distinguished from a generic import, we
  # explicitly rewrite them first.
  private_components | while read private_component; do
    if [ -z "$private_component" ]; then
      continue
    fi
    perl -pi -e "s/import MaterialComponents.Material$private_component\b/import components_private_${private_component}_${private_component}/" "$dst_path"
  done

  # Finally, rewrite all generic imports.
  perl -pi -e "s/import MaterialComponentsBeta.Material(.+)_(.+)/import components_\1_\2 \/\/ Beta/" "$dst_path"
  perl -pi -e "s/import MaterialComponentsBeta.Material(.+)/import components_\1_\1 \/\/ Beta/" "$dst_path"
  perl -pi -e "s/import MaterialComponents.Material(.+)/import components_\1_\1/" "$dst_path"
done
