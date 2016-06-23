# RTL handling in Material Components

This component is a set of tools helping handling internationalized manual layouts of interfaces.

In languages like Arabic and Hebrew, most elements in the UI are laid out in a Right-to-Left (RTL)
layout, so all manual layout needs to care for the current environment the app is ran against.
Apple added RTL layout support in iOS 9, but it is the goal of Material Components to enable RTL
layouts on all supported OS versions.

This component includes:

-   Helpers for expressing layouts in terms of leading/trailing instead of left/right.

-   Complete backporting of iOS 9's `+[UIView userInterfaceLayoutDirectionForSemanticContentAttribute:]`
        and `-[UIView semanticContentAttribute]`, and iOS 10's
        `-[UIView effectiveUserInterfaceLayoutDirection]` and
        `+[UIView userInterfaceLayoutDirectionForSemanticContentAttribute:relativeToLayoutDirection:]`

-   Partial backporting of iOS 9's `-[UIImage imageFlippedForRightToLeftLayoutDirection]`. In
        Apple's iOS 9 implementation, the image is not actually flipped, but prepared to be flipped
        when displayed in a Right-to-Left environment, i.e. it's just an additional flag on the
        UIImage (like `imageOrientation`, `scale` or `resizingMode` for example). On iOS 8, the
        partial backporting actually flips the image, so this method should only be called when in
        an RTL environment already.
