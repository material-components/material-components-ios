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

## Deprecation process

If you would like to propose that an API be deprecated please
[file a bug](https://github.com/material-components/material-components-ios/issues/new/choose)
explaining which API you'd like deprecated. Googlers can read more at go/material-ios-deprecation-process
