import UIKit

struct HourlyItemModel {
    var hour: String
    var icon: String
    var temperature: Double
}

class HourlyViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    var items: [HourlyItemModel] = []

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyViewCell.identifier, for: indexPath) as? HourlyViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: items[indexPath.row])

        return cell
    }
}
