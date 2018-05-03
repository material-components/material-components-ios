### Customizing floating action buttons

A floating action button can be configured with a combination of `shape` and `mode`. The 
`.default` shape is a 56-point circle containing a single image or short title. The `.mini` shape
is a smaller, 40-point circle.  The `.normal` mode is a circle containing an image or short title.
The `.expanded` mode is a "pill shape" and should include both an image and a single-word title. The
`.expanded` mode should only be used in the largest layouts. For example, an iPad in full screen.

While in the `.expanded` mode, a floating button can position its `imageView` to either the leading
or trailing side of the title by setting the `imageLocation` property.

Because of the combination of shapes and modes available to the floating action button, some
UIButton property setters have been made unavailable and replaced with methods to set them for a 
specific mode and shape combination. Getters for these values are not available, and the normal
getter will return the current value of the property.

- `-setContentEdgeInsets` is replaced with `-setContentEdgeInsets:forShape:inMode:`
- `-setHitAreaInsets` is replaced with `-setHitAreaInsets:forShape:inMode:`
- `-setMinimumSize` is replaced with `-setMinimumSize:forShape:inMode:`
- `-setMaximumSize` is replaced with `-setMaximumSize:forShape:inMode:`
