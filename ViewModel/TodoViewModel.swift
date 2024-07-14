//
//  TodoViewModel.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-15.
//

import Foundation

class TodoViewModel {
    
    private let indexObservable: Observable<Int?> = Observable(nil)
    private let filteredListObservable = Observable<[Table]>([])
    private let repository = RealmRepository()

    init() {
        
    }
    
}
