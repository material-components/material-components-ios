/// A table view controller which inherits directly from UITableViewController.
///
/// This intentionally sets things up such that its view is a subclass of UIScrollView, which is
/// handled specially by some components.
class SimpleInheritedTableViewController: UITableViewController {

  init(title: String? = nil) {
    super.init(nibName: nil, bundle: nil)
    self.title = title
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("NSCoding unsupported")
  }

  var headerView: MDCFlexibleHeaderView?

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    tableView.delegate = self
    tableView.dataSource = self
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }

  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let titleString = title ?? ""
    cell.textLabel?.text = "\(titleString): Row \(indexPath.item)"
    return cell
  }

  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    headerView?.trackingScrollDidScroll()
  }

  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    headerView?.trackingScrollDidEndDecelerating()
  }

  override func scrollViewWillEndDragging(
    _ scrollView: UIScrollView,
    withVelocity velocity: CGPoint,
    targetContentOffset: UnsafeMutablePointer<CGPoint>
  ) {
    headerView?.trackingScrollWillEndDragging(
      withVelocity: velocity,
      targetContentOffset: targetContentOffset)
  }

  override func scrollViewDidEndDragging(
    _ scrollView: UIScrollView,
    willDecelerate decelerate: Bool
  ) {
    headerView?.trackingScrollDidEndDraggingWillDecelerate(decelerate)
  }
}
