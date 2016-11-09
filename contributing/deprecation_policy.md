# Deprecation policy

The ability to deprecate features, components and paradigms is essential to the health of this project. 

However, the price paid in disruption and maintenance is real; deprecating without warning, too often, or for poor rationale is a hinderance to adoption and contribution. It must be done with care and process.

## Get the 'thumbs up'

Propose your deprecation on GitHub as an issue where the title's first phrase is "Deprecation [Component Name]". Much like a feature proposal, the contributors have a responsibility to carefully judge the consequences of breaking changes against possible gains. 

We should collaboratively answer the following questions:

1. Should this code be deprecated? Is it really worth the time and effort for everyone?
1. Why is the code being deprecated? Why should clients switch?
1. What are clients supposed to replace the code with?
1. What is a good deprecation timeline?
    1. Small changes can be done in a month.
    1. Larger changes can be done in a quarter/three months.
    1. Adjust up or down based on the size/complexity of the change.
1. Who’s on point? It’s good to have a single person to keep track of things.

## Make sure replacement code is ready

1. Has the catalog been updated to use and demo it? 
1. Is the new code documented in the headers and site?

## Pin down the schedule

Assuming that you’re looking at a one-month deprecation, then the schedule looks roughly like this:

1. *T minus 4 weeks*: Deprecation is announced but no breaking or behavior changes are introduced.
1. *T minus 3 weeks*: Old code is marked as deprecated, generating warnings.

A three-month deprecation is similar with more time for clients to adjust code:

1. *T minus 12 weeks*: Announce.
1. *T minus 9 weeks*: Mark code as deprecated.

Map this schedule onto reality: 

1. Is there a holiday/conference coming up that would prevent clients from being able to collaborate and comment? 
1. Is the to-be-replaced code particularly problematic for some reason? 
1. Does the deprecation fall near a release of the operating system or new devices?

## Do the work

Before announcing the deprecation, create an issue in GitHub that represents it. That issue will stay open until the deletion PR is submitted.

TODO: Include announcement instructions. Generally, this is done via blog.

Deprecate APIs using the macro provided by Apple in AvailabilityMacros.h that includes a message:
* DEPRECATED_MSG_ATTRIBUTE(msg)

This macro requires an explanation string which should be similar to: ”This API will be removed on D/M/YYYY. Please use XYZ instead. See issue #n for more details.”

For any code that should be eventually deleted, add the following comment nearby to make it easier to find and remove the code: // DEPRECATION(github.com/google/material-components-ios/issues/n)

Once you submit the breaking PR, don’t immediately pile on subsequent PRs that would conflict with an emergency rollback.

## Versioning

Adding the deprecation *warning* (no breaking change) is a minor version bump.

Actually changing the code (breaking change) is a major version bump.

Changes that don't break anyone (or change behavior surprisingly) don't need a deprecation.

## Checklist

This is an idealized summary of how to replace old code with new code.

1. Create an alternative.
    1. Discuss the reasoning via GitHub issue.
    1. Discuss the change via GitHub pull request.
1. Publicize and do the deprecation.
    1. Document the old code so new users don’t start using it.
    1. Create a breaking change schedule. 
    1. Mark the old code as deprecated.
1. Clean up
    1. Delete the old code.
    1. Close the issue.
    1. Release

## Compiler warnings

If you are treating warnings as errors in your application via the `-Werror` compiler flag, you may need to disable this functionality for deprecated code warnings.

This can be done by adding the `-Wno-error=deprecated` and `-Wno-error=deprecated-implementations` compiler flags to your application target via an .xcconfig or under "Other C Flags" in your Build Settings. Xcode will still issue the warning during compilation, but they will not be treated as errors.
