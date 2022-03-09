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
}
