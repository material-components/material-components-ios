# Tools that may save you and the team some time

## git-clang-format

This tool allows you to run clang-format on your local changes before they're sent out for review.
This will minimize the amount of style feedback you get from the team and saves everyone time.

```bash
# Check to see if you have clang-format command installed.
# If not, get the latest release from https://github.com/material-foundation/clang-format/releases
clang-format -version

# Check to see if you have git's clang-format command installed.
git clang-format -h

# Download the script
curl -s https://raw.githubusercontent.com/llvm-mirror/clang/c510fac5695e904b43d5bf0feee31cc9550f110e/tools/clang-format/git-clang-format -o "git-clang-format"

# The expected SHA is 1f6cfad79f90ea202dcf2d52a360186341a589cdbfdee05b0e7694f912aa9820
# Verify the SHA by running the following:
openssl sha -sha256 git-clang-format

# Move the script somewhere in your PATH. /usr/local/bin is the recommended default.
sudo mv "git-clang-format" "/usr/local/bin/git-clang-format"

# Ensure that the command is executable
sudo chmod +x "/usr/local/bin/git-clang-format"

# Verify that the command works.
git clang-format -h
```

## PR description chrome plugin

https://github.com/material-foundation/github-squash-and-merge-pr-descriptions.

This tool ensures that your pull request's merge commit matches your PR description.
