//
//  PatientReportView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 05/02/21.
//

import SwiftUI

struct PatientReportView: View {
    @ObservedObject var patientReportVM:PatientReportViewModel

    init(report:ServiceProviderReport) {
        patientReportVM = PatientReportViewModel(report: report)
    }

    var body: some View {
        VStack {
            switch patientReportVM.displayImage {
            case .loading:
                Indicator()
            case .notFound:
                EmptyView()
            case .display:
                ImageView(imageLoader: self.patientReportVM.imageLoader!)
            }
        }
        .frame(width: patientReportVM.displayImage == .display ? 100 : 0,
               height: patientReportVM.displayImage == .display ? 160 : 0)
        .cornerRadius(10)
        .padding([.top, .trailing])
    }
}
