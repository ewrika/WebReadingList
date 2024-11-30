//
//  PDFViewer.swift
//  WebReadingListApp
//
//  Created by Георгий Борисов on 30.11.2024.
//

import SwiftUI

struct PDFViewer: View {
    let fileURL: URL
    @Bindable var pdfViewModel : PDFViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        PDFViewWrapper(fileURL: fileURL)
            .toolbar{
                Button {
                    pdfViewModel.delete(fileURL)
                    dismiss()
                } label: {
                    Label("Delete" , systemImage: "trash")
                }
                ShareLink(item:fileURL)
            }
    }
}
