//
// Created by Maxim Pervushin on 30.11.2021.
//

import Cocoa

extension NSTextField {

    static func createLabel(stringValue: String? = nil) -> NSTextField {
        let textField = NSTextField()
        textField.drawsBackground = false
        textField.isEditable = false
        textField.isSelectable = false
        textField.isBordered = false
        textField.isBezeled = false
        textField.stringValue = stringValue ?? ""
        return textField
    }
}
