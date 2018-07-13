### Differences from UISlider

Does not have api to:

- set right and left icons
- set the thumb image
- set the right and left track images (for a custom track)
- set the right (background track) color

Same features:

- set color for thumb via @c thumbColor
- set color of track via @c trackColor

New features:

- making the slider a snap to discrete values via property numberOfDiscreteValues

#### `-accessibilityActivate`

Our implementation closely resembles what UISlider does but it's not an exact match. On an
`accessibilityActivate` we move one sixth of the amount between the current value and the midpoint value.
