<!--{% if site.link_to_site == "true" %}-->
See <a href="https://material-ext.appspot.com/mdc-ios-preview/components/Tabs/">MDC site documentation</a> for richer experience.
<!--{% else %}See <a href="https://github.com/google/material-components-ios/tree/develop/components/Tabs">GitHub</a> for README documentation.{% endif %}-->

# Tabs

<div class="ios-animation right" markdown="1">
  <video src="docs/assets/tab_bar.mp4" autoplay loop></video>
  [![Tab Bar](docs/assets/tab_bar.png)](docs/assets/tab_bar.mp4)
</div>

Tabs are bars of buttons used to navigate between groups of content.
<!--{: .intro :}-->

### Material Design Specifications

<ul class="icon-list">
  <li class="icon-link">
    <a href="https://material.google.com/components/tabs.html">
      Tabs
    </a>
  </li>
<!--  <li class="icon-link">-->
<!--    <a href="https://material.google.com/components/bottom-navigation.html">-->
<!--      Bottom navigation-->
<!--    </a>-->
<!--  </li>-->
</ul>

- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 9.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the
following to your `Podfile`:

~~~
pod 'MaterialComponents/Tabs'
~~~

Then, run the following command:

~~~ bash
pod install
~~~

- - -

## Overview

When a user taps a tab, the content should change to match the selected subject in the tabs. This is similar to a UITabBarViewController's behavior. But unlike a UITabBarViewController, tabs does not provide an interface for switching the views or view controllers. There is no array of view controllers like UITabBarViewController's array of view controllers.

Rather, the tabs report to their delegate when there is a tab selection. The delegate can then handle the changing of views.

Tabs can also show a badge (usually a number) like UITabBar.

### Component detail

TODO(brianjmoore)

- - -

## Usage

TODO(brianjmoore): Stub out
TODO(willlarche): Flesh out

TODO **Required section**. Provide essential integration steps here.

Remember that the audience for this section is someone completely new to using Material
components; don't assume or expect the reader to have read another component's README. At best
you can assume that the reader read the Quick Start guide.

### Additional information section

TODO **Recommended section**. These breakout sections are a perfect opportunity to talk about
edge case behaviors.
