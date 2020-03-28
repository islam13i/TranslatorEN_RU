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
    var translatedItems: Results<TranslatedItem>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        translatedItems = DataManager.sharedInstance.getDataFromDB()
        
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let count = translatedItems?.count else{
           let count = 0
           return count
        }
        return translatedItems!.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HistoryViewCell
        cell.layer.cornerRadius = uiConst.cornerRadius
        let item: TranslatedItem = (translatedItems?.sorted(byKeyPath: "date", ascending: false)[indexPath.row])!
        cell.setLabels(item: item)
        return cell
    }


}
