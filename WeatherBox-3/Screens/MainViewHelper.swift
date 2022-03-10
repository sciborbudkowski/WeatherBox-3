import UIKit

class MainViewHelper {

    func getWeatherIcon(_ weatherId: Int, sunrise: Int, sunset: Int, current: Int) -> String? {
        var dayPart = "night"

        if current > sunrise, current < sunset {
            dayPart = "day"
        }

        return weatherIcons[weatherId]?.replacingOccurrences(of: "%", with: dayPart)
    }

    func getMoonIcon(for moonPhase: Double) -> String {
        switch moonPhase {
        case 0.0, 1.0: return moonIcons[0]!
        case 0.01...0.24: return moonIcons[1]!
        case 0.25: return moonIcons[2]!
        case 0.26...0.49: return moonIcons[3]!
        case 0.5: return moonIcons[4]!
        case 0.51...0.74: return moonIcons[5]!
        case 0.75: return moonIcons[6]!
        case 0.76...0.99: return moonIcons[7]!
        default: return moonIcons[0]!
        }
    }

    func convertUnixTimeToWeekday(_ time: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(time))
        let df = DateFormatter()
        df.dateFormat = "E"

        return df.string(from: date)
    }

    func convertUnitTimeToDayMonth(_ time: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(time))
        let df = DateFormatter()
        df.dateFormat = "dd.MM"

        return df.string(from: date)
    }

    func convertUnixTimeToHourlyNeed(_ time: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(time))
        let df = DateFormatter()
        df.dateFormat = "HH:mm"

        return df.string(from: date)
    }

    func convertUnitTimeToFulltime(_ time: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(time))
        let df = DateFormatter()
        df.dateFormat = "HH:mm:ss"

        return df.string(from: date)
    }

    func getBeaufortDegree(for windSpeed: Double, and system: String) -> Int {
        let convertedValue = Int(windSpeed)

        if system == "metric" {
            switch convertedValue {
            case 0: return 0
            case 1...6: return 1
            case 7...11: return 2
            case 12...19: return 3
            case 20...29: return 4
            case 30...39: return 5
            case 40...50: return 6
            case 51...62: return 7
            case 63...75: return 8
            case 76...87: return 9
            case 88...102: return 10
            case 103...117: return 11
            default: return 12
            }
        }

        if system == "imperial" {
            switch convertedValue {
            case 0: return 0
            case 1...3: return 1
            case 4...7: return 2
            case 8...12: return 3
            case 13...18: return 4
            case 19...24: return 5
            case 25...31: return 6
            case 32...38: return 7
            case 39...46: return 8
            case 47...54: return 9
            case 55...63: return 10
            case 64...72: return 11
            default: return 12
            }
        }

        return 0
    }
}
