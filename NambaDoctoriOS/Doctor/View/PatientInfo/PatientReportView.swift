//
//  PatientReportView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 05/02/21.
//

import SwiftUI

struct PatientReportView: View {
    @ObservedObject var patientReportVM:PatientReportViewModel
    
    init(report:Nambadoctor_V1_ReportDownloadObject) {
        patientReportVM = PatientReportViewModel(report: report)
    }

    var body: some View {
        VStack {
            if patientReportVM.mediaObject == nil {
                Indicator()
            } else {
                Image(uiImage: patientReportVM.mediaObject!)
            }
        }
    }
}
