<!--docs:
title: "Frequently Asked Questions"
layout: landing
section: docs
path: /docs/faq/
-->

# Frequently Asked Questions

### How do we stay true to our brand while using Material Design?

Material Design doesn’t imply a specific style. There are many good examples of products that have adopted Material Design while maintaining their brand identity. Brand-wise, working with Material Design is similar to working with Apple's built-in UIKit on iOS.

### Can we keep our own branding and styles if we use Material Components for iOS in our app?

Absolutely. Material was developed to be a starting point for designers and developers to enhance their identity. We understand branding is always case by case, so MDC offers a range of components that you can adopt, from highly visual to almost completely structural.

### We don’t want to use Roboto.

Roboto is not required for Material Design. The Typography component defaults to using Apple's system font.

### Will we risk not being featured by Apple anymore if we use MDC-iOS?

Apple features good products with good design and apps using MDC-iOS have been featured.

### What’s the benefit for us if we implement Material Components for iOS on our app?

Reduced developer time and a consistent design system applied to your UI.

### What’s in it for Google if we implement Material Components for iOS on our app?

We believe in making great design accessible to developers, and we believe that Material Design can contribute to great design across platforms. This has been available to our internal iOS teams and we are excited to open source it to external developers. In addition, we’re really excited to engage with the iOS developer community and think that Material Design can be better by getting it into the hands of more developers in the open source community.

### We believe that visually coherent UI is very important to our users, so we adhere to Apple's platform design.

We completely agree about coherent UI; Apple's components are a great starting point. MDC offers a set of components that range from structural, programmer-only conveniences to more visually opinionated components such as sliders and switches. The flexible header component is a good example of a UI element that is widely used, complements Apple's native components, and can reduce engineering time by providing a production-ready experience.

### We don't want our iOS app to stand out as looking like a Google app.

Google's own use of Material Design is customized to give the experience of a "Google app." Your use of Material Design should provide an experience unique to your brand and identity.

### What happens when Apple implements new features in iOS in general and UIKit in particular? How long will it take for Google to support the new features / adjust to any breaking APIs?

We learn about upcoming API breakages in UIKit as early as everyone else through the preview builds Apple makes available, but typically we have enough time to accommodate for any changes or API breakages. Since MDC for iOS builds upon UIKit and most new iOS features are higher level features that happen outside of UIKit, we typically don’t experience any major issues.

### How large is the upload size of the library?

The size of different components vary from a just a few to a few hundred
kilobytes.  If you import all the components, the size of your app
will increase by less than 3 megabytes. However, you don't have to add the
entire library!  You can add as many or as few of the 25+ individual
components as you like. The average (arithmetic mean) of all public components
is a little over 200 KB (about 200 KiB).

### Can we use Material Components for iOS with storyboards?

Yes! Storyboards and nibs/xibs are great places to use Material Components for iOS. Almost every component has support for Interface Builder development that includes IBDesignable. **Note:** IBInspectable support is not where it conflicts with UIAppearance support.
