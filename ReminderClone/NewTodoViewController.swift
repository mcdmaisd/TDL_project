//
//  NewTodoViewController.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-02.
//

import UIKit

class NewTodoViewController: UIViewController {

    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        configureNavBar()
        configureTableView()
    }
    
    func configureNavBar() {
        let appearance = UINavigationBarAppearance()
        let left = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(back))
        let right = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(save))
        
        left.tintColor = .blue
        right.tintColor = .gray
        appearance.backgroundColor = .darkGray
        
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.title = "새로운 할 일"
        navigationItem.leftBarButtonItem = left
        navigationItem.rightBarButtonItem = right
    }
    
    func updateNavigationRightBarButtonState() {
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TitleMemoTableViewCell,
           !cell.titleTextView.text.isEmpty {
            print("not empty")
            navigationItem.rightBarButtonItem?.tintColor = .blue
        } else {
            print("empty")
            navigationItem.rightBarButtonItem?.tintColor = .gray
        }
    }
    
    @objc func back() {
        print(#function)
        dismiss(animated: true)
    }
    
    @objc func save() {
        print(#function)
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(TitleMemoTableViewCell.self, forCellReuseIdentifier: TitleMemoTableViewCell.id)
        tableView.register(OtherTableViewCell.self, forCellReuseIdentifier: OtherTableViewCell.id)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension NewTodoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        if index == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TitleMemoTableViewCell.id, for: indexPath) as! TitleMemoTableViewCell
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: OtherTableViewCell.id, for: indexPath) as! OtherTableViewCell
            cell.configureViews(index)
            return cell
        }
    }
}

extension NewTodoViewController: MyTableViewCellDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateNavigationRightBarButtonState()
    }
}
