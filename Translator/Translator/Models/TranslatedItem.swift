//
//  translatedItem.swift
//  Translator
//
//  Created by Islam on 3/27/20.
//  Copyright © 2020 Islam. All rights reserved.
//

import Foundation
import RealmSwift

class TranslatedItem: Object {
    @objc dynamic var rusTxt: String = ""
    @objc dynamic var engTxt: String = ""
    @objc dynamic var date: Date = Date()
    
}
