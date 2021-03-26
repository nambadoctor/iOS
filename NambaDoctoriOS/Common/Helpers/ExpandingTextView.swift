//
//  ExpandingTextView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/03/21.
//

import Foundation
import SwiftUI

struct WrappedTextView: UIViewRepresentable {
    typealias UIViewType = UITextView

    @Binding var text: String
    let textDidChange: (UITextView) -> Void

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isEditable = true
        view.delegate = context.coordinator
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = self.text
        uiView.font = .systemFont(ofSize: 14)
        uiView.backgroundColor = UIColor(Color.gray.opacity(0.09))
        DispatchQueue.main.async {
            self.textDidChange(uiView)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, textDidChange: textDidChange)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String
        let textDidChange: (UITextView) -> Void

        init(text: Binding<String>, textDidChange: @escaping (UITextView) -> Void) {
            self._text = text
            self.textDidChange = textDidChange
        }

        func textViewDidChange(_ textView: UITextView) {
            self.text = textView.text
            self.textDidChange(textView)
        }
    }
}

struct ExpandingTextView: View {
    @Binding var text: String
    let minHeight: CGFloat = 25
    
    @State private var textViewHeight: CGFloat?

    var body: some View {
        WrappedTextView(text: $text, textDidChange: self.textDidChange)
            .cornerRadius(10)
            .frame(height: textViewHeight ?? minHeight)
    }

    private func textDidChange(_ textView: UITextView) {
        self.textViewHeight = max(textView.contentSize.height, minHeight)
    }
}
