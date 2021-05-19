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
        VStack {
            LargeButton(title: "Click to share prescription", backgroundColor: Color.blue, foregroundColor: Color.white) {
                self.sharePDF()
            }
            PDFKitRepresentedView(data)
        }
    }
    
    func sharePDF() {
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
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
