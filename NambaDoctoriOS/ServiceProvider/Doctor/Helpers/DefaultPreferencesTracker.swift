//
//  DefaultPreferencesTracker.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/16/21.
//

import Foundation

class DefaultPreferencesTracker {
    
    func setClinicalInfoCollapseExpandSetting(expand:Bool) {
        let defaults = UserDefaults.standard
        defaults.set(expand, forKey: "ClinicalInfoExpand")
    }

    func getClinicalInfoCollapseExpandSetting() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: "ClinicalInfoExpand") as? Bool ?? false
    }
    
    func setCustomerVitalsCollapseExpandSetting(expand:Bool) {
        let defaults = UserDefaults.standard
        defaults.set(expand, forKey: "CustomerVitalsExpand")
    }

    func getCustomerVitalsCollapseExpandSetting() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: "CustomerVitalsExpand") as? Bool ?? false
    }
    
}
