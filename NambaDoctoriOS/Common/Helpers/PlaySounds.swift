//
//  PlaySounds.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/19/21.
//

import Foundation
import AVFoundation

class PlaySounds {
    var soundName:String
    var type:String
    var audioPlayer: AVAudioPlayer?
    
    init(soundName:String, type:String) {
        self.soundName = soundName
        self.type = type
    }
    
    func playSound () {
        let path = Bundle.main.path(forResource: soundName, ofType: type)!
        let url = URL(fileURLWithPath: path)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = 200
            audioPlayer?.play()
        } catch {
            // couldn't load file :(
        }
    }

    func stopSound () {
        audioPlayer?.stop()
    }
}
