import UIKit

struct DailyViewModel {
    var icon: String
    var sunrise: String
    var sunset: String
    var moonrise: String
    var moonset: String
    var moonPhase: Double
    var temperatures: Temperatures
    var pressure: Int
    var windSpeed: Double
    var weather: WeatherDetail
    var pop: Double
    var weekday: String
    var date: String
    var windIcon: String
}

class DailyViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    var items: [DailyViewModel] = []
    var aqis: [String] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyViewCell.identifier, for: indexPath) as? DailyViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: items[indexPath.row], and: indexPath.row)
        cell.setAqiIcon(aqis[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
