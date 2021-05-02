//
//  CustomerTwilioViewHelper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/30/21.
//

import SwiftUI
import UIKit

struct CustomerTwilioViewHelper: UIViewControllerRepresentable {
    
    @ObservedObject var customerTwilioVM:CustomerTwilioViewModel

    func makeUIViewController(context: Context) -> ViewController {
        return customerTwilioVM.viewController!
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = ViewController
}
