//
//  CustomerMyDoctorsLocalList.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/4/21.
//

import Foundation

class CustomerMyDoctorsLocalList {
    let userDefaults = UserDefaults.standard
    func getList () -> [String] {
        let doctorIds:[String] = userDefaults.object(forKey: "customer_my_doctors_ids") as? [String] ?? [String]()
        return doctorIds
    }
    
    func addDoctorId (id:String) {
        let toAdd:[String] = [id]
        userDefaults.set(toAdd, forKey: "customer_my_doctors_ids")
    }
    
    func clearId (id:String) {
        var ids = getList()
        
        let indexToRemove = ids.firstIndex(of: id)
        
        if indexToRemove != nil {
            ids.remove(at: indexToRemove!)
        }
    }
}
