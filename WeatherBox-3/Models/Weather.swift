import Foundation

struct WeatherModel: Codable {
    var timezone: String
    var timezoneOffset: Int
    var current: WeatherCurrent
    var hourly: [WeatherHourly]
    var daily: [WeatherDaily]
    var alerts: [WeatherAlert]?
}

struct WeatherCurrent: Codable {
    var dt: Int
    var temp: Double
    var humidity: Int
    var sunrise: Int
    var sunset: Int
    var uvi: Double
    var windDeg: Int
    var feelsLike: Double
    var clouds: Int
    var visibility: Int
    var windSpeed: Double
    var pressure: Int
    var weather: [WeatherDetail]
}

struct WeatherDetail: Codable {
    var id: Int
    var main: String
    var description: String
}

struct WeatherDaily: Codable {
    var dt: Int
    var temp: Temperatures
    var humidity: Int
    var sunrise: Int
    var sunset: Int
    var moonrise: Int
    var moonset: Int
    var uvi: Double
    var moonPhase: Double
    var windDeg: Int
    var windGust: Double
    var feelsLike: FeelLikes
    var weather: [WeatherDetail]
    var windSpeed: Double
    var pressure: Int
    var clouds: Int
    var pop: Double
}

struct WeatherHourly: Codable {
    var dt: Int
    var temp: Double
    var feelsLike: Double
    var pressure: Int
    var humidity: Double
    var uvi: Double
    var clouds: Int
    var visibility: Int
    var windSpeed: Double
    var windDeg: Double
    var windGust: Double
    var weather: [WeatherDetail]
    var pop: Double
}

struct Temperatures: Codable {
    var night: Double
    var min: Double
    var eve: Double
    var day: Double
    var max: Double
    var morn: Double
}

struct FeelLikes: Codable {
    var night: Double
    var eve: Double
    var day: Double
    var morn: Double
}

struct WeatherAlert: Codable {
    var senderName: String
    var event: String
    var start: Int
    var end: Int
    var description: String
}

struct Weather: Request {
    typealias ReturnType = WeatherModel
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
            "lang": Settings.shared.languageCode,
            "exclude": "minutely"
        ]
    }
}
