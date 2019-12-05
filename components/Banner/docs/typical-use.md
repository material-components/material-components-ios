### Appearance

By default, `MDCBannerView` is configured to display an image view, a text label and two buttons. To hide the image view on `MDCBannerView`, users can set the `hidden` property on `imageView` to be true. Similarly, users can hide a button on the banner view by setting the `hidden` property on `trailingButton` to be true.

### Styling

By default, `MDCBannerView` is configured to display items with black text and white background with a grey divider at the bottom of the view. To customize the color and style of the text, image view and buttons displayed on `MDCBannerView`, directly set the relevant properties, such as `tintColor`, on `textView`, `imageView`, `leadingButton` and `trailingButton`. `showsDivider` and `dividerColor` can be used to control the divider's visibility and color.

`MDCBannerView` can handle its layout style in both an automatic way and manual ways through `bannerViewLayoutStyle` property. By default, `MDCBannerViewLayoutStyleAutomatic` is set and layout is set automatically based on how elements are configured on the `MDCBannerView`. `MDCBannerViewLayoutStyleSingleRow`, `MDCBannerViewLayoutStyleMultiRowStackedButton` and `MDCBannerViewLayoutStyleMultiRowAlignedButton` are values that can be used as manual ways to handle layout style.

### LayoutMargins

`MDCBannerView` uses `layoutMargins` to manage the margins for elements on the banner view.
<!--</div>-->
