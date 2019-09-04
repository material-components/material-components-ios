### Creating a banner view

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
let bannerView = MDCBannerView()
bannerView.textView.text = "Text on Banner"
bannerView.imageView.image = UIImage(named: "bannerIcon")
bannerView.leadingButton.setTitle("Action", for: .normal)
bannerView.trailingButton.hidden = true

// Optional configuration on layoutMargins
bannerView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10);

let bannerViewSize = bannerView.sizeThatFits(view.bounds.size)
bannerView.frame = CGRect(x: 0, y: 0, width: bannerViewSize.width, height: bannerViewSize.height)

view.addSubview(bannerView)
```

#### Objective-C

```objc
MDCBannerView *bannerView = [[MDCBannerView alloc] init];
bannerView.textView.text = @"Text on Banner";
bannerView.imageView.image = [UIImage imageNamed:@"bannerIcon"];
[bannerView.leadingButton setTitle:@"Action" forState:UIControlStateNormal];
bannerView.trailingButton.hidden = YES;

// Optional configuration on layoutMargins. 
bannerView.layoutMargins = UIEdgeInsetsMake(0, 10, 0, 10);

CGSize bannerViewSize = [bannerView sizeThatFits:self.view.bounds.size];
bannerView.frame = CGRectMake(0, 0, bannerViewSize.width, bannerViewSize.height);

[self.view addSubview:bannerView];
```

<!--</div>-->
