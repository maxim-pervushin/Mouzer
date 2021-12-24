//
// Created by Maxim Pervushin on 23.12.2021.
//

import Cocoa

class AboutVC: ContainerVC<AboutLayout> {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "About".localized
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        reloadData()
    }

    private func reloadData() {
        if !isViewLoaded {
            return
        }

        let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
        let appBuildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
        layoutView.versionTextField.stringValue = "\("Version".localized) \(appVersion) (\(appBuildNumber))"
    }
}
