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
    
    func save(objc: Number) {
        try! realm.write {
            realm.add(objc)
        }
    }
    
    func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func delete(num: Number) {
        try! realm.write {
            realm.delete(num)
        }
    }
}
