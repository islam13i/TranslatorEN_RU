//
//  TranslatorUIController.swift
//  Translator
//
//  Created by Islam on 3/25/20.
//  Copyright © 2020 Islam. All rights reserved.
//
import Foundation
import UIKit

struct uiConst {
    static let sectionInsets = UIEdgeInsets(top: 20.0, left: 5.0, bottom: 20.0, right: 5.0)
    static let itemsPerRow: CGFloat = 1
    static let cornerRadius: CGFloat = 5
}

extension TranslatorViewController {
    func configureNavBar(navBar: UINavigationController) {
        //navBar.navigationBar.frame.size.height. = 84.0
        navBar.navigationBar.barTintColor = #colorLiteral(red: 0.4509803922, green: 0.8823529412, blue: 0.8823529412, alpha: 1)
        navBar.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navBar.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    }
    
}

extension TranslatorViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension HistoryViewController : UICollectionViewDelegateFlowLayout {
    
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let paddingSpace = uiConst.sectionInsets.bottom * (uiConst.itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / uiConst.itemsPerRow
    
    return CGSize(width: widthPerItem, height: 90)
  }
    
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return uiConst.sectionInsets
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return uiConst.sectionInsets.bottom
  }
    
}

