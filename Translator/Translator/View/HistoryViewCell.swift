//
//  HistoryViewCell.swift
//  Translator
//
//  Created by Islam on 3/28/20.
//  Copyright © 2020 Islam. All rights reserved.
//

import UIKit

final class HistoryViewCell: UICollectionViewCell {
    @IBOutlet weak var russianText: UITextView!
    @IBOutlet weak var englishText: UITextView!
    @IBOutlet weak var speachBtn: UIButton!
    
    static let reuseIdentifier = String(describing: HistoryViewCell.self)
    
    func setLabels(item: TranslatedItem) {
        russianText.text = item.rusTxt
        englishText.text = item.engTxt
    }
    @IBAction func speachTranslated(_ sender: UIButton, forEvent event: UIEvent) {
        VoiceController.sharedInstance.speachText(text: englishText.text)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("touch")
    }
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
           setNeedsLayout()
           layoutIfNeeded()
           let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
           var frame = layoutAttributes.frame
           frame.size.height = ceil(size.height)
           layoutAttributes.frame = frame
           return layoutAttributes
       }
}

