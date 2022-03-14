import UIKit
import Combine
import CoreLocation
import Elephant

class MainViewController: UIViewController {

    var cancellables = Set<AnyCancellable>()

    var locationQueue = DispatchQueue(label: "locationQueue")
    var weatherQueue = DispatchQueue(label: "weatherQueue")
    var aqiQueue = DispatchQueue(label: "aqiQueue")

    var weather = APIClient.init(baseURL: Settings.shared.weatherAPIBaseURL)
    var aqi = APIClient.init(baseURL: Settings.shared.weatherAPIBaseURL)

    var hourlyDataSource = HourlyViewDataSource()
    var dailyDataSource = DailyViewDataSource()

    var helper = MainViewHelper()

    private var locationInfo: LocationInfo?

    let locationService = LocationService()

    private let customView = HomeView()

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        startLocationService()

        customView.hourlyView.collectionView.dataSource = hourlyDataSource
        customView.hourlyView.collectionView.delegate = hourlyDataSource

        customView.dailyView.tableView.dataSource = dailyDataSource
        customView.dailyView.tableView.delegate = dailyDataSource
    }

    private func startLocationService() {
        let _ = Future<Int, Never> { promise in
            self.locationService.manager.requestWhenInUseAuthorization()
            return promise(.success(1))
        }
            .delay(for: 2.0, scheduler: locationQueue)
            .receive(on: RunLoop.main)
            .sink { _ in }

        locationService.publisher.receive(on: RunLoop.main).sink(receiveCompletion: { _ in }, receiveValue: { [weak self] value in
            self?.locationInfo = value
            self?.customView.placeNameLabel.text = value.placeName
            if value.regionName != "" {
                self?.customView.placeNameLabel.text?.append(contentsOf: ", \(value.regionName)")
            }
            self?.startWeatherService()
            self?.startAqiService()
        }).store(in: &cancellables)

        locationService.enable()
    }

    private func startAqiService() {
        guard let locationInfo = locationInfo else { return }

        aqi.dispatch(Aqi(latitude: locationInfo.coordinates.latitude.formatted(),
                         longitude: locationInfo.coordinates.longitude.formatted()))
            .delay(for: 1.0, scheduler: aqiQueue)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] _ in
                self?.customView.setupConstraints()
            }) { [weak self] aqi in
                if let aqiIndex = aqi.list.first?.main.aqi,
                   let aqiIcon = aqiIcons[aqiIndex] {
                    self?.customView.setAqiIcon(aqi: aqiIcon)
                }

                _ = aqi.list.map { detail in
                    self?.dailyDataSource.aqis.append(aqiIcons[detail.main.aqi]!)
                }
            }
            .store(in: &cancellables)
    }

    private func startWeatherService() {
        guard let locationInfo = locationInfo else { return }

        weather.dispatch(Weather(latitude: locationInfo.coordinates.latitude.formatted(),
                                 longitude: locationInfo.coordinates.longitude.formatted()))
            .delay(for: 1.0, scheduler: weatherQueue)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] _ in
                self?.customView.setupConstraints()
            }, receiveValue: { [weak self] weather in
                self?.customView.humidity.value.text = String(weather.current.humidity).appending("%")
                self?.customView.temperature.value.text = weather.current.temp.asTemperatureString()
                self?.customView.wind.value.text = String(format: "%0.f", weather.current.windSpeed * Settings.shared.speedMultiplier).appending(Settings.shared.speedUnit)
                self?.customView.weatherNameLabel.text = weather.current.weather.first?.description
                self?.customView.pressure.value.text = String(weather.current.pressure).appending(" hPa")
                self?.customView.feelsLike.value.text = weather.current.feelsLike.asTemperatureString()
                self?.customView.uvIndex.value.text = String(format: "%.2f", weather.current.uvi)

                if let alerts = weather.alerts, !alerts.isEmpty {
                    self?.customView.alertIcon.isHidden = false
                }

                if let weatherId = weather.current.weather.first?.id,
                   let weatherIcon = self?.helper.getWeatherIcon(weatherId,
                                                                 sunrise: weather.current.sunrise,
                                                                 sunset: weather.current.sunset,
                                                                 current: weather.current.dt),
                   let beaufortDegree = self?.helper.getBeaufortDegree(for: weather.current.windSpeed * Settings.shared.speedMultiplier,
                                                                       and: Settings.shared.temperatureUnit),
                   let windIcon = beaufortIcons[beaufortDegree],
                   let uvIcon = uvIcons[Int(weather.current.uvi)],
                   let moonPhase = weather.daily.first?.moonPhase,
                   let moonIcon = self?.helper.getMoonIcon(for: moonPhase) {
                    self?.customView.setWeatherIcons(weather: weatherIcon, wind: windIcon, uvIndex: uvIcon, moonIcon: moonIcon)
                }

                let hourlyItems: [HourlyItemModel] = weather.hourly.map { item in
                    guard let weatherId = item.weather.first?.id,
                          let dailyIcon = self?.helper.getWeatherIcon(weatherId,
                                                                      sunrise: weather.current.sunrise,
                                                                      sunset: weather.current.sunset,
                                                                      current: weather.current.dt),
                          let hour = self?.helper.convertUnixTimeToHourlyNeed(item.dt)
                    else { fatalError() }

                    return HourlyItemModel(hour: hour,
                                           icon: dailyIcon,
                                           temperature: item.temp)
                }

                self?.hourlyDataSource.items = hourlyItems
                self?.customView.hourlyView.collectionView.reloadData()

                let dailyItems: [DailyViewModel] = weather.daily.map { item in
                    guard let self = self,
                          let weather = item.weather.first,
                          let icon = self.helper.getWeatherIcon(weather.id,
                                                                sunrise: item.sunrise,
                                                                sunset: item.sunset,
                                                                current: item.sunrise + 1) else { fatalError() }

                    let beaufortIcon = self.helper.getBeaufortDegree(for: item.windSpeed * Settings.shared.speedMultiplier,
                                                                     and: Settings.shared.temperatureUnit)
                    return DailyViewModel(icon: icon,
                                          sunrise: self.helper.convertUnixTimeToHourlyNeed(item.sunrise),
                                          sunset: self.helper.convertUnixTimeToHourlyNeed(item.sunset),
                                          moonrise: self.helper.convertUnixTimeToHourlyNeed(item.moonrise),
                                          moonset: self.helper.convertUnixTimeToHourlyNeed(item.moonset),
                                          moonPhase: item.moonPhase,
                                          temperatures: item.temp,
                                          pressure: item.pressure,
                                          windSpeed: item.windSpeed,
                                          weather: weather,
                                          pop: item.pop,
                                          weekday: self.helper.convertUnixTimeToWeekday(item.dt),
                                          date: self.helper.convertUnitTimeToDayMonth(item.dt),
                                          windIcon: beaufortIcons[beaufortIcon]!)
                }

                self?.dailyDataSource.items = dailyItems
                self?.customView.dailyView.tableView.reloadData()
            })
            .store(in: &cancellables)
    }
}

