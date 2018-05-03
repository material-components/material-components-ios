### Differences From UIPageControl

This page control provides an animation effect that keeps a page indicator in sync with the
scrolling of a designated scroll view. This is in contrast to a native `UIPageControl`, which
shows the current page indicator without any animated transitions between changes.

As the user scrolls, a track will be drawn with animation from the current indicator position
towards the next indicator position that is being scrolled towards. The current indicator will
float along this track and position itself based on the percent scrolled between the pages.
When the scroll view finishes scrolling, the track will disappear with animation towards the
final position of the new page.
