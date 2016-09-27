<!--{% if site.link_to_site == "true" %}-->
See <a href="https://material-ext.appspot.com/mdc-ios-preview/howto/faq/">MDC site documentation</a> for richer experience.
<!--{% else %}See <a href="https://github.com/google/material-components-ios/tree/develop/howto/faq">GitHub</a> for README documentation.{% endif %}-->

# Frequently Asked Questions

- - -

### How do we stay true to our brand while using material design?

Material design doesn’t imply a specific style. There are many good examples of products that have adopted material design while maintaining their brand identity. Brand-wise, working with material design is similar to working with Apple's built-in UIKit on iOS.

### Can we keep our own branding and styles if we use Material Components for iOS in our app?

Absolutely. Material was developed to be a starting point for designers and developers to enhance their identity. We understand branding is always case by case, so MDC offers a range of components that you can adopt, from highly visual to almost completely structural. 

### We don’t want to use Roboto.

Roboto is not required for material design. The Typography component defaults to using Apple's system font.

### Will we risk not being featured by Apple anymore? 

Apple features good products with good design. Using material design itself is not a reason for an app to be barred from promotion.

### What’s the benefit for us if we implement Material Components for iOS on our app?

Reduced developer time and a consistent design system applied to your UI.

### What’s in it for Google if we implement Material Components for iOS on our app?

We believe in making great design accessible to developers, and we believe that material design can contribute to great design across platforms. This has been available to our internal iOS teams and we are excited to open source it to external developers. In addition, we’re really excited to engage with the iOS developer community and think that Material Design can be better by getting it into the hands of more developers in the open source community.

### We believe that visually coherent UI is very important to our users, so we adhere to Apple's platform design. 

We completely agree about coherent UI; Apple's components are a great starting point. MDC offers a set of components that range from structural, programmer-only conveniences to more visually opinionated components such as sliders and switches. The flexible header component is a good example of a UI element that is widely used, complements Apple's native components, and can reduce engineering time by providing a production-ready experience. 

### We don't want our iOS app to stand out as looking like a Google app.

Google's own use of material design is customized to give the experience of a "Google app." Your use of material design can also provide an experience unique to your brand and identity.

### What happens when Apple implements new features in iOS in general and UIKit in particular? How long will it take for Google to support the new features / adjust to any breaking APIs?

We learn about upcoming API breakages in UIKit as early as everyone else through the preview builds Apple makes available, but typically we have enough time to accommodate for any changes or API breakages. Since MDC for iOS builds upon UIKit and most new iOS features are higher level features that happen outside of UIKit, we typically don’t experience any major issues.

### How large is the upload size of the library?

If you import all the components, the size of your app will increase by about 5.3MB. However, you don't have to add the entire library! You can add as many or as few of the 25+ individual components as you like. And that averages to less than .2MB per component.

