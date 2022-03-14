import Foundation

struct AqiModel: Codable {
    var list: [AqiDetails]
}

struct AqiDetails: Codable {
    var main: AqiIndex
    var components: AqiComponents
    var dt: Int
}

struct AqiIndex: Codable {
    var aqi: Int
}

struct AqiComponents: Codable {
    var co: Double
    var no: Double
    var no2: Double
    var o3: Double
    var so2: Double
    var pm25: Double
    var pm10: Double
    var nh3: Double
}

struct Aqi: Request {
    typealias ReturnType = AqiModel
    var path: String = "/data/2.5/air_pollution/forecast"
    var queryParams: [String : String]? = [:]

    var latitude: String
    var longitude: String

    init(latitude: String, longitude: String) {
        self.latitude = latitude
        self.longitude = longitude

        queryParams = [
            "appid": Secrets.shared.weatherAPIKey,
            "lat": latitude,
            "lon": longitude
        ]
    }
}
