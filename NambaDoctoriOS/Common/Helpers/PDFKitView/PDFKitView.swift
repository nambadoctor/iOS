//
//  PDFKitView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/2/21.
//

import Foundation
import PDFKit
import UIKit
import SwiftUI

struct PDFKitView: View {
    var data:Data
    var body: some View {
        PDFKitRepresentedView(data)
    }
}

struct PDFKitRepresentedView: UIViewRepresentable {
    let data:Data
    init(_ data: Data) {
        self.data = data
    }

    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(data: data)
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
        // Update the view.
    }
}
