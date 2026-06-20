import UIKit

class TransactionsDetailViewController: UITableViewController {

    // Public Properties

    var viewModel: TransactionsDetailViewModel?

    // UITableViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel?.title
    }
}

// UITableViewDataSource
extension TransactionsDetailViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.transactionCount ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        cell.textLabel?.text = viewModel?.originalAmountText(at: indexPath.row)
        cell.detailTextLabel?.text = viewModel?.convertedAmountText(at: indexPath.row)
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel?.totalText
    }
}

// Constants
private extension TransactionsDetailViewController {
    enum Constants {
        static let cellIdentifier = "Cell"
    }
}
