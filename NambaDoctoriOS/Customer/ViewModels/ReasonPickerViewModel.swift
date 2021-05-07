//
//  ReasonPickerViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/6/21.
//

import Foundation

protocol ReasonPickedDelegate {
    func reasonSelected (reason:String)
}

class ReasonPickerViewModel : ObservableObject {
    var reasons:[String:String] = ["Injury":"person.injured",
                                   "Infection":"coronavirus",
                                   "Pregnant":"pregnant.woman",
                                   "Joint Pain":"figure.wave",
                                   "Fever":"thermometer",
                                   "Respiratory":"lungs.fill",
                                   "Phsychological":"psychology",
                                   "Sleeping Disorder":"moon.fill"]
    
    var OneLineReasonsToSHow:[String] = [String]()
    
    @Published var reason:String = ""
    @Published var showAllReasons:Bool = false
    
    var reasonPickedDelegate:ReasonPickedDelegate? = nil
    
    init() {
        self.OneLineReasonsToSHow.append("Injury")
        self.OneLineReasonsToSHow.append("Fever")
        self.OneLineReasonsToSHow.append("Pregnant")
    }
    
    func getValForKey (key:String) -> String {
        return self.reasons[key] ?? "image.not.supported.fill"
    }
    
    func reasonSelected () {
        let key = reason
        if key == "Injury" || key == "Fever" || key == "Pregnant" {
            //do nothing
        } else {
            self.OneLineReasonsToSHow.remove(at: 0)
            self.OneLineReasonsToSHow.insert(key, at: 0)
        }
        self.reasonPickedDelegate?.reasonSelected(reason: key)
        self.showAllReasons = false
    }
}
