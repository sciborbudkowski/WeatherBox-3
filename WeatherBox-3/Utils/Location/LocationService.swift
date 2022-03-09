import Foundation
import Combine
import CoreLocation

struct LocationInfo {
    let coordinates: CLLocationCoordinate2D
    let placeName: String
    let regionName: String
}

final class LocationService: NSObject, CLLocationManagerDelegate {

    let manager = CLLocationManager()

    private let locationPublisher = PassthroughSubject<LocationInfo, Error>()

    var publisher: AnyPublisher<LocationInfo, Error>

    override init() {
        publisher = locationPublisher.eraseToAnyPublisher()

        super.init()
        manager.delegate = self
    }

    func enable() {
        manager.startUpdatingLocation()
    }

    func disable() {
        manager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else { return }

        var placeName = ""
        var regionName = ""
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(currentLocation, completionHandler: { placemarks, error in
            guard let placemark = placemarks?.first else { return }
            placeName = placemark.locality ?? ""
            regionName = placemark.administrativeArea ?? ""

            let locationInfo = LocationInfo(coordinates: currentLocation.coordinate,
                                        placeName: placeName,
                                        regionName: regionName)

            self.locationPublisher.send(locationInfo)
        })
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationPublisher.send(completion: Subscribers.Completion.failure(error))
    }
}
