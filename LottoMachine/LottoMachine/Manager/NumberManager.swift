//
//  NumberManager.swift
//  LottoMachine
//
//  Created by lee on 2018. 2. 11..
//  Copyright © 2018년 smith. All rights reserved.
//

import Foundation
import RealmSwift

class NumberManager {
    let realm = try! Realm()
    
    func save(objc: Object) {
        try! realm.write {
            realm.add(objc)
        }
    }
    
    func getNumbers(type: Number.Type) -> Results<Number>? {
        return realm.objects(type)
    }
    
    func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func delete(objc: Object) {
        try! realm.write {
            realm.delete(objc)
        }
    }
}
