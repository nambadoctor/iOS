//
//  TwilioSwiftUIWrap.swift
//  NambaDoctor
//
//  Created by Surya Manivannan on 02/10/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI
import UIKit

struct DoctorTwilioViewHelper: UIViewControllerRepresentable {
    
    @ObservedObject var doctorTwilioVM:DoctorTwilioViewModel

    func makeUIViewController(context: Context) -> ViewController {
        return doctorTwilioVM.viewController!
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = ViewController
}
