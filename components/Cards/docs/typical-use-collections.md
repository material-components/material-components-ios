### Typical use: in a collection view

Use `MDCCardCollectionCell` as a base class for your custom collection view cell

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
collectionView.register(MDCCardCollectionCell.self, forCellWithReuseIdentifier: "Cell")

func collectionView(_ collectionView: UICollectionView,
                    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                for: indexPath) as! MDCCardCollectionCell
  // If you wanted to have the card show the selected state when tapped
  // then you need to turn isSelectable to true, otherwise the default is false.
  cell.isSelectable = true
  
  cell.selectedImageTintColor = .blue
  cell.cornerRadius = 8
  cell.setShadowElevation(6, for: .selected)
  cell.setShadowColor(UIColor.black, for: .highlighted)
  return cell
}
```

#### Objective-C

```objc
[self.collectionView registerClass:[MDCCardCollectionCell class]
        forCellWithReuseIdentifier:@"Cell"];

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCardCollectionCell *cell =
  [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell"
                                            forIndexPath:indexPath];
  // If you wanted to have the card show the selected state when tapped
  // then you need to turn selectable to true, otherwise the default is false.
  [cell setSelectable:YES];
  
  [cell setSelectedImageTintColor:[UIColor blueColor]];
  [cell setCornerRadius:8];
  [cell setShadowElevation:6 forState:MDCCardCellStateSelected];
  [cell setShadowColor:[UIColor blackColor] forState:MDCCardCellStateHighlighted];
}
```
<!--</div>-->
