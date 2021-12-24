//
// Created by Maxim Pervushin on 20.12.2021.
//

import Foundation

extension Remap.Event {

    static func from(dictionary: [String: Any]?) -> Remap.Event? {
        switch dictionary?["eventType"] as? String {
        case "otherMouse":
            if let buttonNumber = dictionary?["buttonNumber"] as? Int64 {
                return .otherMouse(buttonNumber: buttonNumber)
            } else {
                return nil
            }

        case "hotkey":
            if let virtualKey = dictionary?["virtualKey"] as? CGKeyCode,
               let flags = dictionary?["flags"] as? UInt64 {
                return .hotkey(virtualKey: virtualKey, flags: CGEventFlags(rawValue: flags))
            } else {
                return nil
            }

        default:
            return nil
        }
    }
}
