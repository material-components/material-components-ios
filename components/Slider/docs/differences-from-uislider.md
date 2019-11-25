### Differences from UISlider

#### UISlider APIs not present in MDCSlider

`MDCSlider` does not support the following `UISlider` APIs:

*   Setting the left/right icons via `minimumValueImage` and `maximumValueImage`.
*   Setting the thumb image via `setThumbImage:forState:`.
*   Setting the right/left track images (for a custom track) via `setMinimumTrackImage:forState:` and `setMaximumTrackImage:forState:`.

#### UISlider APIs with different names in MDCSlider

*   The UISlider API `minimumTrackTintColor` has an equivalent API `setTrackFillColor:forState:` in 
    MDCSlider.  This API must first be enabled by setting `statefulAPIEnabled = YES`. 
*   The UISlider API `maximumTrackTintColor` has an equivalent API `setTrackBackgroundColor:forState:`
    in MDCSlider.  This API must first be enabled by setting `statefulAPIEnabled = YES`.
*   The UISlider API `thumbTintColor` has an equivalent API `setThumbColor:forState:` in MDCSlider.  This
    API must first be enabled by setting `statefulAPIEnabled = YES`.     

#### MDCSlider enhancements not in MDCSlider

*   MDCSlider can behave as a [Material Discrete Slider](https://material.io/components/sliders/#discrete-slider) by
    setting `discrete = YES` and `numberOfDiscreteValues` to a value greater than or equal to 2. Discrete 
    Sliders only allow their calculated discrete values to be selected as the Slider's value.  If 
    `numberOfDiscreteValues` is less than 2, then the Slider will behave as a 
    [Material Continuous Slider](https://material.io/components/sliders/#continuous-slider).
*   For Discrete Sliders, the track tick color is configured with the `setFilledTrackTickColor:forState:` and
    `setBackgroundTrackTickColor:forState:` APIs.  The filled track ticks are those overlapping the 
    filled/active part of the Slider.  The background track ticks are found in any other portions of the track.  These 
    APIs must first be enabled by setting `statefulAPIEnabled = YES`.
*   Track tick marks can be made shown always, never, or only when dragging via the `trackTickVisibility` 
    API.  If `numberOfDiscreteValues` is less than 2, then tick marks will never be shown.
*   An anchor point can be set via `filledTrackAnchorValue` to control the starting position of the filled track.
*   The track can be made taller (or shorter) by setting the value of `trackHeight`. 

#### `-accessibilityActivate`

MDCSlider's behavior is very similar to that of UISlider, but it's not exactly the same. On an
`accessibilityActivate` event, the value moves one sixth of the amount between the current value and the 
midpoint value.
