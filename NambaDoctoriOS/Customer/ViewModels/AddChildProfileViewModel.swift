//
//  AddChildProfileViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/22/21.
//

import Foundation

class AddChildProfileViewModel : ObservableObject {

    @Published var child:CustomerChildProfile = CustomerChildProfile(ChildProfileId: "", Name: "", Age: "", Gender: "", PreferredPhoneNumber: PhoneNumber(countryCode: "", number: "", type: "", phoneNumberID: ""), IsPrimaryContact: false)
    @Published var phoneNumber:PhoneNumberObj = PhoneNumberObj()
    @Published var showSheet:Bool = false
    
    var mostRecentlyAddedChild:String = ""
    
    func makeProfile () {
        CommonDefaultModifiers.showLoader()
        child.PreferredPhoneNumber = mapToPreferredPhoneNumber(phoneNumber: phoneNumber)
        CustomerProfileService().setChildProfile(child: child) { response in
            if response != nil {
                CommonDefaultModifiers.hideLoader()
                self.mostRecentlyAddedChild = response!
                self.showSheet = false
                self.resetValues()
            } else {
                print("ERROR UPLOADING")
            }
        }
    }
    
    func resetValues () {
        child = CustomerChildProfile(ChildProfileId: "", Name: "", Age: "", Gender: "", PreferredPhoneNumber: PhoneNumber(countryCode: "", number: "", type: "", phoneNumberID: ""), IsPrimaryContact: false)
        phoneNumber = PhoneNumberObj()
    }
    
    
    
    func findMostRecentChild (children:[CustomerChildProfile]) -> CustomerChildProfile? {
        for child in children {
            if child.ChildProfileId == mostRecentlyAddedChild {
                return child
            }
        }
        
        return nil
    }
    
    
    func togglePrimaryNumber (careTakerNumbers:[PhoneNumber]) {
        if child.IsPrimaryContact {
            for number in careTakerNumbers {
                if number.type == "Primary" {
                    self.phoneNumber.countryCode = number.countryCode
                    self.phoneNumber.number.text = number.number
                }
            }
        } else {
            phoneNumber = PhoneNumberObj()
        }
    }

    func mapToPreferredPhoneNumber (phoneNumber:PhoneNumberObj) -> PhoneNumber {
        return PhoneNumber(countryCode: phoneNumber.countryCode, number: phoneNumber.number.text, type: "", phoneNumberID: "")
    }
}

extension AddChildProfileViewModel : SideBySideCheckBoxDelegate {
    func itemChecked(value: String) {
        self.child.Gender = value
    }
}
