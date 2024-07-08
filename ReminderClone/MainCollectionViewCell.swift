//
//  MainCollectionViewCell.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-08.
//

import UIKit

import RealmSwift

class MainCollectionViewCell: UICollectionViewCell {
    
    let realm = try? Realm()
    let icon = UIImageView()
    let title = UILabel()
    let count = UILabel()
    let iconNames = ["calendar.badge.exclamationmark", "calendar", "folder", "flag.fill", "checkmark.circle"]
    let titles = ["오늘", "예정", "전체", "깃발표시", "완료됨"]
    
    var list: Results<Table>!

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .gray
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        list = realm?.objects(Table.self)
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
    
    func setData(_ index: Int) {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
        //반복문
        icon.image = UIImage(systemName: iconNames[index], withConfiguration: largeConfig)
        icon.tintColor = .black
        title.text = titles[index]
        title.textColor = .white
        if index == 2 {
            count.text = "\(list.count)"
        } else {
            count.text = "0"
        }
        count.textColor = .white
        count.font = .boldSystemFont(ofSize: 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
