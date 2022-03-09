import UIKit

class MainViewHelper {

    func getWeatherIcon(_ weatherId: Int, sunrise: Int, sunset: Int, current: Int) -> String? {
        var dayPart = "night"

        if current > sunrise, current < sunset {
            dayPart = "day"
        }

        return weatherIcons[weatherId]?.replacingOccurrences(of: "%", with: dayPart)
    }

    func convertUnixTimeToDailyNeed(_ time: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(time))
        let df = DateFormatter()
        df.dateFormat = "E"

        return df.string(from: date)
    }

    func convertUnixTimeToHourlyNeed(_ time: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(time))
        let df = DateFormatter()
        df.dateFormat = "HH:mm"

        return df.string(from: date)
    }
}
