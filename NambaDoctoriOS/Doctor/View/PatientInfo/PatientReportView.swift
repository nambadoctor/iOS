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
                Text("Report could not load")
                    .foregroundColor(.yellow)
                    .bold()
                    .padding()
            case .display:
                Image(uiImage: patientReportVM.mediaObject!)
            }
        }
        .frame(width: 100, height: 160)
        .background(Color.yellow.opacity(0.2))
        .cornerRadius(10)
        .padding([.top, .trailing])
        .sheet(isPresented: self.$patientReportVM.showReportSheet) {
            Image(uiImage: patientReportVM.mediaObject!)
                .resizable()
                .scaledToFit()
                .pinchToZoom()
        }
    }
}
