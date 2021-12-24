//
// Created by Maxim Pervushin on 20.12.2021.
//

import Foundation

extension Remap.Event {

    var dictionary: [String: Any] {
        switch self {
        case let .otherMouse(buttonNumber):
            return [
                "eventType": "otherMouse",
                "buttonNumber": buttonNumber,
            ]
        case let .hotkey(virtualKey, flags):
            return [
                "eventType": "hotkey",
                "virtualKey": virtualKey,
                "flags": flags.rawValue,
            ]
        }
    }
}
