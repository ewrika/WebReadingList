//
//  WebViewState.swift
//  WebReadingListApp
//
//  Created by Георгий Борисов on 29.11.2024.
//

import Foundation
import Observation
import WebKit
import SwiftUI
@Observable
class WebViewState {

    var url: URL?
    var isLoading = false
    var error: Error?

    var currentURL: URL?
    var currentTitle: String?

    var canGoBack = false
    var canGoForward = false

    var successGeneratedPDFURL: URL?

    weak var webView: WKWebView?

    init(url: URL? = nil) {
        self.url = url
    }

    func userRequestedToOpen(_ url: URL) {
        self.url = url
        self.error = nil
        self.currentURL = nil
    }

    func update(isLoading: Bool, error: Error? = nil) {
        self.isLoading = isLoading
        self.error = error
    }

    func update(currentURL: URL?, currentTitle: String?) {
        self.currentURL = currentURL
        self.currentTitle = currentTitle
        updateNavigationState()
    }

    func updateNavigationState() {
        self.canGoBack = webView?.canGoBack ?? false
        self.canGoBack = webView?.canGoForward ?? false

    }

    func goBack() {
        webView?.goBack()
    }

    func goForward() {
        webView?.goForward()
    }

    func reload() {
        webView?.reload()
    }

    func createPDF() {
        guard let webView else {return}

        webView.createPDF { result in

            switch result {

            case .success(let data):
                self.savePDFToDisk(data)
            case .failure(let failure):
                print("error \(failure)")
                // TODO alert about error
            }

        }

    }

    func savePDFToDisk(_ data: Data) {
        let documentsURL = URL.documentsDirectory

        let title = webView?.title ?? "untitled"
        let fileURL = documentsURL.appendingPathComponent("\(title).pdf")

        do{
            try data.write(to: fileURL)
            withAnimation(.bouncy(duration: 2 )){
                self.successGeneratedPDFURL = fileURL
            }
            print("succes \(fileURL.absoluteString)")
        } catch {
            print("error\(error)")
        }
    }

}
