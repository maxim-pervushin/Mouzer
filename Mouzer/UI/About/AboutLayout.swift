//
// Created by Maxim Pervushin on 23.12.2021.
//

import Cocoa

class AboutLayout: LayoutView {

    let imageView = NSImageView()
    let stackView = NSStackView()
    let titleTextField = NSTextField.createLabel(stringValue: "Mouzer")
    let versionTextField = NSTextField.createLabel()
    let codeByNameTextField = NSTextField.createLabel(stringValue: "Programming by Maxim Pervushin")
    let codeByLinkTextField = NSTextField.createLinkLabel(stringValue: "https://github.com/maxim-pervushin/")
    let graphicsByNameTextField = NSTextField.createLabel(stringValue: "Graphics by Serge Rybkin")
    let graphicsByLinkTextField = NSTextField.createLinkLabel(stringValue: "https://rybkins.com/")
    let copyrightTextField = NSTextField.createLabel(stringValue: "© 2021 Maxim Pervushin")

    override func setupUI() {
        super.setupUI()

        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .init(named: "AppIcon")

        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8

        stackView.addArrangedSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.font = .boldSystemFont(ofSize: 20)

        stackView.addArrangedSubview(versionTextField)
        versionTextField.translatesAutoresizingMaskIntoConstraints = false
        stackView.setCustomSpacing(20, after: versionTextField)

        stackView.addArrangedSubview(codeByNameTextField)
        codeByNameTextField.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(codeByLinkTextField)
        codeByLinkTextField.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(graphicsByNameTextField)
        graphicsByNameTextField.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(graphicsByLinkTextField)
        graphicsByLinkTextField.translatesAutoresizingMaskIntoConstraints = false
        stackView.setCustomSpacing(20, after: graphicsByLinkTextField)

        stackView.addArrangedSubview(copyrightTextField)
        copyrightTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 96),
            imageView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 96),

            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
}
