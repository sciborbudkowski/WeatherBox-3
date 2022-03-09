import UIKit

extension UIFont {

    public enum FontType: String {
        case black = "-Black"
        case blackItalic = "-BlackItalic"
        case bold = "-Bold"
        case boldItalic = "-BoldItalic"
        case extraBold = "-ExtraBold"
        case extraBoldItalic = "-ExtraBoldItalic"
        case extraLight = "-ExtraLight"
        case extraLightItalic = "-ExtraLightItalic"
        case italic = "-Italic"
        case light = "-Light"
        case lightItalic = "-LightItalic"
        case medium = "-Medium"
        case mediumItalic = "-MediumItalic"
        case regular = "-Regular"
        case semiBold = "-SemiBold"
        case semiBoldItalic = "-SemiBoldItalic"
    }

    static func getDefaultFont(_ type: FontType = .regular, ofSize: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "Nunito\(type.rawValue)", size: ofSize)!
    }
}
