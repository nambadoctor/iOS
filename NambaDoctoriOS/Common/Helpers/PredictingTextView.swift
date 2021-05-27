//
//  PredictingTextView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/20/21.
//

import Foundation
import SwiftUI
import Introspect

struct PredictingTextField: View {

    @Binding var predictableValues: Array<ServiceProviderAutofillMedicine>

    @Binding var predictedValues: Array<ServiceProviderAutofillMedicine>

    @Binding var textFieldInput: String

    @State var predictionInterval: Double?

    @State var textFieldTitle: String?

    @State private var isBeingEdited: Bool = false

    var changeDelegate:ExpandingTextViewEditedDelegate

    init(predictableValues: Binding<Array<ServiceProviderAutofillMedicine>>, predictedValues: Binding<Array<ServiceProviderAutofillMedicine>>, textFieldInput: Binding<String>, changeDelegate:ExpandingTextViewEditedDelegate, textFieldTitle: String? = "", predictionInterval: Double? = 0.001) {

        self._predictableValues = predictableValues
        self._predictedValues = predictedValues
        self._textFieldInput = textFieldInput
        self.changeDelegate = changeDelegate
        self.textFieldTitle = textFieldTitle
        self.predictionInterval = predictionInterval
    }

    var body: some View {
        TextField(self.textFieldTitle ?? "", text: self.$textFieldInput, onEditingChanged: { editing in self.realTimePrediction(status: editing)}, onCommit: { self.makePrediction()})
            .frame(height: 5)
            .padding()
            .font(.system(size: 14))
            .background(Color.gray.opacity(0.09))
            .cornerRadius(10)
            .padding(.trailing)
            .introspectTextField { textField in
                textField.becomeFirstResponder()
            }
    }

    private func realTimePrediction(status: Bool) {
        self.changeDelegate.changed()
        self.isBeingEdited = status
        if status == true {
            Timer.scheduledTimer(withTimeInterval: self.predictionInterval ?? 0.0001, repeats: true) { timer in
                self.makePrediction()

                if self.isBeingEdited == false {
                    timer.invalidate()
                }
            }
        }
    }
    
    private func makePrediction() {
        self.predictedValues = []
        if !self.textFieldInput.isEmpty{
            for value in self.predictableValues {
                if self.textFieldInput.split(separator: " ").count > 1 {
                    //self.makeMultiPrediction(value: value)
                }else {
                    if value.MedicineBrandName.lowercased().contains(self.textFieldInput.lowercased()) ||
                        value.MedicineGenericName.lowercased().contains(self.textFieldInput.lowercased())
                    {
                        if !self.checkPredictedValues(value: value) {
                            if checkIfInitialCharMatch(value: value.MedicineGenericName.lowercased(), input: self.textFieldInput.lowercased()) ||
                                checkIfInitialCharMatch(value: value.MedicineBrandName.lowercased(), input: self.textFieldInput.lowercased()){
                                self.predictedValues.insert(value, at: 0)
                            } else {
                                self.predictedValues.append(value)
                            }
                        }
                    }
                }
            }
        } else {
            self.predictedValues = self.predictableValues
        }
    }

//    private func makeMultiPrediction(value: ServiceProviderAutofillMedicine) {
//        for subString in self.textFieldInput.split(separator: " ") {
//            if value.contains(String(subString)) || value.contains(self.capitalizeFirstLetter(smallString: String(subString))){
//                if !self.predictedValues.contains(value) {
//                    self.predictedValues.append(value)
//                }
//            }
//        }
//    }
    
    func checkIfInitialCharMatch (value:String, input:String) -> Bool {
        let inputLength = input.count
        
        if value.prefix(inputLength) == input {
            return true
        }
        
        return false
    }

    func checkPredictedValues (value:ServiceProviderAutofillMedicine) -> Bool {
        for val in predictedValues {
            if val.AutofillMedicineId == value.AutofillMedicineId {
                return true
            }
        }
        return false
    }
}
