//
//  StopwatchManager.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 3/29/21.
//

import Foundation

class StopwatchManager {
    private var startTime:DispatchTime = DispatchTime.now()
    private var stopTime:DispatchTime = DispatchTime.now()
    private var callingClass:String
    
    init(callingClass:String) {
        self.callingClass = callingClass
    }
    
    func start() {
        startTime = DispatchTime.now()
    }
    
    func stop() {
        stopTime = DispatchTime.now()
        let elapsedTime = (stopTime.uptimeNanoseconds - startTime.uptimeNanoseconds)/1000000
        print("ELAPSED TIME \(callingClass): \(elapsedTime)")
    }
}
