//
//  VoiceController.swift
//  Translator
//
//  Created by Islam on 3/30/20.
//  Copyright © 2020 Islam. All rights reserved.
//

import Foundation
import AVFoundation
class VoiceController {
    
    class var sharedInstance: VoiceController {
        struct Singleton {
            static let instance: VoiceController = VoiceController()
        }
        return Singleton.instance
    }
    func speachText(text: String){
        let utterance = AVSpeechUtterance(string: text)
        if LocalizationSystem.sharedInstance.checkIfEN() {
            utterance.voice = AVSpeechSynthesisVoice(language: "lng".localizeableString(loc: "en"))
        }else{
            utterance.voice = AVSpeechSynthesisVoice(language: "lng".localizeableString(loc: "ru"))
        }
        utterance.rate = 0.5
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}
