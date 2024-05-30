//
//  ArtistDetailViewController.swift
//  ArtApp
//
//  Created by Алексей on 30.05.2024.
//

import UIKit

final class ArtistDetailViewController: UIViewController {
    
    // MARK: - Public properties
    var works = [Work]()
    
    // MARK: - Private properties
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumLineSpacing = 25
        collectionViewLayout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.register(WorkCell.self, forCellWithReuseIdentifier: WorkCell.description())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(
            top: 0,
            left: 25,
            bottom: 0,
            right: 25
        )
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
    }
}

// MARK: - Setup View
extension ArtistDetailViewController {
    func setupView() {
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(collectionView)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Collection View Data Source
extension ArtistDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        works.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WorkCell.description(),
            for: indexPath
        ) as? WorkCell else {
            return UICollectionViewCell()
        }
        
        let work = works[indexPath.item]
        cell.configureCell(imageName: work.image)
        
        return cell
    }
}

// MARK: - Collection View Delegate
extension ArtistDetailViewController: UICollectionViewDelegate {
    
}
