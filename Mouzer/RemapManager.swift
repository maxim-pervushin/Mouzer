//
// Created by Maxim Pervushin on 24.09.2021.
//

import Foundation
import Cocoa

class RemapManager {

    static let changedNotification = Notification.Name("RemapManager.changed")

    enum Key: String {
        case remapList = "remapList"
    }

    private let defaultRemapList = [
        Remap(
                from: .otherMouse(buttonNumber: 3),
                to: .hotkey(virtualKey: CGKeyCode(9), flags: .maskCommand)
        ),
        Remap(
                from: .otherMouse(buttonNumber: 4),
                to: .hotkey(virtualKey: CGKeyCode(8), flags: .maskCommand)
        ),
    ]

    var remapList: [Remap] {
        get {
            UserDefaults.standard.array(forKey: Key.remapList.rawValue)?.compactMap({ Remap.from(dictionary: $0 as? [String: Any]) }) ?? []
        }
        set {
            UserDefaults.standard.set(newValue.map({ $0.dictionary }), forKey: Key.remapList.rawValue)
        }
    }

    private var observerList = [NSObjectProtocol]()

    init() {
        UserDefaults.standard.register(defaults: [
            Key.remapList.rawValue: defaultRemapList.map({ $0.dictionary })
        ])
        subscribe()
    }

    deinit {
        unsubscribe()
    }

    func process(event: Remap.Event, isDown: Bool) -> Bool {
        for remap in remapList {
            if remap.from == event {
                post(event: remap.to, isDown: isDown)
                return true
            }
        }

        return false
    }

    private func subscribe() {
        observerList = [
            NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: UserDefaults.standard, queue: nil) { [weak self] _ in
                self?.changed()
            }
        ]
    }

    private func unsubscribe() {
        observerList.forEach(NotificationCenter.default.removeObserver)
        observerList = []
    }

    private func post(event: Remap.Event, isDown: Bool) {
        if case let .hotkey(virtualKey, flags) = event {
            let event = CGEvent(keyboardEventSource: nil, virtualKey: virtualKey, keyDown: isDown)
            event?.flags = CGEventFlags(rawValue: flags.rawValue)
            event?.post(tap: .cghidEventTap)
        }
    }

    private func changed() {
        NotificationCenter.default.post(name: Self.changedNotification, object: self)
    }
}