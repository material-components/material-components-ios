# Getting started with being a core contributor to MDC iOS

## Tools that may save you and the team some time

### git-clang-format

This tool allows you to run clang-format on your local changes before they're sent out for review.
This will minimize the amount of style feedback you get from the team and saves everyone time.

```bash
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

### PR description chrome plugin

https://github.com/material-foundation/github-squash-and-merge-pr-descriptions.

This tool ensures that your pull request's merge commit matches your PR description.
