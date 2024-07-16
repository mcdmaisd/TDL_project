//
//  TodoViewModel.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-16.
//

import Foundation

enum ErrorCase: Error {
    case emptyList
}

class TodoViewModel {
    
    private(set) var filteredList = Observable<[Table]>([])
    private(set) var repository = RealmRepository()
    lazy var index = Observable(-1)
    
    init() {
        index.bind { [self] value in
            filterList(value) { response in
                switch response {
                case.success(let list):
                    self.filteredList.value = list
                case.failure(_):
                    self.filteredList.value = []
                }
            }
        }
    }
    
    func filterList(_ index: Int, completion: @escaping (Result<[Table], Error>) -> Void) {
        let list = repository.fetchAll()
        var result: [Table]
        
        switch index {
        case 0:
            result = list.filter { $0.today == true }
        case 1:
            result = list.filter { $0.future == true }
        case 2:
            result = list.filter { $0.entire == true }
        case 3:
            result = list.filter { $0.flag == true && $0.completed == false }
        default:
            result = list.filter { $0.completed == true }
        }
                
        if result.count == 0 {
            completion(.failure(ErrorCase.emptyList))
        } else {
            completion(.success(result))
        }
    }
}
