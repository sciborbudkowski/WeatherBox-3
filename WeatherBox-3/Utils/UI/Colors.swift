import UIKit

class Colors {

    static let primaryTextColor = UIColor(20, 20, 20)
    static let secondaryTextColor = UIColor(128, 128, 128)

    static let primaryNegativeTextColor = UIColor(235, 235, 235)

    static let mainBackgroundColor = UIColor(240, 240, 240)
    static let separatorColor = UIColor(245, 245, 245)

    static let temperatureDayBackgroundColor = UIColor(225, 225, 225)
    static let temperatureNightBackgroundColor = UIColor(50, 50, 50)

    static func getDailyCellBackgroundColor(_ value: Int) -> UIColor {
        if value % 2 == 0 {
            return UIColor(245, 245, 245)
        }

        return UIColor(255, 255, 255)
    }
}
