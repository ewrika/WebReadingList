//
//  ReadingItem.swift
//  WebReadingListApp
//
//  Created by Георгий Борисов on 29.11.2024.
//

import Foundation
import Observation

@Observable
class ReadingItem: Identifiable, Hashable, Equatable, Codable {
    var title: String
    var url: URL
    let creationdate: Date
    var hasFinishedReading: Bool
    let id: UUID

    init(title: String,
         url: URL,
         creationdate: Date = Date(),
         hasFinishedReading: Bool = false,
         id: UUID = UUID()) {
        self.title = title
        self.url = url
        self.creationdate = creationdate
        self.hasFinishedReading = hasFinishedReading
        self.id = id
    }
    static func == (lhs: ReadingItem, rhs: ReadingItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    // MARK: preview helper
    static var example: ReadingItem {
        ReadingItem(title: "Apple", url: URL(string: "https://www.apple.com")!)
    }

    static var examples: [ReadingItem] {
        [.example,
         ReadingItem(title: "swiftyPlace", url: URL(string: "https://swiftyplace.com")!, hasFinishedReading: true),
         ReadingItem(title: "UIViewRepresentable", url: URL(string: "https://nilcoalescing")!)
        ]
    }
}
