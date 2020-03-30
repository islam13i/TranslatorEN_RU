//
//  TranslatorUIController.swift
//  Translator
//
//  Created by Islam on 3/25/20.
//  Copyright © 2020 Islam. All rights reserved.
//
import Foundation
import UIKit


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


