//
// Created by Maxim Pervushin on 30.11.2021.
//

import Cocoa

extension RemapListLayout {

    class RemapFromRow: ValueView<Remap> {

        private let textField = NSTextField.createLabel()

        override func setupUI() {
            super.setupUI()

            addSubview(textField)
            textField.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                textField.topAnchor.constraint(equalTo: topAnchor, constant: 2),
                textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            ])
        }

        override func reloadUI(_ oldValue: Remap?) {
            if oldValue == value {
                return
            }

            textField.stringValue = value?.from.descriptionString ?? ""
        }
    }
}
