import UIKit

struct DailyViewModel {
    var icon: String
    var sunrise: Int
    var sunset: Int
    var moonrise: Int
    var moonset: Int
    var moonPhase: Double
    var temperatures: Temperatures
    var pressure: Int
    var windSpeed: Double
    var weather: WeatherDetail
    var pop: Double
}

class DailyViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    var items: [DailyViewModel] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyViewCell.identifier, for: indexPath) as? DailyViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: items[indexPath.row], and: indexPath.row)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
