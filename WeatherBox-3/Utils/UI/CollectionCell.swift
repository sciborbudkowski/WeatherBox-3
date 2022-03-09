import UIKit

class CollectionCell: UICollectionViewCell {

     static let identifier = String(describing: self)

    func setupProperties() {
    }

    func setupLayoutContraints() {
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupProperties()
        setupLayoutContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
