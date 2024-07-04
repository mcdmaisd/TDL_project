//
//  NewTodoViewController.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-02.
//

import UIKit

import RealmSwift

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
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func updateNavigationRightBarButtonState() {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TitleMemoTableViewCell else { return }
        let title = cell.titleTextView.text ?? ""
        
        if !title.isEmpty {
            print("not empty")
            navigationItem.rightBarButtonItem?.tintColor = .blue
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else if title.isEmpty {
            print("empty")
            navigationItem.rightBarButtonItem?.tintColor = .gray
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    @objc func back() {
        print(#function)
        dismiss(animated: true)
    }
    
    @objc func save() {
        print(#function)
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
                as? TitleMemoTableViewCell else { return }
        let title = cell.titleTextView.text ?? ""
        let content = cell.memoTextView.text ?? ""
        let deadline = UserDefaults.standard.string(forKey: "date")
        let tag = UserDefaults.standard.string(forKey: "tag")
        let data = Table(memoTitle: title, memoContent: content, deadline: deadline, tag: tag)
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(data)
            print("Realm create succeed")
        }
        dismiss(animated: true)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: OtherTableViewCell.id, for: indexPath) as! OtherTableViewCell
        
        if index == 1 {
            selectDeadline()
        } else if index == 2 {
            setTag()
        } else if index == 3 {
            //setPriority()
        } else if index == 4 {
            
        }
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}

extension NewTodoViewController {
    func selectDeadline() {
        var date = Date()

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let datePicker = UIDatePicker()
        let ok = UIAlertAction(title: "선택 완료", style: .default) { action in
            date = datePicker.date.convertedDate
            print(date)
        }
                
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko_KR")
                
        alert.addAction(ok)
                
        let vc = UIViewController()
        vc.view = datePicker
                
        alert.setValue(vc, forKey: "contentViewController")
                
        present(alert, animated: true)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let dateString = dateFormatter.string(from: date)
        UserDefaults.standard.setValue(dateString, forKey: "date")
    }
    
    func setTag() {
        let controller = UIAlertController(title: "태그 입력", message: "", preferredStyle: .alert)
        
        controller.addTextField()
        
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            if let textfield = controller.textFields?.first {
                UserDefaults.standard.setValue(textfield.text, forKey: "tag")
            }
        }

        controller.addAction(ok)
        present(controller, animated: true)
    }
}

extension Date {
    var convertedDate: Date {
        let dateFormatter = DateFormatter()
        let dateFormat = "yyyy.MM.dd"
        dateFormatter.dateFormat = dateFormat
        let formattedDate = dateFormatter.string(from: self)

        dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")

        dateFormatter.dateFormat = dateFormat
        let sourceDate = dateFormatter.date(from: formattedDate)

        return sourceDate!
    }
}
extension NewTodoViewController: MyTableViewCellDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateNavigationRightBarButtonState()
    }
}
