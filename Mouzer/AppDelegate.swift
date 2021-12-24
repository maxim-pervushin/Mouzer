//
//  AppDelegate.swift
//  Mouzer
//
//  Created by Maxim Pervushin on 16.09.2021.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    private let eventProcessor = EventProcessor()
    private let remapManager = RemapManager()
    private let statusBarManager = StatusBarManager()

    private var activeWindowCount = 0 {
        didSet {
            if oldValue != activeWindowCount {
                adjustDockIconVisibility()
            }
        }
    }

    private lazy var remapListVC: RemapListVC = {
        let vc = RemapListVC()
        vc.remapManager = remapManager
        return vc
    }()

    private lazy var remapListWindow: NSWindow = {
        let window = NSWindow(contentViewController: remapListVC)
        window.styleMask = [.titled, .closable, .resizable]
        window.delegate = self
        return window
    }()

    private lazy var aboutWindow: NSWindow = {
        let window = NSWindow(contentViewController: AboutVC())
        window.styleMask = [.titled, .closable]
        window.delegate = self
        return window
    }()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        eventProcessor.delegate = self
        eventProcessor.start()
        statusBarManager.delegate = self

        adjustDockIconVisibility()

        // statusBarManager.appUpdateInfo = .init(title: "New version is here!".localized, url: URL(string: "https://github.com/maxim-pervushin")!)
    }

    private func adjustDockIconVisibility() {
        NSApp.setActivationPolicy(activeWindowCount > 0 ? .regular : .accessory)
    }
}

extension AppDelegate: NSWindowDelegate {

    public func windowWillClose(_ notification: Notification) {
        activeWindowCount -= 1
    }
}

extension AppDelegate: StatusBarManagerDelegate {

    func showPreferences(statusBarManager: StatusBarManager) {
        remapListWindow.makeKeyAndOrderFront(self)
        NSApp.activate(ignoringOtherApps: true)
        activeWindowCount += 1
    }

    func showAbout(statusBarManager: StatusBarManager) {
        aboutWindow.makeKeyAndOrderFront(self)
        NSApp.activate(ignoringOtherApps: true)
        activeWindowCount += 1
    }
}

extension AppDelegate: EventProcessorDelegate {

    func eventProcessor(_ eventProcessor: EventProcessor, event: Remap.Event, isDown: Bool) -> Bool {
        if remapListWindow.isVisible && remapListVC.process(event: event) {
            return false
        } else {
            return remapManager.process(event: event, isDown: isDown)
        }
    }
}
