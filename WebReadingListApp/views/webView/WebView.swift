//
//  WebView.swift
//  WebReadingListApp
//
//  Created by Георгий Борисов on 29.11.2024.
//

import SwiftUI
import WebKit
struct WebView: UIViewRepresentable {

    @Bindable var webViewState: WebViewState

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> some UIView {
        let view = WKWebView()
        if let url = webViewState.url {
            view.load(URLRequest(url: url))
        }
        view.navigationDelegate = context.coordinator
        webViewState.webView = view
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let wkWebView = uiView as? WKWebView else { return }
        if let url = webViewState.url, wkWebView.url != url {
            wkWebView.load(URLRequest(url: url))
        }
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            print("webView- DidStartNavigation")
            parent.webViewState.update(isLoading: true)
        }

        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            print("webView - didCommit")
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("weView - didFinish")
            parent.webViewState.update(isLoading: false)
            parent.webViewState.update(currentURL: webView.url, currentTitle: webView.title)
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
            print("webView did Fail \(error)")
            parent.webViewState.update(isLoading: false, error: error)
        }

    }

}

#Preview {
    let state = WebViewState()
    state.url = URL(string: "https://www.vk.com")
    return WebView(webViewState: state)
}
