//
//  PDFSectionView.swift
//  WebReadingListApp
//
//  Created by Георгий Борисов on 30.11.2024.
//

import SwiftUI

struct PDFSectionView: View {
    @Bindable var pdfViewModel :PDFViewModel
    @State private var isExpanded: Bool = false
    var body: some View {
        Section("Saved PDFs",isExpanded: $isExpanded) {
            ForEach(pdfViewModel.pdfFiles,id : \.self) { file in
                Text(file.lastPathComponent)
                    .lineLimit(1)
                    .tag(ContentView.NavigationSelection.pdf(url: file))
            }
        }
        .onAppear{
            pdfViewModel.loadPdfFiles()
        }
    }
}

#Preview {
    PDFSectionView(pdfViewModel: PDFViewModel())
}
