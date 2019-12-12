# Beta program for components

The intent of the Beta program is to provide a place for component code to land that may not be
fully ready for production, but for which we still want active collaboration with the team and
potentially some early adoption with select clients.

Any new component that we implement will first land in the `MaterialComponentsBeta.podspec` as a
subspec, similar to how components are defined in the `MaterialComponents.podspec`.

Beta components will appear in MDCCatalog and MDCDragons along with all of their examples and unit
tests after a pod install. From the point of view of our catalogs, these components are just like
any other.

From the point of view of the public, Beta components are not made available as part of our
published pod. External clients that wish to use an Beta component in their Podfile will need to
manually specify the MaterialComponentsBeta target and our repo.

Because the Beta components are pointing to the `HEAD` of the `develop` branch, you need to also update your MaterialComponents pod to point to `develop` as well.

```
   pod 'MaterialComponents', :git => 'https://github.com/material-components/material-components-ios.git', :branch => 'develop'
   pod 'MaterialComponentsBeta', :git => 'https://github.com/material-components/material-components-ios.git'
```
When the component graduates to "Ready" clients will need to change their specs to point at the main pod.

Beta components are not subject to our deprecation policy and we will not provide behavioral flags
for gradual migration of runtime behaviors.

Changes to Beta components will have **no** effect on our release version numbers.

Once a component is ready for general production use, we will graduate the component to the
`MaterialComponents.podspec`. At this point the component will be subject to all of the processes
and expectations that any other production component.

## Import statements

Swift import statements for Beta components follow the pattern `MaterialComponentsBeta.<#ComponentName#>`.

## Component README.md

The component's README.md should include the following near the top of the document:

```
## Beta component

This component is an [Beta component](../../contributing/beta_components.md). This means the API is
subject to change without notice and without incrementing major/minor version numbers. To use this
component add the following to your Podfile:

    pod 'MaterialComponentsBeta', :path => 'https://github.com/material-components/material-components-ios.git'
```
