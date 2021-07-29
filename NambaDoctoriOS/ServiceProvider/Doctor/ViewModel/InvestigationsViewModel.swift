//
//  InvestigationsViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation

class InvestigationsViewModel:ObservableObject {
    @Published var investigations:[String] = [String]()
    @Published var investigationTemp:String = ""

    func removeInvestigationBySwiping(at offsets: IndexSet) {
        investigations.remove(atOffsets: offsets)
    }

    func removeInvestigationManually(investigation:String) {
        let index = investigations.firstIndex(of: investigation)
        self.investigations.remove(at: index!)
    }

    func appendInvestigation() {
        guard !investigationTemp.isEmpty else {
            //show empty field alert locally
            return
        }

        addInvestigation()
    }
    
    func addTempIntoArrayWhenFinished () {
        if !investigationTemp.isEmpty {
            addInvestigation()
        }
    }
    
    func addInvestigation () {
        investigations.append(investigationTemp)
        investigationTemp = ""
    }
}
