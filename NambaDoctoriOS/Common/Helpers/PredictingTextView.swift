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

    var changeDelegate:(()->Void)?
    
    @Binding var isFirstResponder:Bool

    init(predictableValues: Binding<Array<ServiceProviderAutofillMedicine>>, predictedValues: Binding<Array<ServiceProviderAutofillMedicine>>, textFieldInput: Binding<String>, changeDelegate:@escaping () -> Void, textFieldTitle: String? = "", predictionInterval: Double? = 0.001, isFirstResponder:Binding<Bool>) {
        self._predictableValues = predictableValues
        self._predictedValues = predictedValues
        self._textFieldInput = textFieldInput
        self.changeDelegate = changeDelegate
        self.textFieldTitle = textFieldTitle
        self.predictionInterval = predictionInterval
        self._isFirstResponder = isFirstResponder
    }

    var body: some View {
        if isFirstResponder {
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
        } else {
            TextField(self.textFieldTitle ?? "", text: self.$textFieldInput, onEditingChanged: { editing in self.realTimePrediction(status: editing)}, onCommit: { self.makePrediction()})
                .frame(height: 5)
                .padding()
                .font(.system(size: 14))
                .background(Color.gray.opacity(0.09))
                .cornerRadius(10)
                .padding(.trailing)
        }
    }

    private func realTimePrediction(status: Bool) {
        self.changeDelegate!()
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
                    if value.BrandName.lowercased().contains(self.textFieldInput.lowercased()) ||
                        value.Ingredients.lowercased().contains(self.textFieldInput.lowercased())
                    {
                        if !self.checkPredictedValues(value: value) {
                            if checkIfInitialCharMatch(value: value.Ingredients.lowercased(), input: self.textFieldInput.lowercased()) ||
                                checkIfInitialCharMatch(value: value.BrandName.lowercased(), input: self.textFieldInput.lowercased()){
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
        
        self.predictedValues.sorted(by: { $0.AutofillMedicineId > $1.AutofillMedicineId })
    }

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
