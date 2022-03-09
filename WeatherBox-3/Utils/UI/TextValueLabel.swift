import UIKit

class TextValueLabel: View {

    var text: UILabel = {
        let label = UILabel()
        label.font = UIFont.getDefaultFont(.light, ofSize: 12)
        label.textColor = Colors.secondaryTextColor
        return label
    }()

    var value: UILabel = {
        let label = UILabel()
        label.font = UIFont.getDefaultFont(.semiBold, ofSize: 20)
        label.textColor = Colors.primaryTextColor
        return label
    }()

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalCentering
        view.alignment = .center
        return view
    }()

    private let containerView = UIView()

    override func setupConstraints() {
        addSubviews([containerView])
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        containerView.addSubviews([stackView])
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        stackView.addArrangedSubview(text)
        stackView.addArrangedSubview(value)
    }
}
