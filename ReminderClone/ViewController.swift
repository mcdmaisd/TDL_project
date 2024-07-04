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
    let realm = try? Realm()

    var list: Results<Table>!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        list = realm?.objects(Table.self)
        print(realm?.configuration.fileURL)
        configureNavBar()
        configureTableView()
    }
    
    func configureNavBar() {
        let appearance = UINavigationBarAppearance()
        let left = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(back))
        let right = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(pullDown))
        
        left.tintColor = .blue
        right.tintColor = .blue
        appearance.backgroundColor = .darkGray
        
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.leftBarButtonItem = left
        navigationItem.rightBarButtonItem = right
    }
    
    @objc func back() {
        let nav = UINavigationController(rootViewController: NewTodoViewController())
        self.present(nav, animated: true)
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
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.id) as! TodoListTableViewCell
        cell.setData(list[indexPath.row])
        return cell
    }
    
    
}

