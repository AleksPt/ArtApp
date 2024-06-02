//
//  ArtistDetailViewController.swift
//  ArtApp
//
//  Created by Алексей on 30.05.2024.
//

import UIKit

final class ArtistDetailViewController: UIViewController {
    
    // MARK: - Public properties
    var artist: Artist?
    
    // MARK: - Private properties
    private var works = [Work]()
    
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
        collectionView.register(ArtistDetailCell.self, forCellWithReuseIdentifier: ArtistDetailCell.description())
        collectionView.register(HeaderArtistDetail.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderArtistDetail.description())
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
    
    func configure(_ item: Artist) {
        title = item.name
        works = item.works
        artist = item
    }
}

// MARK: - Setup View
extension ArtistDetailViewController {
    func setupView() {
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(collectionView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
            withReuseIdentifier: ArtistDetailCell.description(),
            for: indexPath
        ) as? ArtistDetailCell else {
            return UICollectionViewCell()
        }
        
        let work = works[indexPath.item]
        cell.configureCell(imageName: work.image)
        
        return cell
    }
    
}

// MARK: - Collection View Delegate
extension ArtistDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = WorkDetailViewController()
        vc.works = works
        vc.item = indexPath.item
        present(vc, animated: true)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - Collection View Delegate Flow Layout
extension ArtistDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderArtistDetail.description(), for: indexPath) as? HeaderArtistDetail else {
            return UICollectionReusableView()
        }
        
        if let artist {
            header.configureHeader(artist)
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: UIScreen.main.bounds.width)
    }
}
