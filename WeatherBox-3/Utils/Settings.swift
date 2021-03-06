import Foundation
import CoreLocation

class Settings {

    static let shared = Settings()

    init() { }

    private let supportedLanguages = [
        "af",
        "al",
        "ar",
        "az",
        "bg",
        "ca",
        "cz",
        "da",
        "de",
        "el",
        "en",
        "eu",
        "fa",
        "fi",
        "fr",
        "gl",
        "he",
        "hi",
        "hr",
        "hu",
        "id",
        "it",
        "ja",
        "kr",
        "la",
        "lt",
        "mk",
        "no",
        "nl",
        "pl",
        "pt",
        "pt_br",
        "ro",
        "ru",
        "sv",
        "se",
        "sk",
        "sl",
        "sp",
        "es",
        "sr",
        "th",
        "tr",
        "ua",
        "uk",
        "vi",
        "zh_cn",
        "zh_tw",
        "zu"
    ]

    let weatherAPIBaseURL = "https://api.openweathermap.org"

    var languageCode: String {
        get {
            var lang = "en"
            let regionCode = Locale.current.regionCode?.lowercased()
            if let regionCode = regionCode, supportedLanguages.contains(regionCode) {
                lang = regionCode
            }

            return lang
        }
    }

    var temperatureUnit: String {
        get {
            if UnitTemperature.current == .celsius {
                return "metric"
            } else {
                return "imperial"
            }
        }
    }

    var speedMultiplier: Double {
        get {
            if temperatureUnit == "metric" {
                return 3.6
            } else {
                return 1.0
            }
        }
    }

    var speedUnit: String {
        get {
            if Locale.current.usesMetricSystem {
                return " km/h"
            } else {
                return " mph"
            }
        }
    }

    var temperatureSign: String {
        get {
            if UnitTemperature.current == .celsius {
                return " °C"
            } else {
                return " °F"
            }
        }
    }
}
