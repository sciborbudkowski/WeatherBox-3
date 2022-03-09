import Foundation

// https://api.openweathermap.org/data/2.5/onecall?lat=52.24101385689496&lon=21.015219&appid=1267ccba117cbc3938e51a0386683f80&units=metric&exclude=minutely

struct Weather: Codable {
    let sunrise: Int
    let sunset: Int
    let temperature: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let windSpeed: Int
    let windDegree: Int
    let windGust: Int
    let weather: [WeatherDetails]
}

struct WeatherDetails: Codable {
    let name: String
}

struct WeatherHourly: Codable {
    let hourly: [Weather]
}

struct WeatherRequest: Request {
    typealias ReturnType = Weather
    var path: String = "/data/2.5/onecall"
    var queryParams: [String : String]? = [:]

    var latitude: String
    var longitude: String

    init(latitude: String, longitude: String) {
        self.latitude = latitude
        self.longitude = longitude

        queryParams = [
            "appid": Secrets.shared.weatherAPIKey,
            "lat": latitude,
            "lon": longitude,
            "units": Settings.shared.temperatureUnit,
            "lang": Settings.shared.languageCode
        ]
    }
}
