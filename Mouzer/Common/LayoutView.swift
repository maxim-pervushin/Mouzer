//
// Created by Maxim Pervushin on 16.09.2021.
//

import Cocoa

class LayoutView: NSView {

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    internal func setupUI() {
    }

    class func make(_ tableView: NSTableView, identifier: NSUserInterfaceItemIdentifier) -> Self {
        if let result = (tableView.makeView(withIdentifier: identifier, owner: nil) as? Self) {
            return result
        } else {
            let result = Self()
            result.identifier = identifier
            return result
        }
    }
}
