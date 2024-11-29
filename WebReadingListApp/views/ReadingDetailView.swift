//
//  ReadingDetailView.swift
//  WebReadingListApp
//
//  Created by Георгий Борисов on 29.11.2024.
//

import SwiftUI

struct ReadingDetailView: View {
    let reading: ReadingItem
    var body: some View {
        // TODO: add webview
        Text(reading.url.absoluteString)
    }
}

#Preview {
    ReadingDetailView(reading: ReadingItem.example)
}
