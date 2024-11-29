//
//  ContentView.swift
//  WebReadingListApp
//
//  Created by Георгий Борисов on 29.11.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var readingViewModel = ReadingDataViewModel()

    @State private var selection: ReadingItem?

    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        NavigationSplitView {
            ReadingListView(readingViewModel: readingViewModel, selection: $selection)
        } detail: {
            if let selection {
                ReadingDetailView(readingViewModel: readingViewModel, reading: selection)
            } else {
                ContentUnavailableView("Select a Reading Item", systemImage: "book")
            }
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active: readingViewModel.load()
            case .background, .inactive: readingViewModel.save()
            @unknown default:
                break
            }
        }
    }
}

#Preview {
    ContentView()
}
