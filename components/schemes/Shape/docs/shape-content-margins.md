Choosing a shape value for your shape scheme or component has an effect on the component's content.

As an example, we may choose the `smallComponentShape` category to have a cut corner treatment at a 50% value of its height. 
That will create a diamond-like shape, which in certain cases is likely to clip content. 
In other cases, such as with dynamic type, or a typography scheme with large fonts, even a less intrusive shape could potentially cut out content. 

Therefore, it is recommended to be mindful of how a custom shape manipulates the component and if that shape makes sense for your specific case. 
One recommendation is to use the built-in UIView’s `layoutMargins`. By setting it to a custom `UIEdgeInset` you can get the desired outcome for your content when using a custom shape.
