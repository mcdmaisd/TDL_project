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
    
    func setData(_ count: Int, _ index: Int) {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
        
        icon.image = UIImage(systemName: IconNames.allCases[index].rawValue, withConfiguration: largeConfig)
        icon.tintColor = .black
        
        title.text = CellTitles.allCases[index].rawValue
        title.textColor = .white
        title.font = .boldSystemFont(ofSize: 20)
        
        self.count.text = index == 4 ? "" : "\(count)"
        self.count.textColor = .white
        self.count.font = .boldSystemFont(ofSize: 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
