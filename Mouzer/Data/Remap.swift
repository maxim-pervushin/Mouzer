//
// Created by Maxim Pervushin on 24.09.2021.
//

import Foundation

struct Remap: Equatable {
    let from: Event
    let to: Event

    init(from: Event, to: Event) {
        self.from = from
        self.to = to
    }

    init?(from: Event?, to: Event?) {
        guard let from = from,
              let to = to else {
            return nil
        }

        self.from = from
        self.to = to
    }

    static func from(dictionary: [String: Any]?) -> Remap? {
        .init(
                from: Event.from(dictionary: dictionary?["from"] as? [String: Any]),
                to: Event.from(dictionary: dictionary?["to"] as? [String: Any])
        )
    }

    var dictionary: [String: Any] {
        [
            "from": from.dictionary,
            "to": to.dictionary,
        ]
    }
}
