//
//  Translate.swift
//  Translator
//
//  Created by Islam on 3/26/20.
//  Copyright © 2020 Islam. All rights reserved.
//

import Foundation

struct Translate: Codable{
    var code: Int
    var lang: String
    var text: [String]
}

struct DetectedLang: Codable{
    var lang:String
}

