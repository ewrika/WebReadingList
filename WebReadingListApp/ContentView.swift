//
//  ContentView.swift
//  WebReadingListApp
//
//  Created by Георгий Борисов on 29.11.2024.
//

import SwiftUI

struct ContentView: View {
    
    enum NavigationSelection : Identifiable,Hashable {
        case pdf(url:URL)
        case readingItem(item:ReadingItem)
        var id:String{
            switch self {
            case .pdf(let url):
                return url.absoluteString
            case .readingItem(let item):
                return item.id.uuidString
            }
        }
    }
    @State private var pdfViewModel = PDFViewModel()
    @State private var readingViewModel = ReadingDataViewModel()
    @State private var selection: NavigationSelection? = nil
    @State private var newReadingEditorIsShow: Bool = false

    
    
    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        NavigationSplitView {
            List(selection:$selection) {
                PDFSectionView(pdfViewModel: pdfViewModel)
                
                ReadingSectionView(readingViewModel: readingViewModel)
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
        } detail: {
            if let selection {
                
                switch selection {
                case .pdf(let url):
                    PDFViewer(fileURL: url, pdfViewModel: pdfViewModel)
                case .readingItem(let item):
                    ReadingDetailView(readingViewModel: readingViewModel, reading: item)

                }
                
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
