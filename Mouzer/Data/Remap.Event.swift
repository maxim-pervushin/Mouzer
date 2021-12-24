//
// Created by Maxim Pervushin on 24.09.2021.
//

import Foundation

extension Remap {

    enum Event: Equatable {
        case otherMouse(buttonNumber: Int64)
        case hotkey(virtualKey: CGKeyCode, flags: CGEventFlags)
    }
}
