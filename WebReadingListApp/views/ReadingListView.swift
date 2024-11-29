//
//  ReadingListView.swift
//  WebReadingListApp
//
//  Created by Георгий Борисов on 29.11.2024.
//

import SwiftUI

struct ReadingListView: View {

    @Bindable var readingViewModel: ReadingDataViewModel
    @Binding var selection: ReadingItem?
    @State private var newReadingEditorIsShow: Bool = false

    var body: some View {
        List($readingViewModel.readingList, editActions: [.move, .delete], selection: $selection) { $item in
            ReadingItemRow(readingItem: item)
                .tag(item)
                .swipeActions(edge: .leading) {
                    Button("Toggle isFinished") {
                        item.hasFinishedReading.toggle()
                    }
                }
        }
        .toolbar {
            Button {
                newReadingEditorIsShow.toggle()
            } label: {
                Label("Add new Reading Item", systemImage: "plus")
            }
            EditButton()
        }
        .sheet(isPresented: $newReadingEditorIsShow) {
            ReadingDataEditorView(readingViewModel: readingViewModel)
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
    return ReadingListView(readingViewModel: ReadingDataViewModel(), selection: $selection)

}
