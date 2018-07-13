### MDCProgressView

#### -accessibilityValue

Like UIProgressView, MDCProgressView's `accessibilityValue` is based on the current value of the ProgressView's
`progress` property. UIProgressView has internal logic that makes it so that a `progress` value of .476 will yield an
`accessibilityValue` of "fifty percent". To ensure that the MDCProgressView follows the same behavior, the
MDCProgressView class has a static UIProgressView that instances query for its `accessibilityValue` whenever
they need to provide their own.

The ProgressView announces a new `accessibilityValue` whenever its `progress` changes if VoiceOver is on.
