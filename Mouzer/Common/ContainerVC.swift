//
// Created by Maxim Pervushin on 16.09.2021.
//

import Cocoa

class ContainerVC<LayoutView: NSView>: NSViewController {

    var layoutView: LayoutView! {
        (view as! LayoutView)
    }

    override func loadView() {
        view = LayoutView()
    }
}
