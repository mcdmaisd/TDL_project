//
//  NewTodoViewController.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-02.
//

import UIKit

import Toast

enum Priority: String, CaseIterable {
    case zero = "없음"
    case low = "낮음"
    case middle = "중간"
    case high = "높음"
    
    var caseName: String {
        return String(describing: self)
    }
}

class NewTodoViewController: UIViewController {

    private let repository = RealmRepository()
    private let tableView = UITableView()
    
    private var date: String?
    private var tag: String?
    private var priority: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        configureNavBar()
        configureTableView()
    }
    
    deinit {
        print("NewTodoViewController Deinit")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
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
            navigationItem.rightBarButtonItem?.tintColor = .blue
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else if title.isEmpty {
            navigationItem.rightBarButtonItem?.tintColor = .gray
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    @objc func back() {
        dismiss(animated: true)
    }
    
    @objc func save() {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
                as? TitleMemoTableViewCell else { return }
        let memo = cell.memoTextView
        
        let title = cell.titleTextView.text ?? ""
        let content = memo.textColor != UIColor.darkGray ? memo.text : nil
        
        if tag != nil {
            tag = "#" + (tag ?? "")
        }

        let data = Table(memoTitle: title, memoContent: content, deadline: date, tag: tag, priority: priority, today: nil, future: nil, entire: true, flag: false, completed: false)
        if date != nil {
            let todayString = Date().getToday()
            let deadline = date?.replacingOccurrences(of: ".", with: "") ?? ""
            
            if Int(deadline) == Int(todayString) {
                data.today = true
                repository.addItem(data)
            } else {
                data.future = true
                repository.addItem(data)
            }
        }
        repository.addItem(data)
        sendNotification("dataChanged")
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
       
        if index == 1 {
            selectDeadline()
        } else if index == 2 {
            setTag()
        } else if index == 3 {
            setPriority()
        }
        
        tableView.deselectRow(at: IndexPath(row: indexPath.row, section: 0), animated: true)
    }
}

extension NewTodoViewController {
    
    func selectDeadline() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let datePicker = UIDatePicker()
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "선택 완료", style: .default) { [weak self](ACTION:UIAlertAction) in
            self?.date = datePicker.date.convertedDate
            let today = Int(Date().getToday()) ?? 0
            let deadline = Int(self?.date?.replacingOccurrences(of: ".", with: "") ?? "") ?? 0
            if today > deadline {
                self?.view.makeToast("마감일이 오늘보다 이전 날짜입니다")
                return
            }
            UserDefaults.standard.setValue(self?.date, forKey: "date")
            self?.reloadCell(1)
        }
                
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko_KR")
                
        alert.addAction(ok)
        alert.addAction(cancel)
                
        let vc = UIViewController()
        vc.view = datePicker
                
        alert.setValue(vc, forKey: "contentViewController")
                
        present(alert, animated: true)
    }
    
    func setTag() {
        
        let controller = UIAlertController(title: "태그 입력", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "Ok", style: .default) { [weak self](ACTION:UIAlertAction) in
            let text = controller.textFields?.first?.text
            let removeSpace = text?.replacingOccurrences(of: " ", with: "")
           
            if removeSpace?.count != 0  {
                self?.tag = text
                UserDefaults.standard.setValue(self?.tag, forKey: "tag")
            } else {
                UserDefaults.standard.removeObject(forKey: "tag")
                self?.tag = nil
            }
            
            self?.reloadCell(2)
        }
 
        controller.addTextField()
        controller.addAction(ok)
        controller.addAction(cancel)
        controller.textFields?.first?.text = UserDefaults.standard.string(forKey: "tag")
        present(controller, animated: true)
    }
    
    func setPriority() {
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)

        for item in Priority.allCases {
            let menu = UIAlertAction(title: item.rawValue, style: .default, handler: { [weak self](ACTION:UIAlertAction) in
                self?.priority = item.caseName
                UserDefaults.standard.setValue(item.rawValue, forKey: "priority")
                self?.reloadCell(3)
            })
            alert.addAction(menu)
        }
        
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    func reloadCell(_ index: Int) {
        let cell = tableView.dequeueReusableCell(withIdentifier: OtherTableViewCell.id, for: IndexPath(row: index, section: 0)) as! OtherTableViewCell
        cell.configureViews(index)
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}

extension NewTodoViewController: MyTableViewCellDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateNavigationRightBarButtonState()
    }
}
