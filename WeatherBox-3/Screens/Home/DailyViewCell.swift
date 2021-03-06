import UIKit
import Elephant

class DailyViewCell: TableCell {

    private var model: DailyViewModel?

    private var weatherIcon = UIImageView()

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

    private var weekdayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getDefaultFont(.bold, ofSize: 14)
        label.textColor = Colors.primaryTextColor
        label.text = ""
        return label
    }()

    private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getDefaultFont(.regular, ofSize: 12)
        label.textColor = Colors.primaryTextColor
        label.text = ""
        return label
    }()

    private let dateStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fillProportionally
        return view
    }()

    private let sunInfoStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fillProportionally
        return view
    }()

    private let sunriseStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        return view
    }()

    private let sunsetStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        return view
    }()

    private let sunriseIcon = UIImageView(image: UIImage(named: "Sun&Moon/sunrise"))
    private let sunsetIcon = UIImageView(image: UIImage(named: "Sun&Moon/sunset"))

    private var sunriseTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getDefaultFont(.italic, ofSize: 12)
        label.textColor = Colors.primaryTextColor
        label.text = ""
        return label
    }()

    private var sunsetTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getDefaultFont(.italic, ofSize: 12)
        label.textColor = Colors.primaryTextColor
        label.text = ""
        return label
    }()

    private var dayTempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getDefaultFont(.bold, ofSize: 16)
        label.textColor = Colors.primaryTextColor
        label.backgroundColor = Colors.temperatureDayBackgroundColor
        label.textAlignment = .center
        label.text = ""
        return label
    }()

    private var nightTempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getDefaultFont(.bold, ofSize: 16)
        label.textColor = Colors.primaryNegativeTextColor
        label.backgroundColor = Colors.temperatureNightBackgroundColor
        label.textAlignment = .center
        label.text = ""
        return label
    }()

    private let tempStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        return view
    }()

    private let windStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fill
        return view
    }()

    private var windIcon = UIImageView()

    private let moonInfoStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fillProportionally
        return view
    }()

    private let moonriseStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        return view
    }()

    private let moonsetStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        return view
    }()

    private let moonriseIcon = UIImageView(image: UIImage(named: "Sun&Moon/moonrise"))
    private let moonsetIcon = UIImageView(image: UIImage(named: "Sun&Moon/moonset"))

    private var moonriseTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getDefaultFont(.italic, ofSize: 12)
        label.textColor = Colors.primaryTextColor
        label.text = ""
        return label
    }()

    private var moonsetTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getDefaultFont(.italic, ofSize: 12)
        label.textColor = Colors.primaryTextColor
        label.text = ""
        return label
    }()

    private var windLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getDefaultFont(.regular, ofSize: 12)
        label.textColor = Colors.primaryTextColor
        label.text = ""
        return label
    }()

    private var aqiIcon = UIImageView()

    func configure(with model: DailyViewModel, and backgroundIndicator: Int) {
        self.model = model

        contentView.backgroundColor = Colors.getDailyCellBackgroundColor(backgroundIndicator)
        weatherIcon.image = UIImage(named: "Weather/\(model.icon)")
        weekdayLabel.text = model.weekday
        dateLabel.text = model.date
        sunsetTimeLabel.text = model.sunset
        sunriseTimeLabel.text = model.sunrise
        moonsetTimeLabel.text = model.moonset
        moonriseTimeLabel.text = model.moonrise
        dayTempLabel.text = model.temperatures.day.asTemperatureString()
        nightTempLabel.text = model.temperatures.night.asTemperatureString()
        windIcon.image = UIImage(named: "Wind/\(model.windIcon)")
        windLabel.text = String(format: "%.0f", model.windSpeed * Settings.shared.speedMultiplier).appending(Settings.shared.speedUnit)
    }

    func setAqiIcon(_ icon: String) {
        aqiIcon.image = UIImage(named: "AQI/\(icon)")
    }

    override func setupLayoutConstraints() {
        contentView.addSubviews([weatherIcon, dateStackView, sunInfoStackView, moonInfoStackView, tempStackView, windStackView, aqiIcon])

        weatherIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        weatherIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        weatherIcon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        weatherIcon.heightAnchor.constraint(equalToConstant: 50).isActive = true

        dateStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        dateStackView.leadingAnchor.constraint(equalTo: weatherIcon.trailingAnchor).isActive = true

        dateStackView.addArrangedSubview(weekdayLabel)
        dateStackView.addArrangedSubview(dateLabel)

        sunInfoStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        sunInfoStackView.leadingAnchor.constraint(equalTo: dateStackView.trailingAnchor, constant: 5).isActive = true

        sunInfoStackView.addArrangedSubview(sunriseStackView)
        sunInfoStackView.addArrangedSubview(sunsetStackView)

        sunriseStackView.addArrangedSubview(sunriseIcon)
        sunriseStackView.addArrangedSubview(sunriseTimeLabel)
        sunriseIcon.translatesAutoresizingMaskIntoConstraints = false
        sunriseIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        sunriseIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        sunriseTimeLabel.sizeToFit()

        sunsetStackView.addArrangedSubview(sunsetIcon)
        sunsetStackView.addArrangedSubview(sunsetTimeLabel)
        sunsetIcon.translatesAutoresizingMaskIntoConstraints = false
        sunsetIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        sunsetIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        sunsetTimeLabel.sizeToFit()

        moonInfoStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        moonInfoStackView.leadingAnchor.constraint(equalTo: sunInfoStackView.trailingAnchor, constant: 5).isActive = true

        moonInfoStackView.addArrangedSubview(moonriseStackView)
        moonInfoStackView.addArrangedSubview(moonsetStackView)

        moonriseStackView.addArrangedSubview(moonriseIcon)
        moonriseStackView.addArrangedSubview(moonriseTimeLabel)
        moonriseIcon.translatesAutoresizingMaskIntoConstraints = false
        moonriseIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        moonriseIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        moonriseTimeLabel.sizeToFit()

        moonsetStackView.addArrangedSubview(moonsetIcon)
        moonsetStackView.addArrangedSubview(moonsetTimeLabel)
        moonsetIcon.translatesAutoresizingMaskIntoConstraints = false
        moonsetIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        moonsetIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        moonsetTimeLabel.sizeToFit()

        tempStackView.leadingAnchor.constraint(equalTo: moonInfoStackView.trailingAnchor, constant: 10).isActive = true
        tempStackView.centerYAnchor.constraint(equalTo: moonInfoStackView.centerYAnchor).isActive = true

        tempStackView.addArrangedSubview(dayTempLabel)
        tempStackView.addArrangedSubview(nightTempLabel)

        dayTempLabel.translatesAutoresizingMaskIntoConstraints = false
        dayTempLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true

        nightTempLabel.translatesAutoresizingMaskIntoConstraints = false
        nightTempLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true

        windStackView.addArrangedSubview(windIcon)
        windStackView.addArrangedSubview(windLabel)

        windStackView.leadingAnchor.constraint(equalTo: tempStackView.trailingAnchor, constant: 10).isActive = true
        windStackView.centerYAnchor.constraint(equalTo: tempStackView.centerYAnchor).isActive = true

        windIcon.translatesAutoresizingMaskIntoConstraints = false
        windIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        windIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true

        aqiIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        aqiIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        aqiIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        aqiIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
}
