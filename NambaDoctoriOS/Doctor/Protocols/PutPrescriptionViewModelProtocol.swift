//
//  PutPrescriptionViewModelProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation

protocol PutPrescriptionViewModelProtocol {
    func writePrescriptionToDB(prescriptionViewModel:PrescriptionViewModel, _ completion : @escaping ((_ successfull:Bool)->()))
}
