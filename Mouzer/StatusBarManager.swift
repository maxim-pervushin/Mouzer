//
//  StatusBarManager.swift
//  Mouzer
//
//  Created by Maxim Pervushin on 16.09.2021.
//

import Cocoa

protocol StatusBarManagerDelegate: AnyObject {
    func showPreferences(statusBarManager: StatusBarManager)
    func showAbout(statusBarManager: StatusBarManager)
}

class StatusBarManager {

    var appUpdateInfo: AppUpdateInfo? {
        didSet {
            if oldValue != appUpdateInfo {
                reloadData()
            }
        }
    }

    weak var delegate: StatusBarManagerDelegate?

    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

    private var accessibilityMenuItem: NSMenuItem?
    private var appUpdateMenuItem: NSMenuItem?

    init() {
        let menu = NSMenu()
        statusItem.menu = menu

        let image = NSImage(named: "StatusBarIcon")
        image?.isTemplate = true

        statusItem.button?.image = image
        statusItem.button?.imageScaling = .scaleProportionallyUpOrDown
        statusItem.button?.image?.size = NSSize(width: 16.0, height: 16.0)

        accessibilityMenuItem = menu.addItem(withTitle: "Open Accessibility".localized, action: #selector(accessibilityMenuItemAction), keyEquivalent: "")
        accessibilityMenuItem?.target = self

        appUpdateMenuItem = menu.addItem(withTitle: "", action: #selector(appUpdateMenuItemAction), keyEquivalent: "")
        appUpdateMenuItem?.target = self

        menu.addItem(.separator())

        let preferencesMenuItem = menu.addItem(withTitle: "Preferences".localized, action: #selector(preferencesMenuItemAction), keyEquivalent: "")
        preferencesMenuItem.target = self

        menu.addItem(.separator())

        let aboutMenuItem = menu.addItem(withTitle: "About".localized, action: #selector(aboutMenuItemAction), keyEquivalent: "")
        aboutMenuItem.target = self

        menu.addItem(.separator())

        let quitItem = menu.addItem(withTitle: "Quit".localized, action: #selector(quitMenuItemAction), keyEquivalent: "")
        quitItem.target = self

        checkAccessibility()

        reloadData()
    }

    private func reloadData() {
        appUpdateMenuItem?.isHidden = appUpdateInfo == nil
        appUpdateMenuItem?.title = appUpdateInfo?.title ?? ""
    }

    private func checkAccessibility() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) { [weak self] in
            let checkOptPrompt = kAXTrustedCheckOptionPrompt.takeUnretainedValue() as NSString
            let options = [checkOptPrompt: true]
            if AXIsProcessTrustedWithOptions(options as CFDictionary?) {
                print("AXIsProcessTrusted", true)
                DispatchQueue.main.async {
                    self?.setAccessibilityMenuItemVisible(false)
                }
            } else {
                print("AXIsProcessTrusted", false)
                DispatchQueue.main.async {
                    self?.setAccessibilityMenuItemVisible(true)
                }
                self?.checkAccessibility()
            }
        }
    }

    private func setAccessibilityMenuItemVisible(_ visible: Bool) {
        accessibilityMenuItem?.isHidden = !visible
    }

    @objc private func accessibilityMenuItemAction() {
        if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility") {
            NSWorkspace.shared.open(url)
        }
    }

    @objc private func appUpdateMenuItemAction() {
        if let url = appUpdateInfo?.url {
            NSWorkspace.shared.open(url)
        }
    }

    @objc private func preferencesMenuItemAction() {
        delegate?.showPreferences(statusBarManager: self)
    }

    @objc private func aboutMenuItemAction() {
        delegate?.showAbout(statusBarManager: self)
    }

    @objc private func quitMenuItemAction() {
        NSApp.terminate(self)
    }
}
