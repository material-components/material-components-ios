Material design suggest the usage of chips collection in four context: Input Chips, Choice Chips, Filter Chips, and Action Chips.

### Input Chips
Input chips represent a complex piece of information in compact form, such as an entity (person, place, or thing) or text. They enable user input and verify that input by converting text into chips.


#### Implementation
We currently provide an implementation of Input Chips called `MDCChipField`. 


### Choice Chips
Choice chips allow selection of a single chip from a set of options.

Choice chips clearly delineate and display options in a compact area. They are a good alternative to toggle buttons, radio buttons, and single select menus.

#### Implementation
It is easiest to create choice Chips using a `UICollectionView`:

 - Use `MDCChipCollectionViewFlowLayout` as the `UICollectionView` layout:
 <!--<div class="material-code-render" markdown="1">-->
 ```objc
 MDCChipCollectionViewFlowLayout *layout = [[MDCChipCollectionViewFlowLayout alloc] init];
  _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
 ```
 <!--</div>-->
 
 - Leave the default `UICollectionView` selection setting (single selection).
 - Use `MDCChipCollectionViewCell` as `UICollectionView` cells. (`MDCChipCollectionViewCell` manages the state of the chip based on selection state of `UICollectionView` automatically)

  <!--<div class="material-code-render" markdown="1">-->
   ```objc
  - (void)loadView {
    [super loadView];
    …
    [_collectionView registerClass:[MDCChipCollectionViewCell class]
        forCellWithReuseIdentifier:@"identifier"];
    ...
   }

  - (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                             cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MDCChipCollectionViewCell *cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    MDCChipView *chipView = cell.chipView;
    // configure the chipView
     return cell;
  }
  ```
  <!--</div>-->

- Use `UICollectionViewDelegate` methods `collectionView:didSelectItemAtIndexPath:` for reacting to new choices.

- Use `UICollectionView` `selectItemAtIndexPath:animated:scrollPosition:` method to edit choice selection programmatically.


### Filter Chips
Filter chips use tags or descriptive words to filter content.

Filter chips clearly delineate and display options in a compact area. They are a good alternative to toggle buttons or checkboxes.


#### Implementation
It is easiest to create filter Chips using a `UICollectionView`:

 - Use `MDCChipCollectionViewFlowLayout` as the `UICollectionView` layout:
 <!--<div class="material-code-render" markdown="1">-->
 ```objc
 MDCChipCollectionViewFlowLayout *layout = [[MDCChipCollectionViewFlowLayout alloc] init];
  _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
 ```
 <!--</div>-->
 
 - Allow multi cell selection in the `UICollectionView`:
  <!--<div class="material-code-render" markdown="1">-->
  ```objc
  collectionView.allowsMultipleSelection = YES; 
  ```
  <!--</div>-->
 - Use `MDCChipCollectionViewCell` as `UICollectionView` cells. (`MDCChipCollectionViewCell` manages the state of the chip based on selection state of `UICollectionView` automatically)

  <!--<div class="material-code-render" markdown="1">-->
   ```objc
  - (void)loadView {
    [super loadView];
    …
    [_collectionView registerClass:[MDCChipCollectionViewCell class]
        forCellWithReuseIdentifier:@"identifier"];
    ...
   }

  - (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                             cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MDCChipCollectionViewCell *cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    MDCChipView *chipView = cell.chipView;
    // configure the chipView
     return cell;
  }
  ```
  <!--</div>-->

- Use `UICollectionViewDelegate` methods `collectionView:didSelectItemAtIndexPath:` and `collectionView:didDeselectItemAtIndexPath:` for reacting to filter changes.

- Use `UICollectionView` `deselectItemAtIndexPath:animated:` and `selectItemAtIndexPath:animated:scrollPosition:` methods to edit filter selection in code.


### Action Chips
Action chips offer actions related to primary content. They should appear dynamically and contextually in a UI.

An alternative to action chips are buttons, which should appear persistently and consistently.

#### Implementation
It is easiest to create action Chips using a `UICollectionView`:

 - Use `MDCChipCollectionViewFlowLayout` as the `UICollectionView` layout:
 <!--<div class="material-code-render" markdown="1">-->
 ```objc
 MDCChipCollectionViewFlowLayout *layout = [[MDCChipCollectionViewFlowLayout alloc] init];
  _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
 ```
 <!--</div>-->
 
 - Leave the default `UICollectionView` selection setting (single selection).
 - Use `MDCChipCollectionViewCell` as `UICollectionView` cells. (`MDCChipCollectionViewCell` manages the state of the chip based on selection state of `UICollectionView` automatically)

  <!--<div class="material-code-render" markdown="1">-->
   ```objc
  - (void)loadView {
    [super loadView];
    …
    [_collectionView registerClass:[MDCChipCollectionViewCell class]
        forCellWithReuseIdentifier:@"identifier"];
    ...
   }

  - (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                             cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MDCChipCollectionViewCell *cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    MDCChipView *chipView = cell.chipView;
    // configure the chipView
     return cell;
  }
  ```
  <!--</div>-->

- Make sure that `MDCChipCollectionViewCell` does not stay in selected state

 <!--<div class="material-code-render" markdown="1">-->
   ```objc
 - (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // For action chips, we never want the chip to stay in selected state.
    // Other possible apporaches would be relying on theming or Customizing collectionViewCell
    // selected state.
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    // Trigger the action
  }
  ```
  <!--</div>-->

- Use `UICollectionViewDelegate` method `collectionView:didSelectItemAtIndexPath:` to Trigger the action.

- - -
