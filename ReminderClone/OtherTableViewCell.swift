//
//  OtherTableViewCell.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-02.
//

import UIKit


class OtherTableViewCell: UITableViewCell {

    let titleLabel = UILabel()
    let dataLabel = UILabel()
    let rightImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        
    private var date = UserDefaults.standard.string(forKey: "date")
    private var tags = UserDefaults.standard.string(forKey: "tag")
    private var priority = UserDefaults.standard.string(forKey: "priority")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print(#function, "init")
        addSubviews()
        configureConstraints()
    }
    
    func addSubviews() {
        print(#function)
        contentView.addSubview(titleLabel)
        contentView.addSubview(rightImageView)
        contentView.addSubview(dataLabel)
    }
    
    func configureViews(_ index: Int) {
        print(#function)
        let index = index - 1
        titleLabel.text = Options.allCases[index].rawValue
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 10)
        
        if index == 0 { dataLabel.text = date }
        else if index == 1 { dataLabel.text = tags }
        else if index == 2 { dataLabel.text = priority }
        
        dataLabel.textColor = .black
        dataLabel.font = .systemFont(ofSize: 10)
                    
        rightImageView.tintColor = .black
        
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
    
    func configureConstraints() {
        print(#function)

        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        dataLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
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

