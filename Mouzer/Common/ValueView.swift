//
// Created by Maxim Pervushin on 30.11.2021.
//

import Cocoa

class ValueView<Value>: LayoutView {

    var value: Value? {
        didSet {
            reloadUI(oldValue)
        }
    }

    internal func reloadUI(_ oldValue: Value? = nil) {
    }

    class func make(_ tableView: NSTableView, identifier: NSUserInterfaceItemIdentifier, value: Value?) -> Self {
        let result = super.make(tableView, identifier: identifier)
        result.value = value
        return result
    }
}
