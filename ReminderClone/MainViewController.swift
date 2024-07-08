//
//  MainViewController.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-08.
//

import UIKit

class MainViewController: UIViewController {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    let addButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureNavBar()
        setUI()
        configureConstraints()
    }
    
    func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(addButton)
    }
    
    func configureNavBar() {
        let appearance = UINavigationBarAppearance()
        let right = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(pullDown))
        
        right.tintColor = .blue
        appearance.backgroundColor = .darkGray
        
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.rightBarButtonItem = right
    }
    
    @objc func pullDown() {
        
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let inset: CGFloat = 10
        let width = UIScreen.main.bounds.width - 3 * inset
        layout.itemSize = CGSize(width: width / 2, height: 100)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = inset
        layout.minimumLineSpacing = inset
        layout.sectionInset = UIEdgeInsets.init(top: inset, left: inset, bottom: inset, right: inset)
        return layout
    }
    
    func setUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.id)
        addButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        addButton.setTitle("새로운 알림", for: .normal)
        addButton.setTitleColor(.blue, for: .normal)
        addButton.semanticContentAttribute = .forceLeftToRight
        addButton.sizeToFit()
        addButton.addTarget(self, action: #selector(addTodo), for: .touchUpInside)
    }
    
    @objc func addTodo() {
        let nav = UINavigationController(rootViewController: NewTodoViewController())
        self.present(nav, animated: true)
    }
    
    func configureConstraints() {
        addButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(addButton.snp.top)
        }
    }
    

    

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.id, for: indexPath) as! MainCollectionViewCell
        cell.setData(indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(ViewController(), animated: true)
    }
    
    
}