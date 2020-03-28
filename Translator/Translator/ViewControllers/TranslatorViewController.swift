//
//  ViewController.swift
//  Translator
//
//  Created by Islam on 3/23/20.
//  Copyright © 2020 Islam. All rights reserved.
//

import UIKit
import Network

class TranslatorViewController: UIViewController {
    
    @IBOutlet weak var enterTextInput: UITextField!
    @IBOutlet weak var translatedText: UITextField!
    @IBOutlet weak var enterTxtView: UIView!
    @IBOutlet weak var translatedTxtView: UIView!
    @IBOutlet weak var showHistoryBtn: UIButton!
    @IBOutlet weak var imageInput: UIImageView!
    @IBOutlet weak var imageTranslated: UIImageView!
    
    let monitor = NWPathMonitor()
    var langStr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    func configureUI() {
        configureNavBar(navBar: self.navigationController!)
        enterTextInput.delegate = self
        showHistoryBtn.titleLabel!.numberOfLines = 0;
        showHistoryBtn.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping ;
        setImagesByLang()
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
        if LocalizationSystem.sharedInstance.checkIfEN(){
            translateItem.engTxt = enterTextInput.text!
            translateItem.rusTxt = translatedText.text!
            
        }else{
            translateItem.rusTxt = enterTextInput.text!
            translateItem.engTxt = translatedText.text!
        }
        
        DataManager.sharedInstance.addData(object: translateItem)
    }
    
    @IBAction func changeLang(_ sender: Any) {
        
        if LocalizationSystem.sharedInstance.checkIfEN() {
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "ru")
            enterTextInput.placeholder = "inputPlaceholder".localizeableString(loc: "ru")
            enterTextInput.text = ""
            translatedText.text = ""
            showHistoryBtn.setTitle("btnTxt".localizeableString(loc: "ru"), for: .normal)
            ServerManager.instance.lg = "lng".localizeableString(loc: "ru")
            setImagesByLang()
        }
        else{
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
            enterTextInput.placeholder = "inputPlaceholder".localizeableString(loc: "en")
            enterTextInput.text = ""
            translatedText.text = ""
            showHistoryBtn.setTitle("btnTxt".localizeableString(loc: "en"), for: .normal)
             ServerManager.instance.lg = "lng".localizeableString(loc: "en")
            setImagesByLang()
        }
        
    }
    
    func setImagesByLang() {
        
        if LocalizationSystem.sharedInstance.checkIfEN(){
            imageInput.image = UIImage(named: "imageInput".localizeableString(loc: "en"))
            imageTranslated.image = UIImage(named: "imageTranslated".localizeableString(loc: "en"))
        }
        else{
            imageInput.image = UIImage(named: "imageInput".localizeableString(loc: "ru"))
            imageTranslated.image = UIImage(named: "imageTranslated".localizeableString(loc: "ru"))
        }
    }
}


