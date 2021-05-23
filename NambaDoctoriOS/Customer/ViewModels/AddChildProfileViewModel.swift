//
//  AddChildProfileViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/22/21.
//

import Foundation

class AddChildProfileViewModel : ObservableObject {

    @Published var child:CustomerChildProfile = CustomerChildProfile(ChildProfileId: "", Name: "", Age: "", Gender: "", PreferredPhoneNumber: "")
    @Published var dismissView:Bool = false

    func makeProfile () {
        print("CHILD: \(child)")
        child.PreferredPhoneNumber = "+91\(child.PreferredPhoneNumber)"
        CustomerProfileService().setChildProfile(child: child) { response in
            if response != nil {
                self.dismissView = true
            } else {
                print("ERROR UPLOADING")
            }
        }
    }
}

extension AddChildProfileViewModel : SideBySideCheckBoxDelegate {
    func itemChecked(value: String) {
        self.child.Gender = value
    }
}
