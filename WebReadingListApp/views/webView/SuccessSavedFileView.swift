//
//  SuccessSavedFileView.swift
//  WebReadingListApp
//
//  Created by Георгий Борисов on 30.11.2024.
//

import SwiftUI

struct SuccessSavedFileView: View {

    let url: URL

    var body: some View {
        Label("Saved PDF to: \(url.lastPathComponent)", systemImage: "checkmark.circle.fill")
            .padding()
            .background(Color.green)
            .cornerRadius(5)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(50)
            .padding(.bottom, 0)
            .transition(.move(edge: .bottom))
    }
}
