import UIKit
import Elephant

class HourlyViewCell: CollectionCell {

    var model: HourlyItemModel?

    private var weatherIcon = UIImageView()

    private let hSeparator1: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.separatorColor
        return view
    }()

    private let hSeparator2: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.separatorColor
        return view
    }()

    private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getDefaultFont(.regular, ofSize: 12)
        label.textColor = Colors.primaryTextColor
        label.text = ""
        return label
    }()

    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getDefaultFont(.bold, ofSize: 14)
        label.textColor = Colors.primaryTextColor
        label.text = ""
        return label
    }()

    func configure(with model: HourlyItemModel) {
        self.model = model

        weatherIcon.image = UIImage(named: "Weather/\(model.icon)")
        dateLabel.text = model.hour
        temperatureLabel.text = model.temperature.asTemperatureString()
    }

    override func setupLayoutContraints() {
        contentView.addSubviews([dateLabel, hSeparator2, weatherIcon, hSeparator1, temperatureLabel])

        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true

        hSeparator2.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5).isActive = true
        hSeparator2.widthAnchor.constraint(equalToConstant: 35).isActive = true
        hSeparator2.heightAnchor.constraint(equalToConstant: 2).isActive = true

        weatherIcon.topAnchor.constraint(equalTo: hSeparator2.bottomAnchor, constant: 5).isActive = true
        weatherIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        weatherIcon.widthAnchor.constraint(equalToConstant: 35).isActive = true
        weatherIcon.heightAnchor.constraint(equalToConstant: 35).isActive = true

        hSeparator1.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 5).isActive = true
        hSeparator1.widthAnchor.constraint(equalToConstant: 35).isActive = true
        hSeparator1.heightAnchor.constraint(equalToConstant: 2).isActive = true

        temperatureLabel.topAnchor.constraint(equalTo: hSeparator1.bottomAnchor, constant: 5).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
}
