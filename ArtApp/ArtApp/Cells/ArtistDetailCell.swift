//
//  WorkCell.swift
//  ArtApp
//
//  Created by Алексей on 30.05.2024.
//

import UIKit

final class ArtistDetailCell: UICollectionViewCell {
    
    // MARK: - Private properties
    private let imageView = UIImageView()
    
    // MARK: - Override methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func configureCell(imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
    
    // MARK: - Private methods
    private func setupView() {
        addSubview(imageView)
        setupImageView()
    }
    
    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
    }
    
    private func setConstraints() {
        let width = widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 - 37.5)
        width.priority = .defaultHigh
        let height = heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 - 37.5)
        height.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            width,
            height
        ])
    }
}

