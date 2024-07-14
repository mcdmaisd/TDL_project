//
//  MainViewModel.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-15.
//

import Foundation

final class MainViewModel {
    
    private let listObservable = Observable<[Table]>([])
    private let repository = RealmRepository()
    
    private var filteredList: [Table?] = []
    
    private(set) var isListUpdated: Observable<Void?> = Observable(nil)
    
    init() {
        updateList()
    }
    
    func readList() -> [Table] {
        print(#function)
        return listObservable.value
    }

    private func updateList() {
        print(#function)
        listObservable.value = repository.fetchAll()
    }
    
    func filterList(_ index: Int) -> [Table?] {
        updateList()
        switch index {
        case 0:
            filteredList = listObservable.value.filter { $0.today == true }
        case 1:
            filteredList = listObservable.value.filter { $0.future == true }
        case 2:
            filteredList = listObservable.value.filter { $0.entire == true }
        case 3:
            filteredList = listObservable.value.filter { $0.flag == true }
        default:
            filteredList = listObservable.value.filter { $0.completed == true }
        }
        return filteredList
    }
}
