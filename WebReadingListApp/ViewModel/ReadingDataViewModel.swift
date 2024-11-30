//
//  ReadingDataViewModel.swift
//  WebReadingListApp
//
//  Created by Георгий Борисов on 29.11.2024.
//

import Foundation
import Observation

@Observable
class ReadingDataViewModel {

    var readingList: [ReadingItem] = []

    init() {
        print("Текущий список чтения: \(readingList)")
    }

    func addNewReadingItem(title: String, urlString: String) {
        guard let url = URL(string: urlString) else {return}
        // TODO: show error to user if url not valid
        addNewReadingItem(title: title, url: url)
    }

    func addNewReadingItem(title: String, url: URL) {
        let new = ReadingItem(title: title, url: url)

        readingList.append(new)
        save()
    }

    func supportDirectory() -> URL? {
        do { return try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        } catch {
            print("error\(error)")
            return nil
        }
    }

    func fileURL() -> URL {
        let directory = supportDirectory() ?? URL.documentsDirectory
        return directory.appendingPathComponent("readingList.json")

    }

    func save() {
        // take swift types and convert to Data -> Codable
        do {
            let data = try JSONEncoder().encode(readingList)
            let url = fileURL()
            try data.write(to: url)
            print("file location \(url.absoluteString)")
        } catch {
            print("error \(error)")
        }
        // create url for file
        // write dat to file
    }

    func load() {
        let url = fileURL()
        do {
            let data = try Data(contentsOf: url)
            let readingItems = try JSONDecoder().decode([ReadingItem].self, from: data)
            self.readingList = readingItems
        } catch {
            print("error loading data: \(error)")
            useSampleData()
        }
    }

    func useSampleData() {
        self.readingList = ReadingItem.examples
    }
}
