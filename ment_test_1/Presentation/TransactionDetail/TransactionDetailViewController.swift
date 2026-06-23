import UIKit

final class TransactionDetailViewController: UITableViewController {
    var viewModel: TransactionDetailViewModeling?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel?.screenTitle
    }
}

// UITableViewDataSource
extension TransactionDetailViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.itemCount ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        let item = viewModel?.item(at: indexPath.row)
        cell.textLabel?.text = item?.originalText
        cell.detailTextLabel?.text = item?.convertedText
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel?.totalText
    }
}

// Constants
private extension TransactionDetailViewController {
    enum Constants {
        static let cellIdentifier = "Cell"
    }
}
