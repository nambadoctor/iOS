//
//  DoctorAppointmentViewModelProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 05/02/21.
//

import Foundation

protocol DoctorAppointmentViewModelProtocol {
    func retrieveDocAppointmentList (_ completion: @escaping ((_ appointmentList:[ServiceProviderAppointment]?)->()))
}
