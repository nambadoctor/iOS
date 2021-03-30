//
//  StopwatchManager.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 3/29/21.
//

import Foundation

class StopwatchManager {
    var startTime:DispatchTime = DispatchTime.now()
    var stopTime:DispatchTime = DispatchTime.now()
    
    func start() {
        startTime = DispatchTime.now()
    }
    
    func stop() {
        stopTime = DispatchTime.now()
        let elapsedTime = (stopTime.uptimeNanoseconds - startTime.uptimeNanoseconds)/1000000
        if elapsedTime > 1000 {
            print("ELAPSED TIME: \(elapsedTime/1000)")
        } else {
            print("ELAPSED TIME: \(elapsedTime)")
        }
    }
}
