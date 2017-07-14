# Code formatting tools

## Objective-C and clang-format

We use [clang-format](http://clang.llvm.org/docs/ClangFormat.html) to automatically format our
Objective-C code. If you're going to be contributing more than a few one-off patches, then to reduce
the time it takes to reveiw code, we suggest installing clang-format as an Xcode plugin and have it
format your code whenever you write to disk.

### Installing clang-format

You can install clang-format via [Brew](http://brew.sh/) by running
`scripts/install/install_clang_format`.

### Installing the Xcode plugin

You can install
[Travis Jeffery's clang-format Xcode plugin](https://github.com/travisjeffery/ClangFormat-Xcode)
by following his
[installation instructions](https://github.com/travisjeffery/ClangFormat-Xcode#installation).

Once you've installed it configure it in Xcode:

1.  `Edit > Clang Format > File` to use MDC's particular clang-format configuration file.
1.  `Edit > Clang Format > Use System ClangFormat` to ensure that you're using the same version of
clang-format as we are.
