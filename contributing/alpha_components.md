# Alpha program for components

The intent of the Alpha program is to provide a place for component code to land that may not be
fully ready for production, but for which we still want active collaboration with the team and
potentially some early adoption with select clients.

Any new component that we implement will first land in the `MaterialComponentsAlpha.podspec` as a
subspec, similar to how components are defined in the `MaterialComponents.podspec`.

Alpha components will appear in MDCCatalog and MDCDragons along with all of their examples and unit
tests after a pod install. From the point of view of our catalogs, these components are just like
any other.

From the point of view of the public, Alpha components are not made available as part of our
published pod. External clients that wish to use an Alpha component in their app will need to
manually clone the repo and add the code to their project. This is by design.

Alpha components are not subject to our deprecation policy and we will not provide behavioral flags
for gradual migration of runtime behaviors.

Changes to Alpha components will have **no** effect on our release version numbers.

Once a component is ready for general production use, we will graduate the component to the
`MaterialComponents.podspec`. At this point the component will be subject to all of the processes
and expectations that any other production component.

## Import statements

Swift import statements for alpha components follow the pattern `MaterialComponentsAlpha.<#ComponentName#>`.

## Component README.md

The component's README.md should include the following near the top of the document:

```
## Alpha component

This component is an [alpha component](../../contributing/alpha_components.md). This means the API is
subject to change without notice. To use this component, you must manually clone the
material-components-ios repo and add the following to your Podfile:

    pod 'MaterialComponentsAlpha', :path => 'path/to/material-components-ios'
```
