//
//  ViewController.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-02.
//

import UIKit

import SnapKit

class TodoViewController: UIViewController {

    let tableView = UITableView()
    let repository = RealmRepository()
    
    var index: Int?
    var list: [Table]!
    var filteredList: [Table]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        view.backgroundColor = .white
        setList()
        configureNavBar()
        configureTableView()
    }
    
    func setList() {
        guard let index, let list else { return }
        print(list)
        if index == 0 {
            filteredList = list.filter { $0.today == true }
        } else if index == 1 {
            filteredList = list.filter { $0.future == true }
        } else if index == 2 {
            filteredList = list.filter { $0.entire == true }
        } else if index == 3 {
            filteredList = list.filter { $0.flag == true }
        } else {
            filteredList = list.filter { $0.completed == true }
        }
    }
    
    func configureNavBar() {
        let appearance = UINavigationBarAppearance()
        let right = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(pullDown))
        
        right.tintColor = .blue
        appearance.backgroundColor = .darkGray
        
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.rightBarButtonItem = right
    }
    
    @objc func pullDown() {
        
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.id)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func renewList(_ index: IndexPath) {
        tableView.beginUpdates()
        filteredList.remove(at: index.row)
        tableView.deleteRows(at: [index], with: .fade)
        tableView.endUpdates()
    }
}

extension TodoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.id) as! TodoListTableViewCell
        cell.setData(filteredList![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let data = filteredList[indexPath.row]
        let flagTitle = data.flag != nil ? "깃발 제거" : "깃발"
        let completedTitle = data.completed ? "완료 취소" : "완료"
        
        let delete = UIContextualAction(style: .normal, title: "삭제") { [self]
            (action, view, completion) in
            repository.removeItem(data)
            renewList(indexPath)
            completion(true)
        }
        
        let flag = UIContextualAction(style: .normal, title: flagTitle) { [self]
            (_, _, completion) in
            repository.updateItem(data, name: "flag")
            if index == 3 {
                renewList(indexPath)
            } else {
                tableView.reloadRows(at: [(IndexPath(row: indexPath.row , section: 0))], with: .fade)
            }
            completion(true)
        }
        
        let completed = UIContextualAction(style: .normal, title: completedTitle) { [self]
            (_, _, completion) in
            repository.updateItem(data, name: "completed")
            renewList(indexPath)
            completion(true)
        }
        
        delete.backgroundColor = .red
        flag.backgroundColor = .orange
        completed.backgroundColor = .lightGray
        
        let swipeActions =
            index == 4 ?
            UISwipeActionsConfiguration(actions: [completed, delete]) :
            UISwipeActionsConfiguration(actions: [completed, flag, delete])
        
        swipeActions.performsFirstActionWithFullSwipe = false
        return swipeActions
    }
}

