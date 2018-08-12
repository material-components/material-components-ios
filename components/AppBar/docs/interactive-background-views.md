### Interactive background views

Scenario: you've added a background image to your App Bar and you'd now like to be able to tap the
background image.

This is not trivial to do with the App Bar APIs due to considerations being discussed in
[Issue #184](https://github.com/material-components/material-components-ios/issues/184).

The heart of the limitation is that we're using a view (`headerStackView`) to lay out the Navigation
Bar. If you add a background view behind the `headerStackView` instance then `headerStackView` will
end up eating all of your touch events.

Until [Issue #184](https://github.com/material-components/material-components-ios/issues/184) is resolved, our recommendation for building interactive background views is the following:

1. Do not use the App Bar component.
2. Create your own Flexible Header. Learn more by reading the Flexible Header
   [Usage](../../FlexibleHeader/#usage) docs.
3. Add your views to this flexible header instance.
4. Create a Navigation Bar if you need one. Treat it like any other custom view.
