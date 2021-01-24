//
//  InvestigationsViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation

class InvestigationsViewModel:ObservableObject {
    @Published var investigations: [String] = []
    @Published var investigationTemp:String = ""

    func removeInvestigationRows(at offsets: IndexSet) {
        investigations.remove(atOffsets: offsets)
    }

    func appendInvestigation() {
        guard !investigationTemp.isEmpty else {
            //show empty field alert locally
            return
        }

        investigations.append(investigationTemp)
        investigationTemp = ""
    }
    
    func addTempIntoArrayWhenFinished () {
        if !investigationTemp.isEmpty {
            investigations.append(investigationTemp)
        }
    }

    func parsePlanIntoInvestigationsArr(planInfo:String) {
        investigations = planInfo.components(separatedBy: ";")
    }
}
