//
//  WebNavigationBar.swift
//  WebReadingListApp
//
//  Created by Георгий Борисов on 30.11.2024.
//

import SwiftUI

struct WebNavigationBar: View {
    @Bindable var webViewState: WebViewState
    @State private var currentWebURL: String = ""
    var body: some View {
        HStack {
            Button(action: {
                webViewState.goBack()
            }) {
                Image(systemName: "chevron.backward")
            }
            .disabled(!webViewState.canGoBack)

            Button(action: {
                webViewState.goForward()
            }) {
                Image(systemName: "chevron.forward")
            }
            .disabled(!webViewState.canGoForward)

            TextField("current URL", text: $currentWebURL)
                .truncationMode(.middle)
                .textFieldStyle(.roundedBorder)
        }
        .onAppear {
            currentWebURL = webViewState.url?.absoluteString ?? ""
        }
        .onChange(of: webViewState.currentURL) { _, newValue in
            currentWebURL = newValue?.absoluteString ?? ""
        }
    }
}

#Preview {
    WebNavigationBar(webViewState: WebViewState())
}
