# Deprecation policy

The ability to deprecate features, components and paradigms is essential to the health of this project. 

However, the price paid in disruption and maintenance is real; deprecating without warning, too often,
or for poor rationale is a hinderance to adoption and contribution. It must be done with care and
process.

Before embarking on the deprecation of any API we should collaboratively answer the following questions:

1. Should this code be deprecated? Is the effort required to deprecate this component worth the benefit
   of removing the old behavior?
1. Why is the code being deprecated? Why should clients switch?
1. What are clients supposed to replace the code with?
1. What is a good deprecation timeline?
1. Who is responsible for the deprecation plan?

## Our deprecation process (Non-Googlers)

If you would like to propose that an API be deprecated please
[file a bug](https://github.com/material-components/material-components-ios/issues/new/choose)
explaining which API you'd like deprecated. A Googler will take the issue from there by following
the deprecation process below.

## Our deprecation process (Googlers)

1. Measure internal usage of the API.
2. Create a GitHub issue.
3. Write a migration guide.
4. Add a comment to the API indicating that it will be deprecated.
5. Determine a schedule for the API deletion.
6. Announce that the API will be deprecated
7. After the deprecation date, annotate the API as deprecated.
8. After the deletion date, re-evaluate usage of the API.
9. Delete the API and migration guide.

### Step 1: Measure internal usage of the API

Read [go/mdc-ios-measuring-api-usage](http://go/mdc-ios-measuring-api-usage) to learn how to measure
API usage internally.

If there is zero API usage beyond our own library: skip to step 7 (Deprecate the API).
Otherwise, proceed to step 2.

### Step 2: Create a GitHub issue

Create a GitHub issue with the following template:

```
- [x] Measure internal usage of the API.
- [x] Create a GitHub issue.
- [ ] Write a migration guide.
- [ ] Add a comment to the API indicating that it will be deprecated.
- [ ] Determine a schedule for the API deletion.
- [ ] Announce that the API will be deprecated
- [ ] After the deprecation date, annotate the API as deprecated.
- [ ] After the deletion date, re-evaluate usage of the API.
- [ ] Delete the API and migration guide.
```

### Step 3: Write a migration guide

This guide should be placed in the component's docs/ folder and have a prefix `migration-guide-`.

For example, `migration-guide-appbar-appbarviewcontroller.md` is a guide from MDCAppBar to
MDCAppBarViewController.

Send this migration guide out for review as a standalone pull request.

### Step 4: Add a comment to the API indicating that it will be deprecated.

Add a `@warning` annotation to the API's public documentation indicating the intent for this API to
eventually be deprecated. This warning should also provide a short suggested alternative, if one
exists, and a link to the migration guide.

For example:

```objc
@warning This method will soon be deprecated. Consider using
@c +applySemanticColorScheme:toFlexibleHeaderView: instead. Learn more at
components/schemes/Color/docs/migration-guide-semantic-color-scheme.md
```

If the API to be deprecated is a method or property of a class, also move the API to a category
named `ToBeDeprecated`. This will cause the API to show up in our release notes automatically as
a to-be-deprecated API.

For example:

```objc
@interface MDCAppBarContainerViewController (ToBeDeprecated)

/**
 The App Bar views that will be presented in front of the contentViewController's view.

 @warning This API will eventually be deprecated. Use appBarViewController instead. Learn more at
 components/AppBar/docs/migration-guide-appbar-appbarviewcontroller.md
 */
@property(nonatomic, strong, nonnull, readonly) MDCAppBar *appBar;

@end
```

### Step 5: Determine a schedule for the API deletion

Generally speaking deprecations take a long time unless you take an active part in migrating
clients. Calculate your estimates with this in mind. A rough guideline:

- small changes can often be done in a month.
- larger changes can be done in a quarter/three months.

Adjust up or down based on the usage of the to-be-deprecated API and the complexity of the
migration guide.

Sanity check your estimate with a team member before moving on to the next step.

Assuming that you’re looking at a one-month deprecation, then the schedule looks roughly like
this:

1. *T minus 4 weeks*: Deprecation is announced but no breaking or behavior changes are
introduced.
1. *T minus 3 weeks*: Old code is marked as deprecated, generating warnings.

A three-month deprecation is similar with more time for clients to adjust code:

1. *T minus 12 weeks*: Announce.
1. *T minus 9 weeks*: Mark code as deprecated.

Map this schedule onto reality: 

1. Is there a holiday/conference coming up that would prevent clients from being able to
   collaborate and comment? 
1. Is the to-be-replaced code particularly problematic for some reason? 
1. Does the deprecation fall near a release of the operating system or new devices?

**Once you have determined a schedule, add the schedule to the migration guide**.

### Step 6: Announce that the API will be deprecated

Inform internal clients of the impending deprecation by sending an email with the following
format:

```
Subject: YYY will eventually be deprecated.
Body:
YYY will eventually be deprecated. Please see <link to migration guide> for more details.

The timeline for this deprecation is as follows:

- <Deprecation date>: The API will be formally marked as deprecated. You will start receiving
  build warnings if you are still using the deprecated API.
- <Deletion date>: The API will be deleted.
```

### Step 7: After the deprecation date, annotate the API as deprecated

Send a pull request annotating the API as deprecated. Use `__deprecated_msg("")` and provide a
concise message with a recommendation for an alternative API, if any is available.

### Step 8: After the deletion date, re-evaluate usage of the API

Once the deletion date has passed and at least one release has been cut since the API was marked as
deprecated, you can now consider deleting the API. But first: you must evaluate whether the API is
being used by any internal clients.

If the API is still being used by clients, you have a few options:

- Reach out to the client teams directly, reminding them of the deprecation.
- Help the client teams migrate.

Proceed to step 9 once you've confirmed that there are zero internal usages of the API.

### Step 9: Delete the API and migration guide

Once you have confirmed that there is no internal usage of the API, you can safely delete it and the migration guide.

Send a pull request deleting the API, marking your "Delete YYY" issue as closed.

## Addendum

### Versioning

Adding the deprecation *warning* (no breaking change) is a minor version bump.

Actually changing the code (breaking change) is a major version bump.

Changes that don't break anyone (or change behavior surprisingly) don't need a deprecation.

### Compiler warnings

If you are treating warnings as errors in your application via the `-Werror` compiler flag, you
may need to disable this functionality for deprecated code warnings.

This can be done by adding the `-Wno-error=deprecated` and `-Wno-error=deprecated-implementations`
compiler flags to your application target via an .xcconfig or under "Other C Flags" in your Build
Settings. Xcode will still issue the warning during compilation, but they will not be treated as
errors.
