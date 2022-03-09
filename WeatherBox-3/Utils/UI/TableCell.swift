import UIKit

class TableCell: UITableViewCell {

    public static let identifier = String(describing: self)

    func setupProperties() {
    }

    func setupLayoutConstraints() {
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupProperties()
        setupLayoutConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
