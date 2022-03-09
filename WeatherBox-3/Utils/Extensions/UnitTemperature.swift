import Foundation

extension UnitTemperature {

    static var current: UnitTemperature {
        let measureFormatter = MeasurementFormatter()
        let measurement = Measurement(value: 0, unit: UnitTemperature.celsius)
        let result = measureFormatter.string(from: measurement)

        return result == "0°C" ? .celsius : .fahrenheit
    }
}
