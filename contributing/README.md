# Contributing

The Material Components contributing policies and procedures can be found in the main Material Components documentation repository’s [contributing page](https://github.com/material-components/material-components/blob/develop/CONTRIBUTING.md).


## iOS-specific Additions

The iOS also abides by the following policy items. 


### Code Conventions

MDC follows certain [coding styles and conventions](code-conventions.md) for its code to help
everyone easily read, review, and understand our code. Please follow these conventions when
submitting pull requests.


### Component checklist

All components should pass [these](checklist.md) checks or give a compelling reason why they shouldn’t.

There is a [great script](../scripts/check_components) that checks for _some_ of these criteria. Run it regularly during development. It will also be run by the continuous integration system when you make a pull request. If the script fails at that point, the pull request will be blocked.

### Issue and Pull Request Titles


Start the title with `[ComponentName]` to identify which component a change affects. Use
`[ComponentName|OtherComponentName]` for commits affecting multiple components, which should be rare.

~~~
[FooBar] Removes the deprecated fooWithBar:(Bar*)bar method.
~~~


### Deprecation

See [deprecation_policy.md](deprecation_policy.md) for details.

### Hotfixing

Occasionally it is necessary to hotfix the framework. See [hotfixing.md](hotfixing.md) for details.


## The small print

Contributions made by corporations are covered by a different agreement than the one above, the [Software Grant and Corporate Contributor License Agreement](https://cla.developers.google.com/about/google-corporate).


## Useful Links
- [Contributing](CONTRIBUTING.md)
- [Filing an Issue](ISSUE_TEMPLATE.md)
- [Components Request Policy](COMPONENTS_REQUEST_POLICY.md)
- [Code of Conduct](CONDUCT.md)
- [Stack Overflow](https://www.stackoverflow.com/questions/tagged/material-components) (external site)
- [Material.io](https://www.material.io) (external site)
- [Material Design Guidelines](https://material.google.com) (external site)
