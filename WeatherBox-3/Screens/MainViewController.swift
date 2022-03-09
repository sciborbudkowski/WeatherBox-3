import UIKit
import Combine
import CoreLocation
import Elephant

class MainViewController: UIViewController {

    var cancellables = Set<AnyCancellable>()
    var locationQueue = DispatchQueue(label: "locationQueue")
    var weather = APIClient.init(baseURL: Settings.shared.weatherAPIBaseURL)

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
        weather.dispatch(WeatherRequest())
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] weather in
                print(weather)
            })
            .store(in: &cancellables)
    }
}

