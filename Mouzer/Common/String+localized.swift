//
// Created by Maxim Pervushin on 30.11.2021.
//

import Foundation

extension String {

    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}