/// A simple table view controller which is manually composed.
///
/// This view controller is meaningfully *not* a subclass of UITableViewController and its view is
/// not a UIScrollView subclass. This avoids logic which might attempt to be smart by detecting
/// these cases.
class SimpleComposedTableViewController: UIViewController {

  init(title: String? = nil) {
    super.init(nibName: nil, bundle: nil)
    self.title = title
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("NSCoding unsupported")
  }

  var tableView = UITableView(frame: CGRect(), style: .plain)

  var headerView: MDCFlexibleHeaderView?

  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.addSubview(tableView)
    self.tableView.frame = self.view.bounds

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    tableView.delegate = self
    tableView.dataSource = self

    view.isOpaque = false
    view.backgroundColor = .white
  }
}

extension SimpleComposedTableViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }
}

extension SimpleComposedTableViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let titleString = title ?? ""
    cell.textLabel?.text = "\(titleString): Row \(indexPath.item)"
    return cell
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    headerView?.trackingScrollDidScroll()
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    headerView?.trackingScrollDidEndDecelerating()
  }

  func scrollViewWillEndDragging(
    _ scrollView: UIScrollView,
    withVelocity velocity: CGPoint,
    targetContentOffset: UnsafeMutablePointer<CGPoint>
  ) {
    headerView?.trackingScrollWillEndDragging(
      withVelocity: velocity,
      targetContentOffset: targetContentOffset)
  }

  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    headerView?.trackingScrollDidEndDraggingWillDecelerate(decelerate)
  }

  func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
    if #available(iOS 11.0, *) {
      headerView?.trackingScrollDidChangeAdjustedContentInset(scrollView)
    }
  }
}
