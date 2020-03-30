//
//  DataManager.swift
//  Translator
//
//  Created by Islam on 3/27/20.
//  Copyright © 2020 Islam. All rights reserved.
//

import RealmSwift

class DataManager {
    var   database:Realm
    static let  sharedInstance = DataManager()
    
    init() {
        database = try! Realm()
    }
    
    func getDataFromDB() ->  Results<TranslatedItem> {
        let results: Results<TranslatedItem> = database.objects(TranslatedItem.self)
        return results
    }
    
    func addData(object: TranslatedItem)   {
        try! database.write {
            database.add(object)
        }
        deleteOldItems()
    }
    
    func deleteOldItems() {
        let result = getDataFromDB()
        while result.count > 20 {
            try!   database.write {
                database.delete(result.sorted(byKeyPath: "date", ascending: false).last!)
            }
        }
    }
    
}
