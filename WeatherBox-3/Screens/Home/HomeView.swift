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

    var weatherIcon = SVGView(named: "weather_clearSky-day", animationOwner: .svg)

    var weatherNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getDefaultFont(.regular, ofSize: 30)
        label.textColor = Colors.secondaryTextColor
        label.text = "słonecznie"
        return label
    }()

    var wind: TextValueLabel = {
        let label = TextValueLabel()
        label.text.text = "wiatr"
        label.value.text = "12 km/h"
        return label
    }()

    var temperature: TextValueLabel = {
        let label = TextValueLabel()
        label.text.text = "temperatura"
        label.value.text = "11 °C"
        return label
    }()

    var humidity: TextValueLabel = {
        let label = TextValueLabel()
        label.text.text = "wilgotność"
        label.value.text = "34%"
        return label
    }()

    private let separator1: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.separatorColor
        return view
    }()

    private let separator2: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.separatorColor
        return view
    }()

    override func setupConstraints() {
        addSubviews([dayNameLabel, dateLabel, placeNameLabel,
                     weatherIcon, weatherNameLabel,
                     separator1, separator2,
                     wind, temperature, humidity])

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

        temperature.topAnchor.constraint(equalTo: weatherNameLabel.bottomAnchor, constant: 10).isActive = true
        temperature.centerXAnchor.constraint(equalTo: weatherNameLabel.centerXAnchor).isActive = true

        separator1.topAnchor.constraint(equalTo: temperature.topAnchor, constant: 5).isActive = true
        separator1.widthAnchor.constraint(equalToConstant: 2).isActive = true
        separator1.bottomAnchor.constraint(equalTo: temperature.bottomAnchor, constant: -5).isActive = true
        separator1.trailingAnchor.constraint(equalTo: temperature.leadingAnchor, constant: -25).isActive = true

        separator2.topAnchor.constraint(equalTo: temperature.topAnchor, constant: 5).isActive = true
        separator2.widthAnchor.constraint(equalToConstant: 2).isActive = true
        separator2.bottomAnchor.constraint(equalTo: temperature.bottomAnchor, constant: -5).isActive = true
        separator2.leadingAnchor.constraint(equalTo: temperature.trailingAnchor, constant: 25).isActive = true

        wind.topAnchor.constraint(equalTo: temperature.topAnchor).isActive = true
        wind.trailingAnchor.constraint(equalTo: separator1.leadingAnchor, constant: -25).isActive = true

        humidity.topAnchor.constraint(equalTo: temperature.topAnchor).isActive = true
        humidity.leadingAnchor.constraint(equalTo: separator2.trailingAnchor, constant: 25).isActive = true
    }
}
