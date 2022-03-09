import UIKit
import Elephant

class DailyViewCell: TableCell {

    private var model: DailyViewModel?

    private var weatherIcon: SVGView?

    var weatherIconName: String? {
        didSet {
            guard let name = weatherIconName else { return }
            weatherIcon = SVGView(named: name, animationOwner: .svg)
            setupLayoutConstraints()
        }
    }

    private let vSeparator1: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.separatorColor
        return view
    }()

    private let hSeparator1: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.separatorColor
        return view
    }()

    func configure(with model: DailyViewModel, and backgroundIndicator: Int) {
        self.model = model

        contentView.backgroundColor = Colors.getDailyCellBackgroundColor(backgroundIndicator)
        weatherIconName = model.icon
    }

    override func setupLayoutConstraints() {
        guard let weatherIcon = weatherIcon else { return }
        contentView.addSubviews([weatherIcon, hSeparator1, vSeparator1])

        weatherIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        weatherIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        weatherIcon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        weatherIcon.heightAnchor.constraint(equalToConstant: 50).isActive = true

        vSeparator1.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        vSeparator1.widthAnchor.constraint(equalToConstant: 2).isActive = true
        vSeparator1.heightAnchor.constraint(equalToConstant: 50).isActive = true

        hSeparator1.leadingAnchor.constraint(equalTo: vSeparator1.trailingAnchor, constant: 5).isActive = true
        hSeparator1.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        hSeparator1.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        hSeparator1.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
}
