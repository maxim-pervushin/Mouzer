//
// Created by Maxim Pervushin on 30.11.2021.
//

import Cocoa

extension NSButton {

    static func createPushButton(title: String) -> NSButton {
        let result = NSButton()
        result.setButtonType(.momentaryPushIn)
        result.bezelStyle = .rounded
        result.title = title
        return result
    }
}
