//
//  HistoryViewCell.swift
//  Translator
//
//  Created by Islam on 3/28/20.
//  Copyright © 2020 Islam. All rights reserved.
//

import UIKit

class HistoryViewCell: UICollectionViewCell {
    
        @IBOutlet weak var russianText: UILabel!
        @IBOutlet weak var englishText: UILabel!
        
        func setLabels(item: TranslatedItem) {
            russianText.text = item.rusTxt
            englishText.text = item.engTxt
        }
}

