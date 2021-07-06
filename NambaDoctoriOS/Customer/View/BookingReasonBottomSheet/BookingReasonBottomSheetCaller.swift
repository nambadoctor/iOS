//
//  BookingReasonBottomSheetCaller.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/6/21.
//

import SwiftUI

struct BookingReasonBottomsheetCaller: View {

    @Binding var offset:CGFloat
    var preBookingOptions:[String]
    var preBookingOptionsCallback:(String)->()
    
    var body: some View {
        
        ZStack{
            VStack{
                
                Spacer()

                BookingReasonBottomSheet(bottomSheetOffset: $offset, preBookingOptionsReasons: self.preBookingOptions, preBookingOptionsCallback: preBookingOptionsCallback)
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
