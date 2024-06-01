//
//  CreateNewArtistCell.swift
//  ArtApp
//
//  Created by Алексей on 01.06.2024.
//

import UIKit

final class DidUploadImageForNewArtistCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setConstraints()
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureCell(image: UIImage) {
        imageView.image = image
    }
}

// MARK: - Setup Cell
extension DidUploadImageForNewArtistCell {
    func setupCell() {
        setupImageView()
    }
    
    func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = translatesAutoresizingMaskIntoConstraints
        imageView.layer.cornerRadius = 10
    }
}

// MARK: - Set Constraints
extension DidUploadImageForNewArtistCell {
    func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
