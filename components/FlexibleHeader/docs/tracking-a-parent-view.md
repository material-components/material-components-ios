### Tracking a parent view

While we do not recommend it, there are situations in which the trackingScrollView will be the
parent view of the Flexible Header's view. The most notable example is UITableViewController, whose
`view` **is** the UITableView instance, so there is no other view to register the tracking scroll
view to.

As you might expect, this situation causes the Flexible Header to scroll off-screen with the scroll
view regardless of the Flexible Header's scrolling behavior. To counter this, the Flexible Header
sets its `transform` to an inversion of the current `contentOffset`. This gives the illusion of
the Flexible Header staying fixed in place, even though the underlying scroll view is scrolling.

In these situations the Flexible Header also ensures that it is always the front-most view. This is
to combat the UITableView displaying its divider lines in front of the Flexible Header.
