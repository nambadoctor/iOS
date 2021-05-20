//
//  CancellationBottomsheetCaller.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/19/21.
//

import Foundation
import SwiftUI

struct CancellationBottomsheetCaller: View {

    @Binding var offset:CGFloat
    var delegate:DoctorCancellationDelegate

    var body: some View {
        
        ZStack{
            VStack{
                
                Spacer()

                CancellationBottomSheet(bottomSheetOffset: $offset, delegate: delegate)
                .offset(y: self.offset)
                .gesture(DragGesture()
                
                    .onChanged({ (value) in
                        
                        if value.translation.height > 0{
                            
                            self.offset = value.location.y
                            
                        }
                    })
                    .onEnded({ (value) in
                        
                        if self.offset > 100{
                            
                            self.offset = UIScreen.main.bounds.height
                        }
                        else{
                            
                            self.offset = 0
                        }
                    })
                )
                
            }.background((self.offset <= 100 ? Color(UIColor.label).opacity(0.3) : Color.clear).edgesIgnoringSafeArea(.all)
                .onTapGesture {
                
                self.offset = 0
                
            })
            
            .edgesIgnoringSafeArea(.bottom)
            
        }.animation(.default)
    }
}
