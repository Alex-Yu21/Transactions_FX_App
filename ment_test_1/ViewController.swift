import UIKit

class ViewController: UITableViewController {

    // Private Properties

    private let viewModel = ProductsViewModel()

    // UITableViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.title
        viewModel.loadProducts()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.detailSegueIdentifier,
              let indexPath = tableView.indexPathForSelectedRow,
              let detailViewController = segue.destination as? TransactionsDetailViewController else {
            return
        }
        detailViewController.viewModel = viewModel.makeDetailViewModel(at: indexPath.row)
    }
}

// UITableViewDataSource
extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.productCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        cell.textLabel?.text = viewModel.sku(at: indexPath.row)
        cell.detailTextLabel?.text = "\(viewModel.transactionCount(at: indexPath.row)) transactions"
        return cell
    }
}

// Constants
private extension ViewController {
    enum Constants {
        static let title = "Products"
        static let cellIdentifier = "Cell"
        static let detailSegueIdentifier = "showDetail"
    }
}
