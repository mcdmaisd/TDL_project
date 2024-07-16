//
//  MainViewModel.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-15.
//

import Foundation

final class MainViewModel {
    
    private(set) var listObservable = Observable<[Table]>([])
    private let repository = RealmRepository()
    
    private var filteredList: [Table?] = []
    
    private(set) var isListUpdated: Observable<Void?> = Observable(nil)
    
    init() {
        isListUpdated.bind { _ in
            self.listObservable.value = self.repository.fetchAll()
        }
    }
    
    func filterList(_ index: Int) -> Int {
        switch index {
        case 0:
            filteredList = listObservable.value.filter { $0.today == true }
        case 1:
            filteredList = listObservable.value.filter { $0.future == true }
        case 2:
            filteredList = listObservable.value.filter { $0.entire == true }
        case 3:
            filteredList = listObservable.value.filter { $0.flag == true && $0.completed == false }
        default:
            filteredList = listObservable.value.filter { $0.completed == true }
        }
        return filteredList.count
    }
}
