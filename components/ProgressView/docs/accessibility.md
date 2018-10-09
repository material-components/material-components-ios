### MDCProgressView

#### -accessibilityValue

Like UIProgressView, MDCProgressView's `accessibilityValue` is based on the current value of the ProgressView's
`progress` property. Also like UIProgressView, this `accessibilityValue` takes the form of a whole number
percentage. To ensure the same behavior between the two classes, the MDCProgressView class has a static
UIProgressView that instances query for its `accessibilityValue` whenever they need to provide their own.

The ProgressView announces a new `accessibilityValue` whenever its `progress` changes if VoiceOver is on.
