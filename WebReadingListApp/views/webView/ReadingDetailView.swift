//
//  ReadingDetailView.swift
//  WebReadingListApp
//
//  Created by Георгий Борисов on 29.11.2024.
//

import SwiftUI

struct ReadingDetailView: View {
    @State private var webViewState = WebViewState()
    @Bindable var readingViewModel: ReadingDataViewModel
    let reading: ReadingItem

    var body: some View {
        VStack {
            ZStack {
                WebView(webViewState: webViewState)
                    .edgesIgnoringSafeArea(.bottom)
                if webViewState.isLoading {
                    ProgressView()
                        .controlSize(.extraLarge)
                } else if let error = webViewState.error {
                    Text(error.localizedDescription)
                        .foregroundStyle(.red)
                }
                if let url = webViewState.successGeneratedPDFURL {
                    SuccessSavedFileView(url: url)
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation(.bouncy(duration: 2 )){
                                    webViewState.successGeneratedPDFURL = nil
                                }
                            }
                        }
                }
            }
            WebNavigationBar(webViewState: webViewState)
                .padding()
                .background(.thinMaterial)
        }
        .onChange(of: reading) {_, newValue in
            webViewState.userRequestedToOpen(newValue.url)
        }
        .onAppear {
            webViewState.userRequestedToOpen(reading.url)
        }
        .toolbar {

            Menu("More", systemImage: "ellipsis.circle" ) {

                if let new = webViewState.url, webViewState.currentURL != new {
                    Button("Create new Reading " ){
                        readingViewModel.addNewReadingItem(title: webViewState.currentTitle ?? "title", url: new)
                    }
                }

                Button {
                    webViewState.createPDF()
                } label: {
                    Text("Save as PDF")
                }
            }
        }
    }

}

#Preview {
    NavigationStack {
        ReadingDetailView(readingViewModel: ReadingDataViewModel(), reading: ReadingItem.example)
    }
}
