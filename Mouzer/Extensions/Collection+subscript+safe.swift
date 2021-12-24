//
// Created by Maxim Pervushin on 30.11.2021.
//

import Foundation

extension Collection {

    subscript(safe index: Index?) -> Element? {
        if let index = index, indices.contains(index) {
            return self[index]
        } else {
            return nil
        }
    }
}
