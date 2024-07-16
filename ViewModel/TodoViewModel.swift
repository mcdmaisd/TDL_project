//
//  TodoViewModel.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-16.
//

import Foundation

class TodoViewModel {
    
    private(set) var filteredList = Observable<[Table]>([])
    private(set) var repository = RealmRepository()
    lazy var index = Observable(-1)
    
    init() {
        index.bind { [self] value in
            filterList(value)
        }
    }
    
    func filterList(_ index: Int) {
        let list = repository.fetchAll()
        
        switch index {
        case 0:
            filteredList.value = list.filter { $0.today == true }
        case 1:
            filteredList.value = list.filter { $0.future == true }
        case 2:
            filteredList.value = list.filter { $0.entire == true }
        case 3:
            filteredList.value = list.filter { $0.flag == true && $0.completed == false }
        default:
            filteredList.value = list.filter { $0.completed == true }
        }
    }
}
