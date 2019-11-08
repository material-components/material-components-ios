## Publish the official release

> Have all release-blocking clients given the go-ahead? **Do not create the official release
> until all release-blocking clients are ready**. Otherwise you might publish a release that
> isn't actually stable.

You can now publish the release to GitHub:

    scripts/release publish <version>

## Publish to Cocoapods

    git checkout stable
    pod trunk push MaterialComponents.podspec --skip-tests --allow-warnings

## Coordinate with release-blocking clients to finish work

Any work that was started by the [Release-blocking clients](#release-blocking-clients)
(dragon) step above may need to be finalized.

Also follow last instructions in the [internal release instructions](http://go/mdc-releasing)