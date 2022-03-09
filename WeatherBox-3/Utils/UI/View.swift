import UIKit

class View: UIView {

    init() {
        super.init(frame: .zero)
        setupProperties()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupProperties() {
    }

    func setupConstraints() {
    }
}
