import UIKit

class HourlyView: View {

    private let containerView = UIView()

    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 40, height: 100)
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.register(HourlyViewCell.self, forCellWithReuseIdentifier: HourlyViewCell.identifier)
        return view
    }()

    override func setupConstraints() {
        addSubviews([containerView])
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        containerView.addSubviews([collectionView])
        collectionView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    }
}
