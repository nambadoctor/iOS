//
//  BubbledSelector.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 26/03/21.
//

import SwiftUI

struct BubbledSelector: View {
    var array:[String] = foodSelectionArray
    @State var selected:String = "AnyTime"
    
    var body: some View {
        VStack {
            TagCloudView(tags: ["Apple", "Google", "Amazon", "Microsoft", "Oracle", "Facebook"])
        }
    }
}

struct BubbledSelector_Previews: PreviewProvider {
    static var previews: some View {
        BubbledSelector()
    }
}
