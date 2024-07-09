//
//  ViewController.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-02.
//

import UIKit

import RealmSwift
import SnapKit

class ViewController: UIViewController {

    let tableView = UITableView()
    let repository = RealmRepository()
    let realm = try! Realm()
    
    var index: Int?
    var list: [Table]!
    var folder: [Folder]!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        folder = repository.fetchFolder()
        list = repository.fetchAll(folder[index!])
        repository.detectUrl()
        configureNavBar()
        configureTableView()
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
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.id) as! TodoListTableViewCell
        cell.setData(list![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let data = list![indexPath.row]
        
        let delete = UIContextualAction(style: .normal, title: "삭제") { [self]
            (action, view, completion) in
            tableView.beginUpdates()
            repository.removeItem(data)
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            NotificationCenter.default.post(name: NSNotification.Name("add"), object: nil, userInfo: nil)
            completion(true)
        }
        
        let flag = UIContextualAction(style: .normal, title: "깃발") { [self]
            (action, view, completion) in
            let folder = folder![3]
            repository.createItem(data, folder: folder)
            NotificationCenter.default.post(name: NSNotification.Name("add"), object: nil, userInfo: nil)
            completion(true)

        }
        
        let completed = UIContextualAction(style: .normal, title: "완료") { [self]
            (action, view, completion) in
            let folder = folder![4]
            repository.createItem(data, folder: folder)
            // 
            completion(true)

        }
        
        delete.backgroundColor = .red
        flag.backgroundColor = .orange
        completed.backgroundColor = .lightGray
        
        let swipeActions = UISwipeActionsConfiguration(actions: [completed, flag, delete])
        swipeActions.performsFirstActionWithFullSwipe = false
        
        return swipeActions
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        let data = list![indexPath.row]
//        
//        if editingStyle == .delete {
//            tableView.beginUpdates()
//            try! realm?.write {
//                realm?.delete(data)
//            }
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.endUpdates()
//        }
//    }
    
}

