import UIKit

final class TransactionListViewController: UITableViewController {
    private let viewModel: TransactionListViewModeling = TransactionListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Products", comment: "Products screen title")
        showLoadingState()
        viewModel.loadProducts { [weak self] in
            self?.tableView.reloadData()
            self?.updateBackgroundView()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == Constants.detailSegueIdentifier,
            let indexPath = tableView.indexPathForSelectedRow,
            let detailViewController = segue.destination as? TransactionDetailViewController
        else {
            return
        }
        detailViewController.viewModel = viewModel.makeDetailViewModel(at: indexPath.row)
    }
}

// UITableViewDataSource
extension TransactionListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.productCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        let item = viewModel.item(at: indexPath.row)
        cell.textLabel?.text = item.sku
        cell.detailTextLabel?.text = item.transactionCountText
        return cell
    }
}

// Private Methods
private extension TransactionListViewController {
    func showLoadingState() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        tableView.backgroundView = activityIndicator
    }

    func updateBackgroundView() {
        guard viewModel.productCount == 0 else {
            tableView.backgroundView = nil
            return
        }
        let label = UILabel()
        label.text = NSLocalizedString("No products to display", comment: "Empty products list")
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        tableView.backgroundView = label
    }
}

// Constants
private extension TransactionListViewController {
    enum Constants {
        static let cellIdentifier = "Cell"
        static let detailSegueIdentifier = "showDetail"
    }
}
