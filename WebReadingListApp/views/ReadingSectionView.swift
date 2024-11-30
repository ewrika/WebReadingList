//
//  ReadingListView.swift
//  WebReadingListApp
//
//  Created by Георгий Борисов on 29.11.2024.
//

import SwiftUI

struct ReadingSectionView: View {

    @Bindable var readingViewModel: ReadingDataViewModel

    var body: some View {
        Section("ReadingList"){
            ForEach($readingViewModel.readingList, editActions: [.move, .delete]) { $item in
                ReadingItemRow(readingItem: item)
                    .tag(ContentView.NavigationSelection.readingItem(item: item))
                    .swipeActions(edge: .leading) {
                        Button("Toggle isFinished") {
                            item.hasFinishedReading.toggle()
                        }
                    }
            }
        }

    }
}

private struct ReadingItemRow: View {
    let readingItem: ReadingItem

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: readingItem.hasFinishedReading ? "book.fill" : "book")
                .foregroundStyle(.green)

            VStack(alignment: .leading) {
                Text(readingItem.title)
                Text(readingItem.creationdate.formatted(.dateTime))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }

    }
}

#Preview {
    @State var selection: ReadingItem?
    
        return ReadingSectionView(readingViewModel: ReadingDataViewModel())
    
}
