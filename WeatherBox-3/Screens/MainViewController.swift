import UIKit
import Combine
import CoreLocation
import Elephant

class MainViewController: UIViewController {

    var cancellables = Set<AnyCancellable>()
    var locationQueue = DispatchQueue(label: "locationQueue")
    var weather = APIClient.init(baseURL: Settings.shared.weatherAPIBaseURL)
    var hourlyDataSource = HourlyViewDataSource()
    var dailyDataSource = DailyViewDataSource()
    var helper = MainViewHelper()

    private var locationHasSet: Bool = false {
        didSet {
            if locationHasSet {
                startWeatherService()
            }
        }
    }

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
        }).store(in: &cancellables)

        locationService.enable()
    }

    private func startWeatherService() {
        guard let locationInfo = locationInfo else { return }

        weather.dispatch(Weather(latitude: locationInfo.coordinates.latitude.formatted(),
                                 longitude: locationInfo.coordinates.longitude.formatted()))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] weather in
                self?.customView.humidity.value.text = String(weather.current.humidity).appending("%")
                self?.customView.temperature.value.text = String(format: "%0.f", weather.current.temp).appending(Settings.shared.temperatureSign)
                self?.customView.wind.value.text = String(format: "%0.f", weather.current.windSpeed).appending(Settings.shared.speedUnit)
                self?.customView.weatherNameLabel.text = weather.current.weather.first?.description
                self?.customView.pressure.value.text = String(weather.current.pressure).appending(" hPa")
                self?.customView.feelsLike.value.text = String(format: "%0.f", weather.current.feelsLike).appending(Settings.shared.temperatureSign)
                self?.customView.uvIndex.value.text = String(format: "%.2f", weather.current.uvi)

                if let weatherId = weather.current.weather.first?.id,
                   let weatherIcon = self?.helper.getWeatherIcon(weatherId,
                                                                 sunrise: weather.current.sunrise,
                                                                 sunset: weather.current.sunset,
                                                                 current: weather.current.dt) {
                    self?.customView.weatherIconName = weatherIcon
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
                    guard let weather = item.weather.first,
                          let icon = self?.helper.getWeatherIcon(weather.id, sunrise: item.sunrise, sunset: item.sunset, current: item.sunrise + 1) else { fatalError() }
                    return DailyViewModel(icon: icon,
                                          sunrise: item.sunrise,
                                          sunset: item.sunset,
                                          moonrise: item.moonrise,
                                          moonset: item.moonset,
                                          moonPhase: item.moonPhase,
                                          temperatures: item.temp,
                                          pressure: item.pressure,
                                          windSpeed: item.windSpeed,
                                          weather: weather,
                                          pop: item.pop)
                }

                self?.dailyDataSource.items = dailyItems
                self?.customView.dailyView.tableView.reloadData()
            })
            .store(in: &cancellables)
    }
}

