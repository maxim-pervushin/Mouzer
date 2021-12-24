//
// Created by Maxim Pervushin on 30.11.2021.
//

import Cocoa

class RemapListLayout: LayoutView {

    let scrollView = NSScrollView()
    let tableView = NSTableView()

    private (set) lazy var segmentedControl: NSSegmentedControl = {
        let result = NSSegmentedControl()
        result.trackingMode = .momentary
        result.segmentCount = 2
        result.setImage(NSImage(named: NSImage.addTemplateName), forSegment: 0)
        result.setImage(NSImage(named: NSImage.removeTemplateName), forSegment: 1)
        return result
    }()

    override func setupUI() {
        super.setupUI()

        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.documentView = tableView
        scrollView.borderType = .bezelBorder

        tableView.translatesAutoresizingMaskIntoConstraints = false
        let mouseButtonColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("MouseButtonColumn"))
        mouseButtonColumn.title = "Mouse button".localized
        tableView.addTableColumn(mouseButtonColumn)
        let shortcutColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("ShortcutColumn"))
        shortcutColumn.title = "Shortcut".localized
        tableView.addTableColumn(shortcutColumn)

        addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            scrollView.widthAnchor.constraint(greaterThanOrEqualToConstant: 320),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            scrollView.heightAnchor.constraint(greaterThanOrEqualToConstant: 240),

            segmentedControl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(lessThanOrEqualTo: scrollView.trailingAnchor),
            segmentedControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20),
            segmentedControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
}
