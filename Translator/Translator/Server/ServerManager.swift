//
//  ServerManager.swift
//  eNotes
//
//  Created by Yan Saraev on 7/22/17.
//  Copyright © 2017 4taps. All rights reserved.
//

import Foundation

import Alamofire


class ServerManager {
    var scheme = "https"
    var domain = "translate.yandex.net"
    var version = "v1.5"
    var apiKey = "key=trnsl.1.1.20200323T111541Z.f04360c447bd9312.b30592c4e341e3d3a209e0434e40c61fa7246134"
    var endpoint: String = "translate?"
    var param: String = "lang="
    var lg: String = "lng".localizeableString(loc: "en")

    static let instance = ServerManager()
}



extension ServerManager {

    func getTranslate( completion: @escaping (String)-> (), text: String) {
        let urlString = getURLString(text: text)
        guard let url = URL(string: urlString) else{ return }
        AF.request(url).validate().responseDecodable(of: Translate.self) { (response) in
            guard let translate = response.value else { return print(DispatchQueue.main.async {
                completion("connection".localizeableString(loc: self.lg))
            }) }
            DispatchQueue.main.async {
                completion(translate.text[0])
            }
        }
    }
    func getURLString(text: String) -> String {
        let toTranslate = text.encodeUrl
        return "\(scheme)://\(domain)/api/\(version)/tr.json/\(endpoint)\(apiKey)&text=\(toTranslate)&\(param)\(lg)"
    }
    
    
}

extension String{
    var encodeUrl : String
    {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl : String
    {
        return self.removingPercentEncoding!
    }
}
