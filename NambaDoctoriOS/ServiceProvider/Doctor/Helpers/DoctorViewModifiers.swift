//
//  DoctorViewModifiers.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/27/21.
//

import Foundation
import SwiftUI

struct DetailedAppointmentViewIconModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaleEffect(0.8)
            .background(Color.blue.opacity(0.1))
            .foregroundColor(Color.blue)
            .cornerRadius(5)
            .padding(.vertical, 4)
    }
}

struct FootnoteTitleModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.footnote.bold())
            .foregroundColor(Color.black.opacity(0.4))
    }
}

struct DetailedAppointmentViewCardModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal)
    }
}
