# Documenting a new component

Components are the basic organizational unit in Material Components for iOS. When a new component is
added, its documentation needs to be inserted in various places in the repo and on the web site.

## What you'll need

1. The component's code,
1. A relevant reference to the spec,
1. A demo video,
1. A screenshot,
1. A short one-line description of the component.
1. An icon for the [component list](https://material-ext.appspot.com/mdc-ios-preview/components/).
   This can be omitted at first but be sure to follow up with a team member to get it generated.

Check the other components for good examples of the above.

## Steps to document the component

1. Add the component itself to `components/<name>` using the existing component structure.
1. Write a README.md for the component in `components/<name>/README.md`.
1. Add an entry for the new component to the list in `components/README.md`.
1. Capture visual assets:
   1. A short demo video in `components/<name>/docs/assets/<name>.mp4`.
   1. A screenshot in `components/<name>/docs/assets/<name>.png`.
1. Run `scripts/generate_jazzy_yamls.sh` to generate `components/<name>/.jazzy.yaml`, the
   configuration for [Jazzy](https://github.com/realm/jazzy), our code documentation generator.
1. Create a YAML prefix file in `components/<name>/.jekyll_prefix.yaml`:
   ~~~
   ---
   title:  "Activity Indicator"
   layout: detail
   section: components
   excerpt: "Progress and activity indicators are visual indications of an app loading content."
   --- 
   ~~~
