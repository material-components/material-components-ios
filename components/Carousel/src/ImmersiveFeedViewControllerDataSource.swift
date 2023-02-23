import UIKit

@available(iOS 13.0, *)
@objc(MDCImmersiveFeedViewControllerDataSource)
/// A set of methods you implement to set up the data source for the immersive feed view controller.
public protocol ImmersiveFeedViewControllerDataSource {

  /// Provides the immersive feed view controller with the number of items it must display.
  ///
  /// - Returns: an integer representing how many items the immersive feed view controller must
  ///   display.
  @objc func numberOfItems() -> Int

  /// Provides the user with a way to add content to the immersive feed view controller cell at
  /// index path.
  ///
  /// - Parameters:
  ///   - indexPath: The IndexPath of the cell.
  /// - Returns: A UICollectionViewCell.
  @objc func immersiveFeedViewController(cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}
