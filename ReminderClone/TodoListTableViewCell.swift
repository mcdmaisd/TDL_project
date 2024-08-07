//
//  TodoListTableViewCell.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-03.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {

    let titleLabel = UILabel()
    let memoLabel = UILabel()
    let dateLabel = UILabel()
    let tagLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureConstraints()
        configureLabels()
    }
    
    func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(memoLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(tagLabel)
    }

    func setData(_ data: Table) { // 이렇게 하기 보다는 저장할때 해당 데이터 넣어서 저장하기
        titleLabel.text = data.flag ? data.memoTitle + "🚩" : data.memoTitle
        memoLabel.text = data.memoContent
        dateLabel.text = data.deadline
        tagLabel.text = data.tag
    }
    
    func configureLabels() {
        titleLabel.sizeToFit()
        titleLabel.textColor = .black
        memoLabel.sizeToFit()
        memoLabel.textColor = .gray
        dateLabel.sizeToFit()
        dateLabel.textColor = .gray
        tagLabel.sizeToFit()
        tagLabel.textColor = .blue
    }
    
    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView.safeAreaLayoutGuide).offset(5)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(5)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(5)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(5)
        }
        
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(5)
            make.leading.equalTo(dateLabel.snp.trailing).offset(5)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
