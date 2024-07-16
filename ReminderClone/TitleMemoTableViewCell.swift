//
//  NewTodoTableViewCell.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-02.
//

import UIKit

protocol MyTableViewCellDelegate: AnyObject {
    func textViewDidChange(_ textView: UITextView)
}

class TitleMemoTableViewCell: UITableViewCell {

    let textView = UIView()
    let titleTextView = UITextView()
    let memoTextView = UITextView()
    let separator = UIView()
    let width = UIScreen.main.bounds.width

    weak var delegate: MyTableViewCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureViews()
        configureConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(textView)
        contentView.addSubview(titleTextView)
        contentView.addSubview(memoTextView)
        contentView.addSubview(separator)
    }
    
    func configureConstraints() {
        textView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(5)
        }
        
        titleTextView.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.top)
            make.horizontalEdges.equalTo(textView).inset(10)
            make.height.equalTo(width / 6)
        }
        
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom)
            make.horizontalEdges.equalTo(textView).inset(10)
            make.height.equalTo(width / 3)
            make.bottom.equalTo(textView.snp.bottom)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(titleTextView.snp.bottom)
            make.height.equalTo(1)
            make.leading.equalTo(textView.snp.leading).offset(10)
            make.trailing.equalTo(textView)
        }
    }
    
    func configureViews() {
        titleTextView.text = "제목"
        titleTextView.textColor = .darkGray
        titleTextView.backgroundColor = .clear
        titleTextView.delegate = self

        memoTextView.text = "메모"
        memoTextView.textColor = .darkGray
        memoTextView.backgroundColor = .clear
        memoTextView.delegate = self
       
        separator.layer.borderColor = UIColor.black.cgColor
        separator.layer.borderWidth = 1
        
        textView.backgroundColor = .lightGray
        textView.layer.cornerRadius = 10
        textView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TitleMemoTableViewCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == titleTextView {
            delegate?.textViewDidChange(textView)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView == titleTextView {
            if textView.textColor == .darkGray {
                textView.text = ""
                textView.textColor = .white
            }
        } else {
            if textView.textColor == .darkGray {
                textView.text = ""
                textView.textColor = .white
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView == titleTextView {
            if textView.text.isEmpty {
                textView.text = "제목"
                textView.textColor = .darkGray
            }
        } else {
            if textView.text.isEmpty {
                textView.text = "메모"
                textView.textColor = .darkGray
            }
        }
    }
}
