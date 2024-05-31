//
//  WorkDetailViewController.swift
//  ArtApp
//
//  Created by Алексей on 30.05.2024.
//

import UIKit

final class WorkDetailViewController: UIViewController {
    
    // MARK: - Public properties
    var works = [Work]()
    var item: Int?
    
    // MARK: - Private properties
    private let closeButton = UIButton()
    
    // MARK: - Private properties
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: view.frame, collectionViewLayout: createSectionLayout())
        collection.register(WorkDetailCell.self, forCellWithReuseIdentifier: WorkDetailCell.description())
        collection.dataSource = self
        collection.backgroundColor = .black
        collection.alpha = 0.99
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        scrollToItem()
        setConstraints()
    }
    
    // MARK: - Private methods
    private func scrollToItem() {
        collectionView.scrollToItem(
            at: IndexPath(item: item ?? 0, section: 0),
            at: .centeredHorizontally,
            animated: false
        )
    }
    
    @objc private func closeVC() {
        dismiss(animated: true)
    }
}

// MARK: - Setup View
extension WorkDetailViewController {
    func setupView() {
        view.addSubview(collectionView)
        view.backgroundColor = .black
        view.alpha = 0.99
        setupCloseButton()
    }
    
    func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.tintColor = .white
    }
    
}

// MARK: - Set Constraints
extension WorkDetailViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            
            collectionView.topAnchor.constraint(equalTo: closeButton.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Setup Collection Layout
extension WorkDetailViewController {
    
    func createSectionLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] _, _ in
            self?.createSection()
        }
    }
    
    func createSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
}

// MARK: - Collection View Data Source
extension WorkDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        works.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WorkDetailCell.description(),
            for: indexPath
        ) as? WorkDetailCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(works[indexPath.item])
        
        return cell
    }
}
