#!/bin/sh

set -euo pipefail
IFS=$'\n\t'

SRC_PATH="Material Components/"
TEMPLATE_DIR="${HOME}/Library/Developer/Xcode/Templates/Project Templates/Material Components"

mkdir -p $TEMPLATE_DIR
rsync -avz $SRC_PATH $TEMPLATE_DIR

# success
echo "Material Components project template successfully installed!"
echo "To use the template, create a new project as follows:"
echo "    File > New > Project > iOS > Material Components"
