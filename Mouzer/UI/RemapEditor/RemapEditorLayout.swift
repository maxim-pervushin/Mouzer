//
// Created by Maxim Pervushin on 30.11.2021.
//

import Cocoa

class RemapEditorLayout: LayoutView {

    let fromRemapEventView = RemapEventView()
    let arrowLabel = NSTextField.createLabel(stringValue: "→")
    let toRemapEventView = RemapEventView()
    let cancelButton = NSButton.createPushButton(title: "Cancel".localized)
    let submitButton = NSButton.createPushButton(title: "Submit".localized)

    override func setupUI() {
        super.setupUI()

        addSubview(fromRemapEventView)
        fromRemapEventView.translatesAutoresizingMaskIntoConstraints = false
        fromRemapEventView.textField.usesSingleLineMode = true
        fromRemapEventView.textField.alignment = .right

        addSubview(arrowLabel)
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(toRemapEventView)
        toRemapEventView.translatesAutoresizingMaskIntoConstraints = false
        toRemapEventView.textField.usesSingleLineMode = true
        toRemapEventView.textField.alignment = .left

        addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false

        addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            fromRemapEventView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20),
            fromRemapEventView.widthAnchor.constraint(greaterThanOrEqualToConstant: 24 * 4),
            fromRemapEventView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            fromRemapEventView.heightAnchor.constraint(equalToConstant: 24),

            arrowLabel.leadingAnchor.constraint(equalTo: fromRemapEventView.trailingAnchor, constant: 8),
            arrowLabel.centerYAnchor.constraint(equalTo: fromRemapEventView.centerYAnchor),

            toRemapEventView.leadingAnchor.constraint(equalTo: arrowLabel.trailingAnchor, constant: 8),
            toRemapEventView.widthAnchor.constraint(greaterThanOrEqualToConstant: 24 * 4),
            toRemapEventView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            toRemapEventView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            toRemapEventView.heightAnchor.constraint(equalToConstant: 24),

            cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cancelButton.topAnchor.constraint(equalTo: fromRemapEventView.bottomAnchor, constant: 32),
            cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),

            submitButton.leadingAnchor.constraint(greaterThanOrEqualTo: cancelButton.trailingAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            submitButton.topAnchor.constraint(equalTo: toRemapEventView.bottomAnchor, constant: 32),
            submitButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
}
