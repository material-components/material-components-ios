### Card Accessibility

To help ensure your cards are accessible to as many users as possible, please be sure to review the following 
recommendations:

#### Accessibility for Cards in a Collection

Since assistive technologies visit all cards in a collection in a sequential order, it is often 
easier to distinguish between elements that belong to different cards by aggregating all the 
card's information so the card is read as a single sentence.  
This can be done by setting an appropriate 
[`accessibilityLabel`](https://developer.apple.com/documentation/uikit/uiaccessibilityelement/1619577-accessibilitylabel) 
for the card. Additionally, set the card's 
[`isAccessibilityElement`](https://developer.apple.com/documentation/objectivec/nsobject/1615141-isaccessibilityelement) 
to true. Cards are a container element and setting isAccessibiltyElement for a container 
turns off individually selecting its subelements.

#### Swift
```swift
  card.isAccessibilityElement = true
  card.accessibilityLabel = "Location \(userLocation.name) is popular with users " +
    "who enjoy \(userLocation.popularActivityMatchingUserProfile(userProfile))"
```

#### Objective-C
```objc
  card.isAccessibilityElement = YES;
  card.accessibilityLabel = [NSString 
    stringWithFormat:@"Location %@ is popular with users who enjoy %@",  
    userLocation.name, 
    userLocation.popularActivityMatchingUserProfile(userProfile)];
```

#### Accessibility for Single Cards

Nested elements in MDCCards are available to assistive technologies without additional 
customization, however additional setup may be needed to accommodate special scenarios, 
such as:

#### Accessibility for Single Cards: Images 
Images that have additional context beyond text that is already presented on the card.  
For example, news article images can benefit from an 
[`accessibilityLabel`](https://developer.apple.com/documentation/uikit/uiaccessibilityelement/1619577-accessibilitylabel) 
describing their content.

Swift
```swift
  articleImageView.isAccessibilityElement = true
  articleImageView.accessibilityLabel = "Event or scene description"
```

Objective-C
```objc
  articleImageView.isAccessibilityElement = YES;
  articleImageView.accessibilityLabel = @"Event or scene description";
```

#### Accessibility for Single Cards: Star Rating
Star or rating images should have an 
[`accessibilityLabel`](https://developer.apple.com/documentation/uikit/uiaccessibilityelement/1619577-accessibilitylabel) 
describing its purpuse and an 
[`accessibilityValue`](https://developer.apple.com/documentation/uikit/uiaccessibilityelement/1619583-accessibilityvalue) 
describing the rating value.

Swift
```swift
  ratingView.isAccessibilityElement = true
  ratingView.accessibilityLabel = "Average customer rating, out of " + 
    "\(MDCProductRating.maximumValue) stars"
  ratingView.accessibilityValue = (String)product.averageRating
```

Objective-C
```objc
  ratingView.isAccessibilityElement = YES;
  ratingView.accessibilityLabel = [NSString stringWithFormat:@"Average customer" +
    " rating, out of %d stars", MDCProductRating.maximumValue];
  ratingView.accessibilityValue = @(product.averageRating).stringValue;
```

#### Accessibility for Single Cards: Reordering elements
Primary content or actions that appear lower on the screen will be read last by assistive 
technologies, sometimes after longer or non-primary content. To change the order, or group 
elements together, you can make the card an accessibility container by adopting the 
[`UIAccessibilityContainer`](https://developer.apple.com/documentation/uikit/accessibility/uiaccessibilitycontainer) 
protocol. Grouping and order is controlled by creating as many 
[`UIAccessibilityElement`](https://developer.apple.com/documentation/uikit/uiaccessibilityelement) 
elements as needed, and returning them in the desired order. 
