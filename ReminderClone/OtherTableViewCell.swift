//
//  OtherTableViewCell.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-02.
//

import UIKit

enum Options: String, CaseIterable {
    case deadline = "마감일"
    case tag = "태그"
    case priority = "우선순위"
    case addImages = "이미지 추가"
}

class OtherTableViewCell: UITableViewCell {

    let titleLabel = UILabel()
    let rightImageView = UIImageView(image: UIImage(systemName: "chevron.right"))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(rightImageView)
    }
    
    func configureViews(_ index: Int) {
        print(#function)
        let index = index - 1
        
        titleLabel.text = Options.allCases[index].rawValue
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 10)
        
        rightImageView.tintColor = .black
        
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
    
    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

