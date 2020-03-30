//
//  String+.swift
//  Translator
//
//  Created by Islam on 3/30/20.
//  Copyright © 2020 Islam. All rights reserved.
//

import Foundation

extension String{
func localizeableString(loc: String) -> String{
    let path = Bundle.main.path(forResource: loc, ofType: "lproj")
    let bundle = Bundle(path: path!)
    return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}
