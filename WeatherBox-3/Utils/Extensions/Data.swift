import Foundation

extension Data {

    var prettyJSON: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyString
    }
}
