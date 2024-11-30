//
//  PDFViewModel.swift
//  WebReadingListApp
//
//  Created by Георгий Борисов on 30.11.2024.
//

import Foundation
@Observable
class PDFViewModel {
    var pdfFiles: [URL] = []
    
    init(){
        loadPdfFiles()
    }
    
    func loadPdfFiles() {
        let directory = URL.documentsDirectory
        do {
           let fileURLs = try FileManager.default.contentsOfDirectory(at:directory, includingPropertiesForKeys: nil)
            self.pdfFiles = fileURLs.filter{ $0.pathExtension == "pdf" }
            
        } catch {
            print("error getting pdf file urls:\(error)")
        }
    }

    func delete(_ fileURL:URL) {
        
        do{
            try FileManager.default.removeItem(at: fileURL)
            loadPdfFiles()
        } catch {
            print("error:\(error)")
        }
    }
    
    
    
}
