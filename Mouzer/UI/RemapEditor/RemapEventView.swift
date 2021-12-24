//
// Created by Maxim Pervushin on 16.12.2021.
//

import Cocoa

class RemapEventView: ValueView<Remap.Event> {

    let textField = NSTextField.createLabel()

    override func setupUI() {
        super.setupUI()

        wantsLayer = true
        layer?.backgroundColor = NSColor(calibratedWhite: 1, alpha: 0.15).cgColor
        layer?.cornerRadius = 4
        layer?.masksToBounds = true

        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            textField.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
        ])
    }

    override func reloadUI(_ oldValue: Remap.Event?) {
        if oldValue == value {
            return
        }

        textField.stringValue = value?.descriptionString ?? ""
    }
}
