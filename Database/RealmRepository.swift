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
    
    func addItem(_ data: Table) {
        
        do {
            try realm.write {
                realm.add(data)
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
    
    func fetchAll() -> [Table] {
        let value = realm.objects(Table.self)
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
    
    
    func updateItem(_ data: Table, name: String) {
        do {
            try realm.write {
                if name == "flag" {
                    data.flag.toggle()
                } else if name == "completed" {
                    data.completed.toggle()
                    data.entire.toggle()
                    //if data.flag != nil { data.flag?.toggle() }
                    if data.today != nil { data.today?.toggle() }
                    if data.future != nil { data.future?.toggle() }
                }
                
                realm.add(data, update: .modified)
                print("update success")
            }
        } catch {
            print("realm error")
        }
    }
}
