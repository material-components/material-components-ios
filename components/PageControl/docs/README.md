# Page control

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/page_control.png" alt="Page control" width="375">
</div>

This control is designed to be a drop-in replacement for `UIPageControl`, with a user experience
influenced by Material Design specifications for animation and layout. The API methods are the
same as a `UIPageControl`, with the addition of a few key methods required to achieve the
desired animation of the control.

<!-- design-and-api -->

<!-- toc -->

- - -

## Overview

`MDCActivityIndicator` is a view that has two modes: indeterminate and determinate. Indeterminate
indicators express an unspecified wait time, while determinate indicators represent the length of a
process. Activity indicators are indeterminate by default.

<img src="docs/assets/MDCPageControl_screenshot-1.png" alt="screenshot-1" width="375">
<!--{: .article__asset.article__asset--screenshot }-->
Page control showing current page in resting state.

<img src="docs/assets/MDCPageControl_screenshot-2.png" alt="screenshot-2" width="375">
<!--{: .article__asset.article__asset--screenshot }-->
Page control showing animated track with current page indicator positioned along the track.

<img src="docs/assets/MDCPageControl_screenshot-3.png" alt="screenshot-3" width="375">
<!--{: .article__asset.article__asset--screenshot }-->
Page control showing new current page.

## Installation

- [Typical installation](../../../docs/component-installation.md)

## Usage

- [Typical use](typical-use.md)
- [Differences from UIPageControl](differences-from-uipagecontrol.md)

## Extensions

- [Color Theming](color-theming.md)
