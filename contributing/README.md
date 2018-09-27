<!--docs:
title: "Contributing"
layout: landing
section: docs
path: /docs/contributing/
-->

# General Contributing Guidelines

The Material Components contributing policies and procedures can be found in the main Material Components documentation repository’s [contributing page](https://github.com/material-components/material-components/blob/develop/CONTRIBUTING.md).

## iOS-specific Additions

The iOS team also abides by the following policy items:

### Code Conventions

MDC follows certain [coding styles and conventions](code-conventions.md) for its code to help
everyone easily read, review, and understand our code. Please follow these conventions when
submitting pull requests.

### Component Checklist

All components should pass [these](checklist.md) checks or give a compelling reason why they shouldn’t.

There is a [great script](../scripts/check_components) that checks for _some_ of these criteria. Run it regularly during development. It will also be run by the continuous integration system when you make a pull request. If the script fails at that point, the pull request will be blocked.

### Issue and Pull Request Titles

Start the title with `[ComponentName]` to identify which component a change affects. Use
`[ComponentName|OtherComponentName]` for commits affecting multiple components, which should be rare.

```
[FooBar] Removes the deprecated fooWithBar:(Bar*)bar method.
```

### Pull request continuous integration for new contributors

Continuous integration will only be initiated automatically for the [core team](https://github.com/orgs/material-components/teams/core-ios-team/members)
and [recognized collaborators](https://github.com/orgs/material-components/teams/recognized-ios-collaborators/members).

All other pull requests must be labeled with `kokoro:force-run` by a member of the repo
with write access in order for continuous integration to be initiated. This label must
be added again each time the pull request has new commits pushed to it.

For Googlers: [b/115490922](http://b/115490922) is tracking making the above work more streamlined for new contributors.

#### Using assignee to indicate who should action on a PR

Since PRs on github permanently stay in the `Changes requested` state it is hard to tell when the author has addressed the concerns. By change the assignee to whomever still needs to action (review or modify/justify) we can more easily keep track of what needs attention in our PR queues.

1. For a reviewer this means adding the author as an assignee once the review is finished.
1. For an author it means adding back the reviewer (and removing themselves) as an assignee.


### Deprecation

See [deprecation_policy.md](deprecation_policy.md) for details.

## Finding an issue to work on

MDC-iOS uses GitHub to file and track issues.
To find an issue to work on, filter the issues list by the ["is:fixit" label](https://github.com/material-components/material-components-ios/labels/is%3Afixit).

## The small print

Contributions made by corporations are covered by a different agreement than the one above, the [Software Grant and Corporate Contributor License Agreement](https://cla.developers.google.com/about/google-corporate).

- - -

## Useful Links

- [How To Use MDC-iOS](../docs/)
- [All Components](../components/)
- [Demo Apps](../demos/)
- [MDC-iOS on Stack Overflow](https://www.stackoverflow.com/questions/tagged/material-components+ios) (external site)
- [Material.io](https://material.io) (external site)
- [Material Design Guidelines](https://material.io/guidelines) (external site)
