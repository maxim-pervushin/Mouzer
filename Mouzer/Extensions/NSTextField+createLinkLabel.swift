//
// Created by Maxim Pervushin on 24.12.2021.
//

import Cocoa

extension NSTextField {

    static func createLinkLabel(stringValue: String? = nil) -> NSTextField {
        let textField = NSTextField()
        textField.drawsBackground = false
        textField.isEditable = false
        textField.allowsEditingTextAttributes = true
        textField.isSelectable = true
        textField.isBordered = false
        textField.isBezeled = false
        if let stringValue = stringValue {
            let attributedString = NSMutableAttributedString(string: stringValue)
            attributedString.beginEditing()
            let range = NSRange(location: 0, length: attributedString.length)
            attributedString.addAttribute(.link, value: stringValue, range: range)
            attributedString.addAttribute(.foregroundColor, value: NSColor.blue, range: range)
            attributedString.addAttribute(.underlineStyle, value: NSNumber(integerLiteral: NSUnderlineStyle.single.rawValue), range: range)
            attributedString.endEditing()
            textField.attributedStringValue = attributedString
        }
        return textField
    }
}
