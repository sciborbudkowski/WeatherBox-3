import UIKit
import Elephant

class HomeView: View {

    private let dayNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getDefaultFont(.light, ofSize: 12)
        label.textColor = Colors.secondaryTextColor
        label.text = "Dziś, "
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getDefaultFont(.light, ofSize: 12)
        label.textColor = Colors.secondaryTextColor
        label.text = Date.now.formatted(date: .long, time: .omitted)
        return label
    }()

    var placeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getDefaultFont(.bold, ofSize: 18)
        label.textColor = Colors.primaryTextColor
        label.text = ""
        return label
    }()

    private var weatherIcon: SVGView?

    var weatherIconName: String? {
        didSet {
            if let name = weatherIconName {
                weatherIcon = SVGView(named: name, animationOwner: .svg)
                setupConstraints()
            }
        }
    }

    var weatherNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getDefaultFont(.regular, ofSize: 30)
        label.textColor = Colors.secondaryTextColor
        label.adjustsFontSizeToFitWidth = true
        label.text = ""
        return label
    }()

    var wind: TextValueLabel = {
        let label = TextValueLabel()
        label.text.text = "wiatr"
        label.value.text = ""
        return label
    }()

    var temperature: TextValueLabel = {
        let label = TextValueLabel()
        label.text.text = "temperatura"
        label.value.text = ""
        return label
    }()

    var humidity: TextValueLabel = {
        let label = TextValueLabel()
        label.text.text = "wilgotność"
        label.value.text = ""
        return label
    }()

    private let vSeparator1: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.separatorColor
        return view
    }()

    private let vSeparator2: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.separatorColor
        return view
    }()

    private let hSeparator1: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.separatorColor
        return view
    }()

    var pressure: TextValueLabel = {
        let label = TextValueLabel()
        label.text.text = "ciśnienie"
        label.value.text = ""
        return label
    }()

    var feelsLike: TextValueLabel = {
        let label = TextValueLabel()
        label.text.text = "odczuwalna"
        label.value.text = ""
        return label
    }()

    var uvIndex: TextValueLabel = {
        let label = TextValueLabel()
        label.text.text = "index UV"
        label.value.text = ""
        return label
    }()

    private let vSeparator3: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.separatorColor
        return view
    }()

    private let vSeparator4: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.separatorColor
        return view
    }()

    var hourlyView = HourlyView()

    var dailyView = DailyView()

    override func setupConstraints() {
        guard let weatherIcon = weatherIcon else { return }

        addSubviews([dayNameLabel, dateLabel, placeNameLabel,
                     weatherIcon, weatherNameLabel,
                     vSeparator1, vSeparator2,
                     wind, temperature, humidity,
                     hSeparator1,
                     vSeparator3, vSeparator4,
                     pressure, feelsLike, uvIndex,
                     hourlyView, dailyView])

        dayNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60).isActive = true
        dayNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true

        dateLabel.topAnchor.constraint(equalTo: dayNameLabel.topAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: dayNameLabel.trailingAnchor).isActive = true

        placeNameLabel.topAnchor.constraint(equalTo: dayNameLabel.bottomAnchor).isActive = true
        placeNameLabel.leadingAnchor.constraint(equalTo: dayNameLabel.leadingAnchor).isActive = true

        weatherIcon.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor).isActive = true
        weatherIcon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        weatherIcon.widthAnchor.constraint(equalToConstant: 150).isActive = true
        weatherIcon.heightAnchor.constraint(equalToConstant: 150).isActive = true

        weatherNameLabel.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor).isActive = true
        weatherNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        weatherNameLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -40).isActive = true

        temperature.topAnchor.constraint(equalTo: weatherNameLabel.bottomAnchor, constant: 10).isActive = true
        temperature.centerXAnchor.constraint(equalTo: weatherNameLabel.centerXAnchor).isActive = true

        vSeparator1.topAnchor.constraint(equalTo: temperature.topAnchor, constant: 5).isActive = true
        vSeparator1.widthAnchor.constraint(equalToConstant: 2).isActive = true
        vSeparator1.bottomAnchor.constraint(equalTo: temperature.bottomAnchor, constant: -5).isActive = true
        vSeparator1.trailingAnchor.constraint(equalTo: temperature.leadingAnchor, constant: -25).isActive = true

        vSeparator2.topAnchor.constraint(equalTo: temperature.topAnchor, constant: 5).isActive = true
        vSeparator2.widthAnchor.constraint(equalToConstant: 2).isActive = true
        vSeparator2.bottomAnchor.constraint(equalTo: temperature.bottomAnchor, constant: -5).isActive = true
        vSeparator2.leadingAnchor.constraint(equalTo: temperature.trailingAnchor, constant: 25).isActive = true

        wind.topAnchor.constraint(equalTo: temperature.topAnchor).isActive = true
        wind.trailingAnchor.constraint(equalTo: vSeparator1.leadingAnchor, constant: -25).isActive = true

        humidity.topAnchor.constraint(equalTo: temperature.topAnchor).isActive = true
        humidity.leadingAnchor.constraint(equalTo: vSeparator2.trailingAnchor, constant: 25).isActive = true

        hSeparator1.topAnchor.constraint(equalTo: wind.bottomAnchor, constant: 5).isActive = true
        hSeparator1.leadingAnchor.constraint(equalTo: wind.leadingAnchor).isActive = true
        hSeparator1.trailingAnchor.constraint(equalTo: humidity.trailingAnchor).isActive = true
        hSeparator1.heightAnchor.constraint(equalToConstant: 2).isActive = true

        feelsLike.topAnchor.constraint(equalTo: hSeparator1.bottomAnchor, constant: 5).isActive = true
        feelsLike.centerXAnchor.constraint(equalTo: weatherNameLabel.centerXAnchor).isActive = true

        vSeparator3.topAnchor.constraint(equalTo: feelsLike.topAnchor, constant: 5).isActive = true
        vSeparator3.widthAnchor.constraint(equalToConstant: 2).isActive = true
        vSeparator3.bottomAnchor.constraint(equalTo: feelsLike.bottomAnchor, constant: -5).isActive = true
        vSeparator3.trailingAnchor.constraint(equalTo: feelsLike.leadingAnchor, constant: -25).isActive = true

        vSeparator4.topAnchor.constraint(equalTo: feelsLike.topAnchor, constant: 5).isActive = true
        vSeparator4.widthAnchor.constraint(equalToConstant: 2).isActive = true
        vSeparator4.bottomAnchor.constraint(equalTo: feelsLike.bottomAnchor, constant: -5).isActive = true
        vSeparator4.leadingAnchor.constraint(equalTo: feelsLike.trailingAnchor, constant: 25).isActive = true

        pressure.topAnchor.constraint(equalTo: feelsLike.topAnchor).isActive = true
        pressure.trailingAnchor.constraint(equalTo: vSeparator3.leadingAnchor, constant: -25).isActive = true

        uvIndex.topAnchor.constraint(equalTo: feelsLike.topAnchor).isActive = true
        uvIndex.leadingAnchor.constraint(equalTo: vSeparator4.trailingAnchor, constant: 25).isActive = true

        hourlyView.topAnchor.constraint(equalTo: pressure.bottomAnchor, constant: 20).isActive = true
        hourlyView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        hourlyView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        hourlyView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        dailyView.topAnchor.constraint(equalTo: hourlyView.bottomAnchor, constant: 20).isActive = true
        dailyView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        dailyView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        dailyView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
