//
//  TwilioSwiftUIWrap.swift
//  NambaDoctor
//
//  Created by Surya Manivannan on 02/10/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI
import UIKit

struct TwilioViewHelper: UIViewControllerRepresentable {
    
    var appointmentId:String

    func makeUIViewController(context: Context) -> ViewController {
        return UIStoryboard(name: "Twilio", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = ViewController
}
