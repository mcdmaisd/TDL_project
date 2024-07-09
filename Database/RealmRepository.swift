//
//  RealmRepository.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-09.
//

import Foundation
import RealmSwift

final class RealmRepository {
    private let realm = try! Realm()
    
    func detectUrl() {
        print(realm.configuration.fileURL ?? "")
    }
    
    func createItem(_ data: Table, folder: Folder) {
        
        do {
            try realm.write {
                folder.detail.append(data)
                print("create success")
            }
        } catch {
            print("realm error")
        }
    }
    
    func fetchFolder() -> [Folder] {
        let value = realm.objects(Folder.self)
        return Array(value)
    }
    
    func fetchAll(_ folder: Folder) -> [Table] {
        let value = folder.detail
        return Array(value)
    }
    
    func removeItem(_ data: Table) {
        do {
            try realm.write {
                realm.delete(data)
                print("delete success")
            }
        } catch {
            print("realm error")
        }
    }
}
