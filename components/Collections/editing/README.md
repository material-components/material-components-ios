# Editing the collection view

**Notice**: This component will be deprecated over the next few months in favor of the
[Cards](../../Cards) and [List](../../List) components. See our
[public tracker](https://www.pivotaltracker.com/epic/show/3938766) for more details on timing and
the deprecation plan.

---

The collection view controller provides an `editor` property that conforms to the
`MDCCollectionViewEditing` protocol. Use this property to set the collection view into editing mode
with/without animation. Override the `MDCCollectionViewEditingDelegate` protocol methods as needed
in a collection view controller subclass to handle editing permissions and notification callbacks.

## Table of Contents
- [Enable editing mode](#enable-editing-mode)
- [Deleting Cells](#enable-editing-mode)
- [Reordering Cells](#reordering-cells)
- [Swipe to dismiss item at index path](#swipe-to-dismiss-item-at-index-path)
- [Swipe to dismiss section](#swipe-to-dismiss-section)

- - -

### Enable editing mode

The `editor` allows putting the collection view into editing mode with/without animation. Override
the protocol method `collectionView:canEditItemAtIndexPath:` to enable/disable editing at specific
index paths. When a collection view has editing enabled, all of the cells will be inlaid. Using the
additional protocol delegate methods, you can override which specific cells allow reordering and
selection for deletion.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
```objc
// Enable editing.
[self.editor setEditing:YES animated:YES];

// Optionally set editing for specific index paths.
- (BOOL)collectionView:(UICollectionView *)collectionView
    canEditItemAtIndexPath:(NSIndexPath *)indexPath {
  return (indexPath.item != 0);
}
```

#### Swift
```swift
// Enable editing.
self.editor.setEditing(true, animated: true)

// Optionally set editing for specific index paths.
override func collectionView(collectionView: UICollectionView,
                             canEditItemAtIndexPath indexPath: NSIndexPath) -> Bool {
  return indexPath.item != 0
}
```
<!--</div>-->

> Important: When enabling editing, if your custom view controller incorporates section headers or
> footers you must include the below code at the top of your implementation of the
> **collectionView:viewForSupplementaryElementOfKind:atIndexPath:** method as shown below.
> <!--<div class="material-code-render" markdown="1">-->
> #### Objective-C
> ```objc
> - (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
>            viewForSupplementaryElementOfKind:(NSString *)kind
>                                  atIndexPath:(NSIndexPath *)indexPath
> {
>
>   id supplementaryView = [super collectionView:collectionView
>              viewForSupplementaryElementOfKind:kind
>                                    atIndexPath:indexPath];
>   if (supplementaryView) {
>     return supplementaryView;
>   }
>
>   // Custom Section Header Code
> ```
>
> #### Swift
> ```swift
> override func collectionView(_ collectionView: UICollectionView,
>        viewForSupplementaryElementOfKind kind: String,
>                                  at indexPath: IndexPath) -> UICollectionReusableView
> {
>
>   var supplementaryView = super.collectionView(collectionView,
>                             viewForSupplementaryElementOfKind: kind,
>                                                            at: indexPath)
>   if supplementaryView != nil {
>     return supplementaryView
>   }
>
>   // Custom Section Header Code
> ```
> <!--</div>-->

### Deleting Cells

Cells can be deleted by first [enabling editing mode](#enable-editing). Next enable cell editing by
overriding the `collectionViewAllowsEditing:` protocol method and returning `YES`. You can disable
specific cells from being able to be deleted by returning `NO` from the
`collectionView:canSelectItemDuringEditingAtIndexPath:` protocol method at the desired index paths.
Once these deletion permissions are set, the UI will display a selector icon at right of cell,
allowing cells to be selected for deletion by user. Upon selecting one or more cells, a Delete
action bar will animate up from bottom of screen. Upon hitting the delete bar, a call to protocol
method `collectionView:willDeleteItemsAtIndexPaths` will allow you to remove the appropriate data
at the specified index paths from your `UICollectionViewDataSource`. As a result, the cells will get
removed with animation, and the Delete action bar will animate away as well.

The following illustrates a simple cell deletion example.

> For this example, we are assuming a simple data source array of strings:
> `data = @[ @"red", @"blue", @"green", @"black", @"yellow", @"purple" ];`

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
```objc
// Enable editing.
[self.editor setEditing:YES animated:YES];

// Enable cell deleting.
- (BOOL)collectionViewAllowsEditing:(UICollectionView *)collectionView {
  return YES;
}

// Remove selected index paths from our data.
- (void)collectionView:(UICollectionView *)collectionView
    willDeleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
  // First sort reverse order then remove. This is done because when we delete an index path the
  // higher rows shift down, altering the index paths of those that we would like to delete in the
  // next iteration of this loop.
  NSArray *sortedArray = [indexPaths sortedArrayUsingSelector:@selector(compare:)];
  for (NSIndexPath *indexPath in [sortedArray reverseObjectEnumerator]) {
    [data removeObjectAtIndex:indexPath.item];
  }
}
```

#### Swift
```swift
// Enable editing.
self.editor.setEditing(true, animated: true)

// Enable cell deleting.
override func collectionViewAllowsEditing(collectionView: UICollectionView) -> Bool {
  return true
}

// Remove selected index paths from our data.
override func collectionView(collectionView: UICollectionView,
                             willDeleteItemsAtIndexPaths indexPaths: [NSIndexPath]) {
  // First sort reverse order then remove. This is done because when we delete an index path the
  // higher rows shift down, altering the index paths of those that we would like to delete in the
  // next iteration of this loop.
  for indexPath in indexPaths.sort({$0.item > $1.item}) {
    data.removeAtIndex(indexPath.item)
  }
}
```
<!--</div>-->

### Reordering Cells

Cells can be dragged to reorder by first [enabling editing mode](#enable-editing). Next enable cell
reordering by overriding the `collectionViewAllowsReordering:` protocol method and returning `YES`.
You can disable specific cells from being able to be reordered by returning `NO` from the
`collectionView:canMoveItemAtIndexPath:` protocol method at the desired index paths. Once these
reordering permissions are set, the UI will display a reordering icon at left of cell, allowing
cells to be dragged for reordering by user. Upon moving a cell, a call to protocol
method `collectionView:willMoveItemAtIndexPath:toIndexPath` will allow you to exchange the
appropriate data at the specified index paths from your `UICollectionViewDataSource`.

The following illustrates a simple cell reorder example.

> For this example, we are assuming a simple data source array of strings:
> `data = @[ @"red", @"blue", @"green", @"black", @"yellow", @"purple" ];`

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
```objc
// Enable editing.
[self.editor setEditing:YES animated:YES];

// Enable cell reordering.
- (BOOL)collectionViewAllowsReordering:(UICollectionView *)collectionView {
  return YES;
}

// Reorder moved index paths within our data.
- (void)collectionView:(UICollectionView *)collectionView
    willMoveItemAtIndexPath:(NSIndexPath *)indexPath
                toIndexPath:(NSIndexPath *)newIndexPath {
  [_content exchangeObjectAtIndex:indexPath.item  withObjectAtIndex:newIndexPath.item];
}
```

#### Swift
```swift
// Enable editing.
self.editor.setEditing(true, animated: true)

// Enable cell reordering.
override func collectionViewAllowsReordering(collectionView: UICollectionView) -> Bool {
  return true
}

// Reorder moved index paths within our data.
override func collectionView(collectionView: UICollectionView,
                             willMoveItemAtIndexPath indexPath: NSIndexPath, toIndexPath newIndexPath: NSIndexPath) {
  swap(&data[indexPath.item], &data[newIndexPath.item])
}
```
<!--</div>-->

### Swipe to dismiss item at index path

Cells at desired index paths can be swiped left/right for deletion. Enable this functionality by
returning `YES` from the `collectionViewAllowsSwipeToDismissItem` protocol method. Then provide
permissions for specific index paths by overriding the
`collectionView:canSwipeToDismissItemAtIndexPath` method. Note, editing mode is **not** required
to be enabled for swiping-to-dismiss to be allowed. Once a user swipes a cell, a call to protocol
method `collectionView:willDeleteItemsAtIndexPaths` will allow you to remove the appropriate data
at the specified index paths from your `UICollectionViewDataSource`.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
```objc
// Enable swipe-to-dismiss items.
- (BOOL)collectionViewAllowsSwipeToDismissItem:(UICollectionView *)collectionView {
  return YES;
}

// Override permissions at specific index paths.
- (BOOL)collectionView:(UICollectionView *)collectionView
    canSwipeToDismissItemAtIndexPath:(NSIndexPath *)indexPath {
  // In this example we are allowing all items to be dismissed except this first item.
  return indexPath.item != 0;
}

// Remove swiped index paths from our data.
- (void)collectionView:(UICollectionView *)collectionView
    willDeleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *) *)indexPaths {
  for (NSIndexPath *indexPath in indexPaths) {
    [data removeObjectAtIndex:indexPath.item];
  }
}
```

#### Swift
```swift
// Enable swipe-to-dismiss items.
override func collectionViewAllowsSwipeToDismissItem(collectionView: UICollectionView) -> Bool {
  return true
}

// Override permissions at specific index paths.
override func collectionView(collectionView: UICollectionView,
                             canSwipeToDismissItemAtIndexPath indexPath: NSIndexPath) -> Bool {
  // In this example we are allowing all items to be dismissed except this first item.
  return indexPath.item != 0
}

// Remove swiped index paths from our data.
override func collectionView(collectionView: UICollectionView,
                             willDeleteItemsAtIndexPaths indexPaths: [NSIndexPath]) {
  for indexPath in indexPaths {
    data.removeAtIndex(indexPath.item)
  }
}
```
<!--</div>-->

### Swipe to dismiss section

Cells at desired sections can be swiped left/right for deletion. Enable this functionality by
returning `YES` from the `collectionViewAllowsSwipeToDismissSection` protocol method. Then provide
permissions for specific section by overriding the `collectionView:canSwipeToDismissSection` method.
Note, editing mode is **not** required to be enabled for swiping-to-dismiss to be allowed. Once a
user swipes a section, a call to protocol method `collectionView:willDeleteSections` will allow you
to remove the appropriate data at the specified section from your `UICollectionViewDataSource`.

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
```objc
// Enable swipe-to-dismiss sections.
- (BOOL)collectionViewAllowsSwipeToDismissSection:(UICollectionView *)collectionView {
  return YES;
}

// Override permissions at specific section.
- (BOOL)collectionView:(UICollectionView *)collectionView
    canSwipeToDismissSection:(NSInteger)section {
  // In this example we are allowing all sections to be dismissed except this first section.
  return indexPath.section != 0;
}

// Remove swiped sections from our data.
- (void)collectionView:(UICollectionView *)collectionView
    willDeleteSections:(NSIndexSet *)sections {
  [_content removeObjectsAtIndexes:sections];
}
```

#### Swift
```swift
// Enable swipe-to-dismiss sections.
override func collectionViewAllowsSwipeToDismissItem(collectionView: UICollectionView) -> Bool {
  return true
}

// Override permissions at specific section.
override func collectionView(collectionView: UICollectionView,
                             canSwipeToDismissSection section: Int) -> Bool {
  // In this example we are allowing all sections to be dismissed except this first section.
  return indexPath.section != 0
}

// Remove swiped sections from our data.
override func collectionView(collectionView: UICollectionView,
                             willDeleteSections sections: NSIndexSet) {
  for (index, item) in sections.reverse().enumerate() {
    data.removeAtIndex(index)
  }
}
```
<!--</div>-->
