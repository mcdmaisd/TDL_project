//
//  ViewController.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-02.
//

import UIKit

import SnapKit

class TodoViewController: UIViewController {
    
    let titleLabel = UILabel()
    let tableView = UITableView()
    let viewModel = TodoViewModel()
    
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initIndex()
        configureNavBar()
        configureTableView()
        bindData()
    }
    
    func initIndex() {
        guard let index else { return }
        viewModel.index.value = index
    }
    
    func bindData() {
        viewModel.filteredList.bind { _ in
            print("reload")
            self.tableView.reloadData()
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
    
    func renewList(_ value: String, data: Table) {
        if value == "delete" {
            viewModel.repository.removeItem(data)
        } else {
            viewModel.repository.updateItem(data, name: value)
        }
        viewModel.index.value = self.index ?? 0
        sendNotification("dataChanged")
    }
}

extension TodoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.id) as! TodoListTableViewCell
        cell.setData(viewModel.filteredList.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let data = viewModel.filteredList.value[indexPath.row]
        let flagTitle = data.flag ? "깃발 제거" : "깃발"
        let completedTitle = data.completed ? "완료 취소" : "완료"
        
        let delete = UIContextualAction(style: .normal, title: "삭제") { [self]
            (action, view, completion) in
            renewList("delete", data: data)
            completion(true)
        }
        
        let flag = UIContextualAction(style: .normal, title: flagTitle) { [self]
            (_, _, completion) in
            renewList("flag", data: data)
            completion(true)
        }
        
        let completed = UIContextualAction(style: .normal, title: completedTitle) { [self]
            (_, _, completion) in
            renewList("completed", data: data)
            completion(true)
        }
        
        delete.backgroundColor = .red
        flag.backgroundColor = .orange
        completed.backgroundColor = .lightGray
        
        let swipeActions =
            UISwipeActionsConfiguration(actions: [completed, flag, delete])
        
        swipeActions.performsFirstActionWithFullSwipe = false
        return swipeActions
    }
}

