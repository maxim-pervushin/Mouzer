//
//  EventProcessor.swift
//  Mouzer
//
//  Created by Maxim Pervushin on 16.09.2021.
//

import Foundation
import Cocoa

protocol EventProcessorDelegate: AnyObject {
    func eventProcessor(_ eventProcessor: EventProcessor, event: Remap.Event, isDown: Bool) -> Bool
}

class EventProcessor {

    weak var delegate: EventProcessorDelegate?

    static let didChangeNotification = Notification.Name("MouseEventProcessor.didChange")

    private var eventTap: CFMachPort?

    private let eventTapCallback: CGEventTapCallBack = { proxy, type, event, userData in
        guard let userData = userData else {
            return Unmanaged.passUnretained(event)
        }

        let eventProcessor = Unmanaged<EventProcessor>.fromOpaque(userData).takeUnretainedValue()

        switch type {
        case .tapDisabledByTimeout,
             .tapDisabledByUserInput:
            if let eventTap = eventProcessor.eventTap {
                CGEvent.tapEnable(tap: eventTap, enable: true)
            }

        case .otherMouseDown:
            return eventProcessor.process(event: .otherMouse(buttonNumber: event.getIntegerValueField(.mouseEventButtonNumber)), isDown: true) == true
                    ? nil
                    : Unmanaged.passUnretained(event)

        case .otherMouseUp:
            return eventProcessor.process(event: .otherMouse(buttonNumber: event.getIntegerValueField(.mouseEventButtonNumber)), isDown: false) == true
                    ? nil
                    : Unmanaged.passUnretained(event)

        case .keyDown:
            return eventProcessor.process(event: .hotkey(virtualKey: CGKeyCode(event.getIntegerValueField(.keyboardEventKeycode)), flags: event.flags), isDown: true) == true
                    ? nil
                    : Unmanaged.passUnretained(event)

        case .keyUp:
            return eventProcessor.process(event: .hotkey(virtualKey: CGKeyCode(event.getIntegerValueField(.keyboardEventKeycode)), flags: event.flags), isDown: false) == true
                    ? nil
                    : Unmanaged.passUnretained(event)

        default:
            break
        }

        return Unmanaged.passUnretained(event)
    }

    var isActive: Bool {
        if let eventTap = eventTap {
            return CGEvent.tapIsEnabled(tap: eventTap)
        } else {
            return false
        }
    }

    func start() {
        if isActive {
            return
        }

        let eventMask =
                (1 << CGEventType.otherMouseUp.rawValue)
                        | (1 << CGEventType.otherMouseDown.rawValue)
                        | (1 << CGEventType.keyDown.rawValue)
                        | (1 << CGEventType.keyUp.rawValue)

        guard let eventTap = CGEvent.tapCreate(tap: .cghidEventTap, place: .headInsertEventTap, options: .defaultTap, eventsOfInterest: CGEventMask(eventMask), callback: eventTapCallback, userInfo: Unmanaged.passUnretained(self).toOpaque()) else {
            print("ERROR: Unable to create event tap")
            return
        }

        self.eventTap = eventTap

        CFRunLoopAddSource(CFRunLoopGetCurrent(), CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0), .commonModes)
        CGEvent.tapEnable(tap: eventTap, enable: true)
    }

    func stop() {
        if !isActive && eventTap != nil {
            return
        }

        CGEvent.tapEnable(tap: eventTap!, enable: false)
        CFMachPortInvalidate(eventTap!)
        eventTap = nil
    }

    deinit {
        stop()
    }

    private func process(event: Remap.Event, isDown: Bool) -> Bool {
        delegate?.eventProcessor(self, event: event, isDown: isDown) ?? false
    }
}
