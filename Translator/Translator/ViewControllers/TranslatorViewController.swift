//
//  ViewController.swift
//  Translator
//
//  Created by Islam on 3/23/20.
//  Copyright © 2020 Islam. All rights reserved.
//

import UIKit

class TranslatorViewController: UIViewController {
    
    @IBOutlet weak var enterTextInput: UITextField!
    @IBOutlet weak var translatedText: UITextField!
    @IBOutlet weak var enterTxtView: UIView!
    @IBOutlet weak var translatedTxtView: UIView!
    
    var langStr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        langStr = Locale.current.languageCode
    }
    func configureUI() {
        configureNavBar(navBar: self.navigationController!)
        enterTextInput.delegate = self
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        ServerManager.instance.getTranslate(completion:setTranslateToField(translate:), text: textField.text!)
    }
    
    func setTranslateToField(translate: String) {
        translatedText.text = translate
        addItemToHistory()
    }
    
    func addItemToHistory(){
        let translateItem = TranslatedItem()
        if langStr == "en"{
            translateItem.engTxt = enterTextInput.text!
            translateItem.rusTxt = translatedText.text!
            
        }else{
            translateItem.rusTxt = enterTextInput.text!
            translateItem.engTxt = translatedText.text!
        }
        
        DataManager.sharedInstance.addData(object: translateItem)
    }
    
}


