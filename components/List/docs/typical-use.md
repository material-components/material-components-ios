### Typical use

Because List Items ultimately inherit from UICollectionViewCell, clients are not expected to instantiate them themselves. Rather, cell classes are registered with UICollectionViews. Then, in `-collectionView:cellForItemAtIndexPath:`, the client is expected to cast the cell to a List Item class.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
// registering the cell
collectionView.register(MDCBaseCell.self, forCellWithReuseIdentifier: "baseCellIdentifier")

// casting the cell to the desired type within `-collectionView:cellForItemAtIndexPath:`
guard let cell = collectionView.cellForItem(at: indexPath) as? MDCBaseCell else { fatalError() }
```

#### Objective-C

```objc
// registering the cell
[self.collectionView registerClass:[MDCBaseCell class]
        forCellWithReuseIdentifier:@"BaseCellIdentifier"];

// casting the cell to the desired type within `-collectionView:cellForItemAtIndexPath:`
MDCBaseCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:@"BaseCellIdentifier"
                                              forIndexPath:indexPath];
```
<!--</div>-->
