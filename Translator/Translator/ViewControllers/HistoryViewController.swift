//
//  HistoryViewController.swift
//  Translator
//
//  Created by Islam on 3/27/20.
//  Copyright © 2020 Islam. All rights reserved.
//

import UIKit
import RealmSwift


class HistoryViewController: UICollectionViewController {
    private let reuseIdentifier = "cell"
    
    let sectionInsets = UIEdgeInsets(top: 20.0, left: 5.0, bottom: 20.0, right: 5.0)
    var translatedItems: Results<TranslatedItem>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        translatedItems = DataManager.sharedInstance.getDataFromDB()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let count = translatedItems?.count else{
            return 0
        }
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HistoryViewCell
        cell.contentView.isUserInteractionEnabled = true
        cell.layer.cornerRadius = 5
        let item: TranslatedItem = (translatedItems?.sorted(byKeyPath: "date", ascending: false)[indexPath.row])!
        cell.setLabels(item: item)
        return cell
    }
}

extension HistoryViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.bottom * (1 + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / 1
        if let item = translatedItems?.sorted(byKeyPath: "date", ascending: false)[indexPath.row] {
            
            
            let approximateWidthOfBioTextView = view.frame.width - 12 - 50 - 12 - 2
            let size = CGSize(width: approximateWidthOfBioTextView, height: 1000)
            
            let estimatedFrame = NSString(string: item.rusTxt + item.engTxt).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: nil, context: nil)
            
            return CGSize(width: widthPerItem, height: estimatedFrame.height + 110)
        }
        
        return CGSize(width: widthPerItem, height: 100)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInsets.bottom
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
}

