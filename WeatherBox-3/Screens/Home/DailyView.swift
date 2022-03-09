import UIKit

class DailyView: View {

    private let containerView = UIView()

    let tableView: UITableView = {
        let view = UITableView()
        view.register(DailyViewCell.self, forCellReuseIdentifier: DailyViewCell.identifier)
        view.separatorStyle = .none
        return view
    }()

    override func setupConstraints() {
        addSubviews([containerView])
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        containerView.addSubviews([tableView])
        tableView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    }
}
