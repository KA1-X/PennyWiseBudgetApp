// Created by Jiaheng Pan on 12/7/24.
//
// Models/ExpenseRecord.swift
import Foundation
import RealmSwift

class ExpenseRecord: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String = ""
    @Persisted var type: String = ""
    @Persisted var amount: String = ""
    @Persisted var date: Date = Date()
    
    var typeEnum: ExpenseTypes {
        return ExpenseTypes(rawValue: type) ?? .housing
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
}
