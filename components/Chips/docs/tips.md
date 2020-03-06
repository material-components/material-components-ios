### Ink ripple animation
Chips display animated ink splashes when the user presses the chip. Keep in mind this will appear on
top of your 'highlighted' backgroundColor.

### Stateful properties
Like UIButton, Material Chips have many state-dependant properties. Set your background color, title
color, border style, and elevation for each of their states. If you don't set a value for a specific
state it will fall back to whatever value has been provided for the Normal state. Don't forget that
you'll also need to set values for the combined states, such as Highlighted | Selected.

### Selected Image View
In order to make it as clear as possible a chip has been selected, you can optionally set the image
of the `selectedImageView`. This image will only appear when the chip is selected. If you have a
image set on the standard `imageView`, then the `selectedImageView` will appear on top. Otherwise
you'll need to resize the chip to show the selected image. See the Filter chip example to see this
in action.

### Padding
There are 4 `padding` properties which control how a chip is laid out. One for each of the chip's
subviews (`imageView` and `selectedImageView` share one padding property), and one which wraps all
the others (`contentPadding`). This is useful so that you can set each of the padding properties to
ensure your chips look correct whether or not they have an image and/or accessory view. The chip
uses these property to determine `intrinsicContentSize` and `sizeThatFits`.

### Adjusting chip sizes after changing the label
If the label of a chip is changed, then you may notice that the chip's frame does not automatically
update to accomodate the new size of the chip's label. To force your chip to update its layout when
this happens you can invoke `invalidateIntrinsicContentSize` on the chip view. For example:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
chipView.invalidateIntrinsicContentSize()
```

#### Objective-C
```objc
[chipView invalidateIntrinsicContentSize];
```
<!--</div>-->

### Adjusting chip sizes in a collection after changing the label
Similar to the above, if your chip's label changes its size in a collection view you will need to
inform the collection view that the chip cell's dimensions have changed. You can do so by reloading
the cell whose label value may have changed (just be sure that your cell dequeue mechanism is
fetching the updated data!). For example:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// After changing the label of a chip cell at `indexPath`:
collectionView.reloadItems(at: [indexPath])
```

#### Objective-C
```objc
// After changing the label of a chip cell at `indexPath`:
[collectionView reloadItemsAtIndexPaths:@[indexPath]];
```
<!--</div>-->

- - -
