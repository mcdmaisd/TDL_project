//
//  MainCollectionViewCell.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-08.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    let icon = UIImageView()
    let title = UILabel()
    let count = UILabel()
    let iconNames = ["calendar.badge.exclamationmark", "calendar", "folder", "flag.fill", "checkmark.circle"]
    let titles = ["오늘", "예정", "전체", "깃발표시", "완료됨"]
    let repository = RealmRepository()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .gray
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        addSubviews()
        configureConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(icon)
        contentView.addSubview(title)
        contentView.addSubview(count)
    }
    
    func configureConstraints() {
        icon.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(5)
        }
        
        title.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(5)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(5)
        }
        
        count.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(5)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(5)
        }
    }
    
    func setData(_ list: [Table], _ index: Int) {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)

        var filteredList: [Table]
        
        icon.image = UIImage(systemName: iconNames[index], withConfiguration: largeConfig)
        icon.tintColor = .black
        
        title.text = titles[index]
        title.textColor = .white
        
        if index == 0 {
            filteredList = list.filter { $0.today == true }
        } else if index == 1 {
            filteredList = list.filter { $0.future == true }
        } else if index == 2 {
            filteredList = list.filter { $0.entire == true }
        } else if index == 3 {
            filteredList = list.filter { $0.flag == true }
        } else {
            filteredList = []
        }
        
        count.text = index == 4 ? "" : "\(filteredList.count)"
        count.textColor = .white
        count.font = .boldSystemFont(ofSize: 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
