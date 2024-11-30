//
//  ReadingDataEditorView.swift
//  WebReadingListApp
//
//  Created by Георгий Борисов on 29.11.2024.
//

import SwiftUI

struct ReadingDataEditorView: View {
    @Bindable var readingViewModel: ReadingDataViewModel
    @State var newURLString = ""
    @State var title = ""

    @Environment(\.dismiss) var dismiss

    var body: some View {

        VStack(alignment: .leading) {

            Text("Create New Reading Item")
                .font(.title)

            TextField("title", text: $title)
            TextField("URL", text: $newURLString)
                .textInputAutocapitalization(.never)

            HStack {
                Spacer()
                Button("Cancel" ) {
                    dismiss()
                }.buttonStyle(.bordered)

                Button("Save" ) {
                    readingViewModel.addNewReadingItem(title: title, urlString: newURLString)
                    dismiss()
                }
                .disabled(title.isEmpty || newURLString.isEmpty)
                .buttonStyle(.borderedProminent)
            }

        }
        .textFieldStyle(.roundedBorder)
        .padding()
    }
}

#Preview {
    ReadingDataEditorView(readingViewModel: ReadingDataViewModel())
}
