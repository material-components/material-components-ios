# Getting started with contributing to MDC iOS

## All contributors

Checklist:

- [ ] [Install git-clang-format](#git-clang-format).

## Core contributors

Checklist:

- [ ] Install https://github.com/material-foundation/github-squash-and-merge-pr-descriptions. This ensures that your pull request's merge commit matches your PR description.

## Installation guides

### git-clang-format

```
# First check to see if you have clang-format installed.
git clang-format -h

# Download the script
curl -s https://raw.githubusercontent.com/llvm-mirror/clang/master/tools/clang-format/git-clang-format -o "git-clang-format"

# Move the script somewhere in your PATH. /usr/local/bin is the recommended default.
sudo mv "git-clang-format" "/usr/local/bin/git-clang-format"

# Ensure that the command is executable
sudo chmod +x "/usr/local/bin/git-clang-format"

# Verify that the command works.
git clang-format -h
```
