//
//  PDFViewWrapper.swift
//  WebReadingListApp
//
//  Created by Георгий Борисов on 01.12.2024.
//

import SwiftUI
import PDFKit

struct PDFViewWrapper: UIViewRepresentable {
    
    let fileURL: URL
    
    func makeUIView(context: Context) -> PDFView {
        PDFView()
    }
    
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.document = PDFDocument(url:fileURL)
    }
}
