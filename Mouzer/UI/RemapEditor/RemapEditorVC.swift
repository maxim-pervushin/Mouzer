//
// Created by Maxim Pervushin on 30.11.2021.
//

import Cocoa

class RemapEditorVC: ContainerVC<RemapEditorLayout> {

    struct Input: Equatable {
        var remap: Remap?
        var onFinish: ((Remap?) -> ())?

        static func ==(lhs: Input, rhs: Input) -> Bool {
            lhs.remap == rhs.remap
        }
    }

    struct Output: Equatable {
        var from: Remap.Event?
        var to: Remap.Event?
    }

    var input = Input() {
        didSet {
            output = .init(from: input.remap?.from, to: input.remap?.to)
        }
    }

    private (set) var output = Output() {
        didSet {
            if oldValue != output {
                reloadData()
            }
        }
    }

    func process(event: Remap.Event) -> Bool {
        if !isViewLoaded {
            return false
        }

        switch event {
        case .otherMouse:
            output.from = event
        case .hotkey:
            output.to = event
        }
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        layoutView.cancelButton.target = self
        layoutView.cancelButton.action = #selector(cancelButtonAction)

        layoutView.submitButton.target = self
        layoutView.submitButton.action = #selector(submitButtonAction)
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        reloadData()
    }

    private func reloadData() {
        if !isViewLoaded {
            return
        }

        layoutView.fromRemapEventView.value = output.from
        layoutView.toRemapEventView.value = output.to
    }

    @objc private func cancelButtonAction() {
        input.onFinish?(nil)
    }

    @objc private func submitButtonAction() {
        input.onFinish?(Remap(from: layoutView.fromRemapEventView.value, to: layoutView.toRemapEventView.value))
    }
}
