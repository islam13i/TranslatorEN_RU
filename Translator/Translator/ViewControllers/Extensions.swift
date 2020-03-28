//
//  TranslatorUIController.swift
//  Translator
//
//  Created by Islam on 3/25/20.
//  Copyright © 2020 Islam. All rights reserved.
//
import Foundation
import UIKit

struct const {
    static let sectionInsets = UIEdgeInsets(top: 20.0, left: 5.0, bottom: 20.0, right: 5.0)
    static let itemsPerRow: CGFloat = 1
    static let cornerRadius: CGFloat = 5
   // static var lng = NSLocalizedString("lng", comment: "")
}

extension TranslatorViewController {
    func configureNavBar(navBar: UINavigationController) {
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           let currentText = textField.text ?? ""
           guard let stringRange = Range(range, in: currentText) else { return false }
           let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
           return updatedText.count <= 27
       }
}


extension HistoryViewController : UICollectionViewDelegateFlowLayout {
    
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let paddingSpace = const.sectionInsets.bottom * (const.itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / const.itemsPerRow
    
    return CGSize(width: widthPerItem, height: 90)
  }
    
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return const.sectionInsets
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return const.sectionInsets.bottom
  }
    
}

extension String{
    func localizeableString(loc: String) -> String{
        let path = Bundle.main.path(forResource: loc, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}
