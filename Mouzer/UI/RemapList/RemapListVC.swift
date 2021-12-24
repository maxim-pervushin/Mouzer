//
// Created by Maxim Pervushin on 30.11.2021.
//

import Cocoa

class RemapListVC: ContainerVC<RemapListLayout> {

    var remapManager: RemapManager? {
        didSet {
            if oldValue !== remapManager {
                reloadData()
            }
        }
    }

    func process(event: Remap.Event) -> Bool {
        remapEditorVC?.process(event: event) ?? false
    }

    private weak var remapEditorVC: RemapEditorVC?
    private var observerList = [NSObjectProtocol]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Preferences".localized

        layoutView.tableView.dataSource = self
        layoutView.tableView.delegate = self
        layoutView.tableView.doubleAction = #selector(tableViewDoubleAction(_:))

        layoutView.segmentedControl.target = self
        layoutView.segmentedControl.action = #selector(segmentedControlAction(_:))
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        reloadData()
        subscribe()
    }

    override func viewDidDisappear() {
        unsubscribe()
        super.viewDidDisappear()
    }

    private func reloadData() {
        if !isViewLoaded {
            return
        }

        layoutView.tableView.reloadData()
        layoutView.segmentedControl.setEnabled(layoutView.tableView.selectedRow != -1, forSegment: 1)
    }

    private func subscribe() {
        observerList = [
            NotificationCenter.default.addObserver(forName: RemapManager.changedNotification, object: nil, queue: .main) { [weak self] _ in
                self?.reloadData()
            }
        ]
    }

    private func unsubscribe() {
        observerList.forEach(NotificationCenter.default.removeObserver)
        observerList = []
    }

    private func showRemapEditor(_ remap: Remap? = nil) {
        let remapEditorVC = RemapEditorVC()
        remapEditorVC.input.remap = remap
        remapEditorVC.input.onFinish = { [weak self, weak remapEditorVC] updatedRemap in
            if let updatedRemap = updatedRemap {
                self?.update(remap, updatedRemap)
            }
            remapEditorVC?.dismiss(nil)
        }
        presentAsSheet(remapEditorVC)
        self.remapEditorVC = remapEditorVC
    }

    private func update(_ remap: Remap?, _ updatedRemap: Remap?) {
        if let remap = remap {
            remapManager?.remapList = remapManager?.remapList.filter {
                $0 != remap
            } ?? []
        }
        if let updatedRemap = updatedRemap {
            remapManager?.remapList.append(updatedRemap)
        }
    }

    private func removeSelectedRemap() {
        if layoutView.tableView.selectedRow != -1 {
            remapManager?.remapList.remove(at: layoutView.tableView.selectedRow)
        }
    }

    @objc private func segmentedControlAction(_ sender: NSSegmentedControl) {
        switch sender.selectedSegment {
        case 0:
            showRemapEditor()
        case 1:
            removeSelectedRemap()
        default:
            break
        }
    }

    @objc private func tableViewDoubleAction(_ sender: NSTableView) {
        if sender.selectedRow != -1 {
            showRemapEditor(remapManager?.remapList[safe: sender.selectedRow])
        }
    }
}

extension RemapListVC: NSTableViewDataSource {

    public func numberOfRows(in tableView: NSTableView) -> Int {
        remapManager?.remapList.count ?? 0
    }
}

extension RemapListVC: NSTableViewDelegate {

    public func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        switch tableColumn?.identifier {
        case NSUserInterfaceItemIdentifier("MouseButtonColumn"):
            return RemapListLayout.RemapFromRow.make(tableView, identifier: NSUserInterfaceItemIdentifier("MouseButtonRow"), value: remapManager?.remapList[safe: row])
        case NSUserInterfaceItemIdentifier("ShortcutColumn"):
            return RemapListLayout.RemapToRow.make(tableView, identifier: NSUserInterfaceItemIdentifier("MouseButtonRow"), value: remapManager?.remapList[safe: row])
        default:
            return nil
        }
    }

    public func tableViewSelectionDidChange(_ notification: Notification) {
        // reloadData()
        layoutView.segmentedControl.setEnabled(layoutView.tableView.selectedRow != -1, forSegment: 1)
    }
}
