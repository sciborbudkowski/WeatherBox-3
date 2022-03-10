import Foundation

extension Double {

    func asTemperatureString() -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.maximumFractionDigits = 0
        let nsn = NSNumber(value: self)
        var str = nf.string(from: nsn)!
        if str == "-0" {
            str = "0"
        }

        return str.appending(Settings.shared.temperatureSign)
    }
}
