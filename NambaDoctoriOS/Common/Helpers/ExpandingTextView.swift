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
    var keyboardType:UIKeyboardType
    var changeDelegate:(()->Void)?
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
        uiView.keyboardType = keyboardType
        DispatchQueue.main.async {
            self.textDidChange(uiView)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, textDidChange: textDidChange, changeDelegate: self.changeDelegate ?? dummyCallBack)
    }
    
    func dummyCallBack() {
        
    }

    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String
        let textDidChange: (UITextView) -> Void
        var changeDelegate:(()->Void)?

        init(text: Binding<String>, textDidChange: @escaping (UITextView) -> Void, changeDelegate:@escaping () -> Void) {
            self._text = text
            self.textDidChange = textDidChange
            self.changeDelegate = changeDelegate
        }

        func textViewDidChange(_ textView: UITextView) {
            self.text = textView.text
            self.textDidChange(textView)
            self.changeDelegate!()
        }
    }
}

struct ExpandingTextView: View {
    @Binding var text: String
    let minHeight: CGFloat = 25
    var keyboardType:UIKeyboardType = .default
    var changeDelegate:(()->Void)?

    @State private var textViewHeight: CGFloat?

    var body: some View {
        WrappedTextView(text: $text, keyboardType: self.keyboardType, changeDelegate: self.changeDelegate, textDidChange: self.textDidChange)
            .cornerRadius(10)
            .frame(height: textViewHeight ?? minHeight)
    }

    private func textDidChange(_ textView: UITextView) {
        self.textViewHeight = max(textView.contentSize.height, minHeight)
    }
}
