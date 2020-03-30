//
//  ViewController.swift
//  Translator
//
//  Created by Islam on 3/23/20.
//  Copyright © 2020 Islam. All rights reserved.
//

import UIKit
import Network

class TranslatorViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var enterTextInput: UITextView!
    @IBOutlet weak var translatedText: UITextView!
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
        enterTextInput.text = "inputPlaceholder".localizeableString(loc: LocalizationSystem.sharedInstance.getLanguage())
        enterTextInput.textColor = UIColor.gray
        enterTextInput.delegate = self
        enterTxtView.layer.cornerRadius = 5
        translatedTxtView.layer.cornerRadius = 5
        showHistoryBtn.titleLabel!.numberOfLines = 0;
        showHistoryBtn.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping ;
        setImagesByLang()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray || textView.text == "inputPlaceholder".localizeableString(loc: "en") || textView.text == "inputPlaceholder".localizeableString(loc: "ru"){
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text!.isEmpty {
            if LocalizationSystem.sharedInstance.checkIfEN(){
                textView.text = "inputPlaceholder".localizeableString(loc: "en")
            }else{
                textView.text = "inputPlaceholder".localizeableString(loc: "ru")
            }
            textView.textColor = UIColor.lightGray
            return
        }
        ServerManager.instance.getTranslate(completion:setTranslateToField(translate:), text: textView.text!)
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
    
    @IBAction func speachTranslated(_ sender: Any) {
        if translatedText.text.isEmpty{
            return
        }
        VoiceController.sharedInstance.speachText(text: translatedText.text)
    }
    @IBAction func changeLang(_ sender: Any) {
        
        if LocalizationSystem.sharedInstance.checkIfEN() {
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "ru")
            setTextByLocalization(lng: "ru")
            setImagesByLang()
        }
        else{
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
            setTextByLocalization(lng: "en")
            setImagesByLang()
        }
    }
    
    func setTextByLocalization(lng: String){
        enterTextInput.text = ""
        translatedText.text = ""
        showHistoryBtn.setTitle("btnTxt".localizeableString(loc: lng), for: .normal)
        ServerManager.instance.lg = "lng".localizeableString(loc: lng)
    }
    
    func setImagesByLang() {
        
        if LocalizationSystem.sharedInstance.checkIfEN(){
            imageInput.image = UIImage(named: "imageInput".localizeableString(loc: "en"))
            imageTranslated.image = UIImage(named: "imageTranslated".localizeableString(loc: "en"))
            ServerManager.instance.lg = "lng".localizeableString(loc: "en")
        }
        else{
            imageInput.image = UIImage(named: "imageInput".localizeableString(loc: "ru"))
            imageTranslated.image = UIImage(named: "imageTranslated".localizeableString(loc: "ru"))
            ServerManager.instance.lg = "lng".localizeableString(loc: "ru")
        }
    }
    
}


