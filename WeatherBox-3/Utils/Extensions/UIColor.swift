import UIKit

extension UIColor {

    convenience init(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat = 1.0) {
        let newR = CGFloat(red)/255
        let newG = CGFloat(green)/255
        let newB = CGFloat(blue)/255

        self.init(red: newR, green: newG, blue: newB, alpha: alpha)
    }
}
